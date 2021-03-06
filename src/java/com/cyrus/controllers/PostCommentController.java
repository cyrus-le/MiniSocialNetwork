/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.cyrus.controllers;

import java.io.IOException;
import java.sql.SQLException;
import javax.naming.NamingException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import com.cyrus.daos.CommentsDAO;
import com.cyrus.daos.NotificationDAO;
import com.cyrus.dtos.CommentsDTO;
import com.cyrus.dtos.NotificationDTO;
import com.cyrus.dtos.UsersDTO;
import org.apache.log4j.Logger;

/**
 *
 * @author Cyrus
 */
public class PostCommentController extends HttpServlet {

    private static final Logger logger = Logger.getLogger(PostCommentController.class);
    private final CommentsDTO dto = new CommentsDTO();
    private NotificationDTO notiDTO = null;

    private void createNewComment(final HttpServletRequest req) throws SQLException, NamingException {
        int postID = Integer.parseInt(req.getParameter("txtPostID"));
        UsersDTO user = ((UsersDTO) req.getSession().getAttribute("USER"));
        String content = req.getParameter("txtComment");
        String email = user.getEmail();
        dto.setPostID(postID);
        dto.setContent(content);
        dto.setEmail(email);
    }

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try {

            String authorPost = request.getParameter("txtAuthorPost");

            createNewComment(request);
            CommentsDAO dao = new CommentsDAO();
            dao.insert(dto);

            notiDTO = new NotificationDTO(dto.getPostID(), dto.getEmail(), String.valueOf(System.currentTimeMillis()), "comment");

            NotificationDAO.getInstance().insert(notiDTO);

        } catch (SQLException | NamingException e) {
            logger.error("Error CommentController at: " + e.getMessage());
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
