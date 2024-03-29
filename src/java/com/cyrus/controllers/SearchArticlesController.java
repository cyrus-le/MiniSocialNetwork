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
import com.cyrus.dtos.ArticlesDTO;
import com.cyrus.dtos.UsersDTO;
import org.apache.log4j.Logger;

/**
 *
 * @author Cyrus
 */
@MultipartConfig
public class SearchArticlesController extends HttpServlet {

    private static final Logger logger = Logger.getLogger(SearchArticlesController.class);
    private final static ArticlesDAO DAO = ArticlesDAO.getInstance();
    private final static Integer POST_PER_PAGE = 5;

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        String search = request.getParameter("txtSearch");

        try {
            UsersDTO userDTO = (UsersDTO) request.getSession().getAttribute("USER");
            String email = userDTO.getEmail();

            int pageNum = 0;
            if (request.getParameter("page") != null) {
                pageNum = Integer.parseInt(request.getParameter("page"));
            }
            int numberRecords = DAO.getAllRecordsBySearching(search);
            int start = pageNum * POST_PER_PAGE;
            int totalPageNum = numberRecords / POST_PER_PAGE;
            if (numberRecords % POST_PER_PAGE != 0) {
                totalPageNum++;
            }

            List<ArticlesDTO> list = DAO.findByLikeName(search, start, POST_PER_PAGE);
            if (list != null) {
                request.setAttribute("LIST", list);
                request.setAttribute("PAGE", totalPageNum);
                request.setAttribute("CURPAGE", pageNum);
            } else {
                request.setAttribute("ERROR", "Cannot find the article");
            }
        } catch (SQLException | NamingException | ParseException | ClassNotFoundException e) {
            logger.error("Error SearchArticlesController at: " + e.getMessage());
        } finally {
            request.getRequestDispatcher("index.jsp").forward(request, response);
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

