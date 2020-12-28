/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.cyrus.controllers;

import java.io.IOException;
import java.sql.SQLException;
import java.text.ParseException;
import java.util.List;
import javax.naming.NamingException;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import com.cyrus.daos.ArticlesDAO;
import com.cyrus.daos.CommentsDAO;
import com.cyrus.daos.EmotionDAO;
import com.cyrus.dtos.ArticlesDTO;
import com.cyrus.dtos.CommentsDTO;
import com.cyrus.dtos.EmotionDTO;
import org.apache.log4j.Logger;

/**
 *
 * @author Cyrus
 */
@MultipartConfig
public class ViewDetailController extends HttpServlet {

    private final static Logger logger = Logger.getLogger(ViewDetailController.class);
    private int postID;

    private void viewArticle(final HttpServletRequest req) throws SQLException, NamingException, ParseException {

        ArticlesDAO dao = new ArticlesDAO();

        ArticlesDTO dto = dao.get(postID);
        req.setAttribute("DTO", dto);

    }

    private void viewComment(final HttpServletRequest req) throws SQLException, ParseException, NamingException {

        CommentsDAO commentDAO = new CommentsDAO();

        List<CommentsDTO> listComment = commentDAO.getAllCommentsByPostID(postID);
        CommentsDTO commentDTO = commentDAO.get(postID);
        req.setAttribute("COMMENT", listComment);
        req.setAttribute("COMMENT_DTO", commentDTO);
    }

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try {

            int txtPostID = Integer.parseInt(request.getParameter("txtPostID"));
            EmotionDAO dao = new EmotionDAO();

            postID = txtPostID;
            viewArticle(request);
            viewComment(request);

            EmotionDTO dto = dao.countEmotionOfPostID(postID);

            if (dto == null) {
                request.setAttribute("LIKE", 0);
                request.setAttribute("DISLIKE", 0);
            } else {
                request.setAttribute("LIKE", dto.getLike());
                request.setAttribute("DISLIKE", dto.getDislike());
            }

        } catch (SQLException | NamingException | ParseException ex) {
            ex.printStackTrace();
            logger.error("Error ViewDetailController at: " + ex.getMessage());
        } finally {
            request.getRequestDispatcher("viewDetail.jsp").forward(request, response);
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

