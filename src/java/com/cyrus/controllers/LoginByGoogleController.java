/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.cyrus.controllers;

import com.cyrus.daos.UsersDAO;
import com.cyrus.dtos.GoogleDTO;
import com.cyrus.dtos.UsersDTO;
import com.cyrus.utils.GoogleUtils;
import java.io.IOException;
import java.sql.SQLException;
import javax.naming.NamingException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.apache.log4j.Logger;

/**
 *
 * @author Cyrus
 */
public class LoginByGoogleController extends HttpServlet {

    private static final Logger logger = Logger.getLogger(LoginByGoogleController.class);
    private static final String ERROR = "login.jsp";
    private static final String SUCCESS = "SocialNetworkController";
    private static final UsersDAO userDAO = UsersDAO.getInstance();

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        String url = ERROR;
        try {
            String code = request.getParameter("code");
            System.out.println(code);
            if (code != null || !code.isEmpty()) {
                String accessToken = GoogleUtils.getToken(code);
                GoogleDTO googleDTO = GoogleUtils.getUserInfo(accessToken);
                String email = googleDTO.getEmail();
                HttpSession session = request.getSession();
                UsersDTO dto = userDAO.checkExistedEmailGoogle(email);
                if (dto != null) {
                    url = SUCCESS;
                    session.setAttribute("USER", dto);
                    session.setAttribute("NAME", dto.getName());
                    session.setAttribute("MEMBER", dto);
                } else {
                    int index = email.indexOf("@");
                    String name = email.substring(0, index);
                    dto = new UsersDTO(email, name, null, "member", null);
                    boolean check = userDAO.insert(dto);
                    if (check) {
                        userDAO.updateStatusActivate(email);
                        session.setAttribute("USER", dto);
                        session.setAttribute("NAME", name);
                        session.setAttribute("MEMBER", dto);
                        url = SUCCESS;
                    } else {
                        request.setAttribute("ERROR", "Login by Google unsucessfully");
                    }

                }
            }
        } catch (IOException | NamingException | SQLException e) {
            logger.error("Error LoginByGoogle at: " + e.getMessage());
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
