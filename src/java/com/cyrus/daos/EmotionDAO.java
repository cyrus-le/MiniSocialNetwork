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
import java.util.Date;
import javax.naming.NamingException;
import com.cyrus.db.MyConnection;
import com.cyrus.dtos.ArticlesDTO;
import com.cyrus.dtos.EmotionDTO;

/**
 *
 * @author Cyrus
 */
public class EmotionDAO {

    private Connection conn;
    private PreparedStatement preStm;
    private ResultSet rs;
    private static EmotionDAO instance;

    public static EmotionDAO getInstance() {
        if (instance == null) {
            instance = new EmotionDAO();
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

    public boolean checkReactEmotionWithSameAccount(String email, int postID) throws SQLException, NamingException {
        boolean check = false;
        try {
            String sql = "SELECT EmotionID FROM tbl_Emotion WHERE Email = ? AND PostID = ?";
            conn = MyConnection.getConnection();
            if (conn != null) {
                preStm = conn.prepareStatement(sql);
                preStm.setString(1, email);
                preStm.setInt(2, postID);
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

    public boolean insertEmotions(EmotionDTO dto) throws NamingException, SQLException {
        boolean check = false;
        try {
            String sql = "INSERT INTO tbl_Emotion(PostID, Email, [Like], Dislike, Date) VALUES(?,?,?,?,?)";
            conn = MyConnection.getConnection();
            preStm = conn.prepareStatement(sql);
            preStm.setInt(1, dto.getPostID());
            preStm.setString(2, dto.getEmail());
            preStm.setInt(3, dto.getLike());
            preStm.setInt(4, dto.getDislike());
            preStm.setLong(5, System.currentTimeMillis());
            check = preStm.executeUpdate() > 0;
        } finally {
            closeConnection();
        }
        return check;
    }

    public boolean updateLikeAndDislike(EmotionDTO dto, int postID, String email) throws SQLException, NamingException {
        boolean check = false;
        try {
            String sql = "UPDATE tbl_Emotion SET [Like] = ?, Dislike = ? WHERE PostID = ? AND Email = ?";
            conn = MyConnection.getConnection();
            preStm = conn.prepareStatement(sql);
            preStm.setInt(1, dto.getLike());
            preStm.setInt(2, dto.getDislike());
            preStm.setInt(3, postID);
            preStm.setString(4, email);
            check = preStm.executeUpdate() > 0;
        } finally {
            closeConnection();
        }
        return check;
    }

    public EmotionDTO countEmotionOfPostID(int postID) throws SQLException, NamingException {
        EmotionDTO dto = null;
        try {
            String sql = "SELECT PostID,\n"
                    + "SUM([Like]) AS Dem_Like,\n"
                    + "SUM(Dislike) AS DEM_Dislike\n"
                    + "FROM tbl_Emotion\n"
                    + "WHERE PostID = ?\n"
                    + "GROUP BY tbl_Emotion.PostID";
            conn = MyConnection.getConnection();
            preStm = conn.prepareStatement(sql);
            preStm.setInt(1, postID);
            rs = preStm.executeQuery();
            if (rs.next()) {
                dto = new EmotionDTO(postID, null, rs.getInt(2), rs.getInt(3), null);
            }
        } finally {
            closeConnection();
        }
        return dto;
    }

    public EmotionDTO get(int postID, String email) throws NamingException, SQLException, ParseException {
        EmotionDTO dto = null;
        int emotionID, like, dislike;
        String date;
        try {
            String sql = "SELECT EmotionID, PostID, Email, [Like], Dislike, Date FROM tbl_Emotion WHERE PostID = ? AND Email = ?";
            conn = MyConnection.getConnection();
            preStm = conn.prepareStatement(sql);
            preStm.setInt(1, postID);
            preStm.setString(2, email);
            rs = preStm.executeQuery();
            if (rs.next()) {
                emotionID = rs.getInt("EmotionID");;
                email = rs.getString("Email");
                like = rs.getInt("Like");
                dislike = rs.getInt("Dislike");
                String txtDate = rs.getString("Date");
                long dateTime = Long.parseLong(txtDate);
                date = convertDateToString(new Date(dateTime));
                dto = new EmotionDTO(emotionID, postID, email, like, dislike, date);
                System.out.println(dto.toString());

            }
        } finally {
            closeConnection();
        }
        return dto;
    }
}


