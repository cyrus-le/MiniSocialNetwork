/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.cyrus.controllers;

import java.io.IOException;

import java.sql.SQLException;
import java.text.ParseException;
import javax.naming.NamingException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import com.cyrus.daos.EmotionDAO;
import com.cyrus.daos.NotificationDAO;
import com.cyrus.dtos.EmotionDTO;
import com.cyrus.dtos.NotificationDTO;
import com.cyrus.dtos.UsersDTO;
import org.apache.log4j.Logger;

/**
 *
 * @author Cyrus
 */
public class ReactEmotionsController extends HttpServlet {

    private static final Logger logger = Logger.getLogger(ReactEmotionsController.class);
    private NotificationDTO notiDTO = null;

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try {

            int postID = Integer.parseInt(request.getParameter("txtPostID"));
            
            UsersDTO user = ((UsersDTO) request.getSession().getAttribute("USER"));
            String email = user.getEmail();
            String react = request.getParameter("txtReact");

            EmotionDAO dao = new EmotionDAO();
            EmotionDTO dto = new EmotionDTO();
            if (dao.checkReactEmotionWithSameAccount(email, postID)) {
                dto = dao.get(postID, email);
                if (dto != null) {
                    if (react.equals("liked") && dto.getLike() == 0) {
                        notiDTO = new NotificationDTO(postID, email, String.valueOf(System.currentTimeMillis()), "like");
                        dto.setLike(1);
                        dto.setDislike(0);
                    } else if (react.equals("disliked") && dto.getDislike() == 0) {
                        notiDTO = new NotificationDTO(postID, email, String.valueOf(System.currentTimeMillis()), "dislike");
                        dto.setLike(0);
                        dto.setDislike(1);
                    }
                    dao.updateLikeAndDislike(dto, postID, email);
                }
            } else {
                dto.setPostID(postID);
                dto.setEmail(email);
                if (react.equals("liked")) {
                    dto.setLike(1);
                    notiDTO = new NotificationDTO(postID, email, String.valueOf(System.currentTimeMillis()), "like");
                } else if (react.equals("disliked")) {
                    notiDTO = new NotificationDTO(postID, email, String.valueOf(System.currentTimeMillis()), "dislike");
                    dto.setDislike(1);
                }
                dao.insertEmotions(dto);
            }

            boolean check = NotificationDAO.getInstance().insert(notiDTO);

        } catch (NumberFormatException | SQLException | NamingException | ParseException e) {
            e.printStackTrace();
            logger.error("Error ReactEmotionsController at: " + e.getMessage());
        } finally {
            request.getRequestDispatcher("ViewDetailController").forward(request, response);
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
