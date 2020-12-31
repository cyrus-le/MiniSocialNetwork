/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.cyrus.daos;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import javax.naming.NamingException;
import com.cyrus.db.MyConnection;
import com.cyrus.dtos.NotificationDTO;

/**
 *
 * @author Cyrus
 */
public class NotificationDAO implements ICRUDRepository<NotificationDTO, String> {

    private Connection conn;
    private PreparedStatement preStm;
    private ResultSet rs;
    private static NotificationDAO instance;

    public static NotificationDAO getInstance() {
        if (instance == null) {
            instance = new NotificationDAO();
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

    private String convertDateToString(Date txtDate) throws ParseException {
        return new SimpleDateFormat("yyyy-MM-dd  HH:mm:ss z").format(txtDate);
    }

    @Override
    public boolean insert(NotificationDTO dto) throws SQLException, NamingException {
        boolean check = false;
        try {
            String sql = "INSERT INTO tbl_Notify(PostID, Email, Date, Type) VALUES (?,?,?,?)";
            conn = MyConnection.getConnection();
            if (conn != null) {
                preStm = conn.prepareStatement(sql);
                preStm.setInt(1, dto.getPostID());
                preStm.setString(2, dto.getEmail());
                preStm.setString(3, dto.getDate());
                preStm.setString(4, dto.getType());
                check = preStm.executeUpdate() > 0;
            }
        } finally {
            closeConnection();
        }
        return check;
    }

    public List<NotificationDTO> getAllNotificationByEmail(String email) throws SQLException, ParseException, NamingException {
        String date, type, reacter, commenter, title;
        int postID, notifyID;
        NotificationDTO dto;
        List<NotificationDTO> result = null;
        try {
            String sql = "SELECT NotifyID, noti.PostID, noti.Email, \n"
                    + "noti.Date, Type, emotion.Email as Reacter, \n"
                    + "comment.Email as Commenter, article.Title \n"
                    + "FROM tbl_Notify noti LEFT JOIN tbl_Comments comment \n"
                    + "ON noti.PostID = comment.PostID\n"
                    + "LEFT JOIN tbl_Emotion emotion\n"
                    + "ON noti.PostID = emotion.PostID\n"
                    + "LEFT JOIN tbl_Articles article\n"
                    + "ON noti.PostID = article.PostID\n"
                    + "WHERE noti.Email = ?";
            conn = MyConnection.getConnection();
            if (conn != null) {
                preStm = conn.prepareStatement(sql);
                preStm.setString(1, email);
                rs = preStm.executeQuery();
                result = new ArrayList<>();
                while (rs.next()) {
                    notifyID = rs.getInt("NotifyID");
                    postID = rs.getInt("PostID");
                    date = convertDateToString(new Date(Long.parseLong(rs.getString("Date"))));
                    type = rs.getString("Type");
                    reacter = rs.getString("Reacter");
                    commenter = rs.getString("Commenter");
                    title = rs.getString("Title");
                    dto = new NotificationDTO(notifyID, postID, email, date, type, commenter, reacter, title);
                    result.add(dto);
                }
            }
        } finally {
            closeConnection();
        }
        return result;
    }

    @Override
    public boolean delete(NotificationDTO dto) throws SQLException, NamingException {
        boolean check = false;
        try {
            String sql = "DELETE FROM tbl_Notify WHERE NotifyID = ?";
            conn = MyConnection.getConnection();
            if (conn != null) {
                preStm = conn.prepareStatement(sql);
                preStm.setInt(1, dto.getNotifyID());
                check = preStm.executeUpdate() > 0;
            }
        } finally {
            closeConnection();
        }
        return check;

    }

    public NotificationDTO get(int id) throws SQLException, NamingException, ParseException {
        NotificationDTO dto = null;
        try {
            String sql = "SELECT NotifyID, PostID, Email, Date, Type FROM tbl_Notify WHERE NotifyID = ?";
            conn = MyConnection.getConnection();
            if (conn != null) {
                preStm = conn.prepareStatement(sql);
                preStm.setInt(1, id);
                rs = preStm.executeQuery();
                if (rs.next()) {
                    dto = new NotificationDTO(id, rs.getInt("PostID"), rs.getString("Email"), convertDateToString(new Date(Long.parseLong(rs.getString("Date")))), rs.getString("Type"));
                }
            }
        } finally {
            closeConnection();
        }
        return dto;

    }

    @Override
    public boolean update(NotificationDTO k, String v) throws SQLException, NamingException {
        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }

    @Override
    public NotificationDTO get(String v) throws SQLException, NamingException {
        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }

}
