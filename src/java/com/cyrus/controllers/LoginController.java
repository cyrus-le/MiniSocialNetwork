/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.cyrus.controllers;

import java.io.IOException;

import javax.servlet.ServletException;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import com.cyrus.daos.UsersDAO;
import com.cyrus.dtos.UserErrorObj;
import com.cyrus.dtos.UsersDTO;
import com.cyrus.utils.EncryptUtil;
import org.apache.log4j.Logger;

/**
 *
 * @author Cyrus
 */
public class LoginController extends HttpServlet {

    private static final Logger logger = Logger.getLogger(LoginController.class);
    private static final String ERROR = "login.jsp";
    private static final String SUCCESS = "SocialNetworkController";

    private static final UserErrorObj errorObj = new UserErrorObj();

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        String url = ERROR;

        try {

            UsersDAO dao = new UsersDAO();
            String email = request.getParameter("txtEmail");

            String encryptedPassword = EncryptUtil.encryptPassword(request.getParameter("txtPassword"));

            UsersDTO dto = dao.checkLogin(email, encryptedPassword);

            if (dto == null) {
                errorObj.setNotExistedError("Couldn't find your account or your account is not activated");
                request.setAttribute("ERROR", errorObj);

            } else {

                String name = dao.getName(email, encryptedPassword);

                HttpSession session = request.getSession();
                session.setAttribute("NAME", name);
                session.setAttribute("USER", dto);
                switch (dto.getRole()) {
                    case "admin":
                        url = SUCCESS;
                        session.setAttribute("ADMIN", dto);
                        break;
                    case "member":
                        url = SUCCESS;
                        session.setAttribute("MEMBER", dto);
                        break;
                    case "failed":
                        errorObj.setEmailError("Your account is not available");
                        request.setAttribute("ERROR", errorObj);
                        break;
                    default:
                        request.setAttribute("ERROR", "You are not authenticated");
                        break;
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
            logger.error("Error LoginController at: " + e.getMessage());

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
