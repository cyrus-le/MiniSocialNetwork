/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.cyrus.controllers;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.apache.log4j.Logger;

/**
 *
 * @author Cyrus
 */
@MultipartConfig
public class MainController extends HttpServlet {

    private static final Logger logger = Logger.getLogger(MainController.class);
    private static final String ERROR = "error.jsp";
    private static final String LOGIN = "LoginController";
    private static final String SIGNUP = "SignUpController";
    private static final String LOGOUT = "LogoutController";
    private static final String SEARCH = "SearchArticlesController";
    private static final String POST = "PostTheArticleController";
    private static final String VIEW_DETAIL = "ViewDetailController";
    private static final String COMMENT = "PostCommentController";
    private static final String DELETE_ARTICLE = "DeleteTheArticleController";
    private static final String DELETE_COMMENT = "DeleteCommentController";
    private static final String REACT = "ReactEmotionsController";
    private static final String ACTIVATE = "ActivateTheAccountController";

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        String url = ERROR;
        try {
            String action = request.getParameter("action");
            switch (action) {
                case "Login":
                    url = LOGIN;
                    break;
                case "Signup":
                    url = SIGNUP;
                    break;
                case "Logout":
                    url = LOGOUT;
                    break;
                case "Search":
                    url = SEARCH;
                    break;
                case "Post the article":
                    url = POST;
                    break;
                case "View Detail":
                    url = VIEW_DETAIL;
                    break;
                case "React":
                    url = REACT;
                    break;
                case "Comment":
                    url = COMMENT;
                    break;
                case "Delete":
                    url = DELETE_ARTICLE;
                    break;
                case "Delete Comment":
                    url = DELETE_COMMENT;
                    break;
                case "Verify":
                    url = ACTIVATE;
                    break;
                default:
                    request.setAttribute("ERROR", "Invalid action detected");

            }
        } catch (Exception e) {
            e.printStackTrace();
            logger.error("Error at MainController: " + e.getMessage());
        } finally {
            request.getRequestDispatcher(url).forward(request, response);
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


