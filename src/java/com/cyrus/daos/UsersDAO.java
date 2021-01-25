/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.cyrus.daos;

import static java.lang.Math.random;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Random;
import javax.naming.NamingException;
import com.cyrus.db.MyConnection;
import com.cyrus.dtos.UsersDTO;

/**
 *
 * @author Cyrus
 */
public class UsersDAO implements ICRUDRepository<UsersDTO, String> {

    private Connection conn;
    private PreparedStatement preStm;
    private ResultSet rs;
    private static UsersDAO instance;

    public static UsersDAO getInstance() {
        if (instance == null) {
            instance = new UsersDAO();
        }
        return instance;
    }

    private void closeConnection() throws SQLException {
        if (rs != null) {
            rs.close();
        }
        if (preStm != null) {
            preStm.close();
        }
        if (conn != null) {
            conn.close();
        }
    }


    public boolean checkActivateCode(String code, String email) throws SQLException, NamingException {
        boolean check = false;
        try {
            String sql = "SELECT Email FROM tbl_Users WHERE Email = ? AND Code = ?";
            conn = MyConnection.getConnection();
            if (conn != null) {
                preStm = conn.prepareStatement(sql);
                preStm.setString(1, email);
                preStm.setString(2, code);
                rs = preStm.executeQuery();
                if (rs.next()) {
                    check = true;
                }
            }
        } finally {
            closeConnection();
        }
        return check;
    }

    public boolean updateStatusActivate(String email) throws SQLException, NamingException {
        boolean check = false;
        try {
            String sql = "UPDATE tbl_Users SET Status = ? WHERE Email = ?";
            conn = MyConnection.getConnection();
            if (conn != null) {
                preStm = conn.prepareStatement(sql);
                preStm.setString(1, "Active");
                preStm.setString(2, email);
                check = preStm.executeUpdate() > 0;
            }
        } finally {
            closeConnection();
        }
        return check;
    }

    public UsersDTO checkLogin(String email, String password) throws Exception {
        String role = "failed";
        UsersDTO dto = null;
        try {
            String sql = "SELECT Role FROM tbl_Users WHERE Email = ? AND Password = ? AND Status = ?";
            conn = MyConnection.getConnection();
            if (conn != null) {
                preStm = conn.prepareStatement(sql);
                preStm.setString(1, email);
                preStm.setString(2, password);
                preStm.setString(3, "Active");
                rs = preStm.executeQuery();
                if (rs.next()) {
                    role = rs.getString("Role");
                    dto = new UsersDTO(email, null, null, role, null);
                }
            }
        } finally {
            closeConnection();
        }
        return dto;
    }

    public String getName(String email, String password) throws Exception {
        String name = null;
        try {
            String sql = "SELECT Name FROM tbl_Users WHERE Email = ? AND Password = ?";
            conn = MyConnection.getConnection();
            if (conn != null) {
                preStm = conn.prepareStatement(sql);
                preStm.setString(1, email);
                preStm.setString(2, password);
                rs = preStm.executeQuery();
                if (rs.next()) {
                    name = rs.getString("Name");
                }
            }

        } finally {
            closeConnection();
        }
        return name;
    }

    @Override
    public boolean insert(UsersDTO dto) throws SQLException, NamingException {
        boolean check = false;
        try {

            String sql = "INSERT INTO tbl_Users(Email, Name, Password, Role, Status, Code) VALUES (?,?,?,?,?,?)";
            conn = MyConnection.getConnection();
            if (conn != null) {
                preStm = conn.prepareStatement(sql);
                preStm.setString(1, dto.getEmail());
                preStm.setString(2, dto.getName());
                preStm.setString(3, dto.getPassword());
                preStm.setString(4, dto.getRole());
                preStm.setString(5, "New");
                preStm.setString(6, dto.getCode());

                check = preStm.executeUpdate() > 0;
            }
        } finally {
            closeConnection();
        }
        return check;
    }

    @Override
    public boolean delete(UsersDTO k) throws SQLException, NamingException {
        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }

    @Override
    public boolean update(UsersDTO k, String v) throws SQLException, NamingException {
        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }

    public UsersDTO checkExistedEmailGoogle(String email) throws SQLException, NamingException {
        boolean check = false;
        UsersDTO dto = null;
        try {
            String sql = "SELECT Email, Password, Name, Role, Status, Code FROM tbl_Users WHERE Email = ?";
            conn = MyConnection.getConnection();
            if (conn != null) {
                preStm = conn.prepareStatement(sql);
                preStm.setString(1, email);
                rs = preStm.executeQuery();
                if (rs.next()) {
                    String password = rs.getString("Password");
                    String name = rs.getString("Name");
                    String role = rs.getString("Role");
                    String status = rs.getString("Status");
                    dto = new UsersDTO(email, name, password, role, status, null);
                }
            }
        } finally {
            closeConnection();
        }
        return dto;
    }

    @Override
    public UsersDTO get(String v) throws SQLException, NamingException {
        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }

}
