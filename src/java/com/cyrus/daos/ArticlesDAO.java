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
import com.cyrus.dtos.ArticlesDTO;

/**
 *
 * @author Cyrus
 */
public class ArticlesDAO implements ICRUDRepository<ArticlesDTO, String> {

    private Connection conn;
    private PreparedStatement preStm;
    private ResultSet rs;
    private static ArticlesDAO instance;

    public static ArticlesDAO getInstance() {
        if (instance == null) {
            instance = new ArticlesDAO();
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

    public List<ArticlesDTO> getAllArticles(int offset, int next) throws NamingException, SQLException, ParseException {
        List<ArticlesDTO> result = null;
        int postID, countComment;
        String title, description, image, email, status, date;
        ArticlesDTO dto;
        try {
            String sql = "SELECT tbl_Articles.PostID, tbl_Articles.Title, "
                    + "tbl_Articles.Description, tbl_Articles.Image, "
                    + "tbl_Articles.Date, tbl_Articles.Email, tbl_Articles.Status, "
                    + "COUNT(tbl_Comments.PostID) As CommentCount FROM tbl_Articles "
                    + "FULL OUTER JOIN tbl_Comments ON tbl_Articles.PostID = tbl_Comments.PostID "
                    + "WHERE tbl_Articles.Status = 'Active' GROUP BY tbl_Articles.PostID, "
                    + "tbl_Articles.Title, tbl_Articles.Description, "
                    + "tbl_Articles.Image, tbl_Articles.Date, tbl_Articles.Email, "
                    + "tbl_Articles.Status ORDER BY tbl_Articles.PostID "
                    + "OFFSET ? ROWS FETCH FIRST ? ROWS ONLY";
            conn = MyConnection.getConnection();
            if (conn != null) {
                preStm = conn.prepareStatement(sql);
                preStm.setInt(1, offset);
                preStm.setInt(2, next);
                rs = preStm.executeQuery();
                result = new ArrayList<>();
                while (rs.next()) {
                    postID = rs.getInt("PostID");
                    title = rs.getString("Title");
                    description = rs.getString("Description");
                    image = rs.getString("Image");
                    String txtDate = rs.getString("Date");
                    long dateTime = Long.parseLong(txtDate);
                    date = convertDateToString(new Date(dateTime));
                    email = rs.getString("Email");
                    status = rs.getString("Status");
                    countComment = rs.getInt("CommentCount");
                    dto = new ArticlesDTO(postID, title, description, image, date, email, status, countComment);
                    result.add(dto);
                }
            }
        } catch (NumberFormatException | SQLException | ParseException | NamingException e) {
            e.printStackTrace();

        } finally {
            closeConnection();
        }
        return result;

    }

    public List<ArticlesDTO> findByLikeName(String search, int offset, int next) throws NamingException, SQLException, ParseException, NumberFormatException {
        List<ArticlesDTO> result = null;
        int postID, countComment;
        String title, description, image, email, status, date;
        ArticlesDTO dto;
        try {
            String sql = "SELECT tbl_Articles.PostID, tbl_Articles.Title, "
                    + "tbl_Articles.Description, tbl_Articles.Image, "
                    + "tbl_Articles.Date, tbl_Articles.Email, tbl_Articles.Status, "
                    + "COUNT(tbl_Comments.PostID) As CommentCount FROM tbl_Articles "
                    + "FULL OUTER JOIN tbl_Comments ON tbl_Articles.PostID = tbl_Comments.PostID "
                    + "WHERE (tbl_Articles.Description LIKE '%" + search + "%' OR  tbl_Articles.Title LIKE '%" + search + "%') AND tbl_Articles.Status = 'Active' GROUP BY tbl_Articles.PostID, "
                    + "tbl_Articles.Title, tbl_Articles.Description, "
                    + "tbl_Articles.Image, tbl_Articles.Date, tbl_Articles.Email, "
                    + "tbl_Articles.Status ORDER BY tbl_Articles.PostID "
                    + "OFFSET ? ROWS FETCH FIRST ? ROWS ONLY";
            conn = MyConnection.getConnection();
            if (conn != null) {
                preStm = conn.prepareStatement(sql);
//                preStm.setString(1, search);
                preStm.setInt(1, offset);
                preStm.setInt(2, next);
                rs = preStm.executeQuery();
                result = new ArrayList<>();
                while (rs.next()) {
                    postID = rs.getInt("PostID");
                    title = rs.getString("Title");
                    description = rs.getString("Description");
                    image = rs.getString("Image");
                    String txtDate = rs.getString("Date");
                    long dateTime = Long.parseLong(txtDate);
                    date = convertDateToString(new Date(dateTime));
                    email = rs.getString("Email");
                    status = rs.getString("Status");
                    countComment = rs.getInt("CommentCount");
                    dto = new ArticlesDTO(postID, title, description, image, date, email, status, countComment);
                    result.add(dto);
                }
            }
        } catch (NumberFormatException | SQLException | ParseException | NamingException e) {
            e.printStackTrace();

        } finally {
            closeConnection();
        }
        return result;
    }

    public int getAllRecordsByAuthor(String email) throws SQLException, ClassNotFoundException, NamingException {
        int numberRecord = 0;
        String sql = "SELECT COUNT(*) FROM tbl_Articles WHERE Status = 'Active' AND Email = ?";
        try {
            conn = MyConnection.getConnection();
            if (conn != null) {
                preStm = conn.prepareStatement(sql);
                preStm.setString(1, email);
                rs = preStm.executeQuery();
                if (rs.next()) {
                    numberRecord = rs.getInt(1);
                }
            }
        } finally {
            closeConnection();
        }

        return numberRecord;
    }

    public int getAllRecords() throws SQLException, ClassNotFoundException, NamingException {
        int numberRecord = 0;
        String sql = "SELECT COUNT(*) FROM tbl_Articles WHERE Status = 'Active'";
        try {
            conn = MyConnection.getConnection();
            if (conn != null) {
                preStm = conn.prepareStatement(sql);
                rs = preStm.executeQuery();
                if (rs.next()) {
                    numberRecord = rs.getInt(1);
                }
            }
        } finally {
            closeConnection();
        }

        return numberRecord;
    }

    public List<ArticlesDTO> findByLikeNameByAuthor(String email, String search, int offset, int next) throws NamingException, SQLException, ParseException, NumberFormatException {
        List<ArticlesDTO> result = null;
        int postID, countComment;
        String title, description, image, status, date;
        ArticlesDTO dto;
        try {
            String sql = "SELECT tbl_Articles.PostID, tbl_Articles.Title, "
                    + "tbl_Articles.Description, tbl_Articles.Image, "
                    + "tbl_Articles.Date, tbl_Articles.Email, tbl_Articles.Status, "
                    + "COUNT(tbl_Comments.PostID) As CommentCount FROM tbl_Articles "
                    + "FULL OUTER JOIN tbl_Comments ON tbl_Articles.PostID = tbl_Comments.PostID "
                    + "WHERE (tbl_Articles.Description LIKE '%" + search + "%' OR  tbl_Articles.Title LIKE '%" + search + "%') AND (tbl_Articles.Status = 'Active' AND tbl_Articles.Email = ?)"
                    + "GROUP BY tbl_Articles.PostID, "
                    + "tbl_Articles.Title, tbl_Articles.Description, "
                    + "tbl_Articles.Image, tbl_Articles.Date, tbl_Articles.Email, "
                    + "tbl_Articles.Status ORDER BY tbl_Articles.PostID "
                    + "OFFSET ? ROWS FETCH FIRST ? ROWS ONLY";
            conn = MyConnection.getConnection();
            if (conn != null) {
                preStm = conn.prepareStatement(sql);
                preStm.setString(1, email);
                preStm.setInt(2, offset);
                preStm.setInt(3, next);
                rs = preStm.executeQuery();
                result = new ArrayList<>();
                while (rs.next()) {
                    postID = rs.getInt("PostID");
                    title = rs.getString("Title");
                    description = rs.getString("Description");
                    image = rs.getString("Image");
                    String txtDate = rs.getString("Date");
                    long dateTime = Long.parseLong(txtDate);
                    date = convertDateToString(new Date(dateTime));
                    email = rs.getString("Email");
                    status = rs.getString("Status");
                    countComment = rs.getInt("CommentCount");
                    dto = new ArticlesDTO(postID, title, description, image, date, email, status, countComment);
                    result.add(dto);
                }
            }
        } catch (NumberFormatException | SQLException | ParseException | NamingException e) {
            e.printStackTrace();

        } finally {
            closeConnection();
        }
        return result;
    }

    public List<ArticlesDTO> getPostsByAuthor(String email, int offset, int next) throws SQLException {
        List<ArticlesDTO> result = null;
        int postID, countComment;
        String title, description, image, status, date;
        ArticlesDTO dto;
        try {
            String sql = "SELECT tbl_Articles.PostID, tbl_Articles.Title, "
                    + "tbl_Articles.Description, tbl_Articles.Image, "
                    + "tbl_Articles.Date, tbl_Articles.Email, tbl_Articles.Status, "
                    + "COUNT(tbl_Comments.PostID) As CommentCount FROM tbl_Articles "
                    + "FULL OUTER JOIN tbl_Comments ON tbl_Articles.PostID = tbl_Comments.PostID "
                    + "WHERE tbl_Articles.Status = 'Active' AND tbl_Articles.Email = ? GROUP BY tbl_Articles.PostID, "
                    + "tbl_Articles.Title, tbl_Articles.Description, "
                    + "tbl_Articles.Image, tbl_Articles.Date, tbl_Articles.Email, "
                    + "tbl_Articles.Status ORDER BY tbl_Articles.PostID "
                    + "OFFSET ? ROWS FETCH FIRST ? ROWS ONLY";
            conn = MyConnection.getConnection();
            if (conn != null) {
                preStm = conn.prepareStatement(sql);
                preStm.setString(1, email);
                preStm.setInt(2, offset);
                preStm.setInt(3, next);
                rs = preStm.executeQuery();
                result = new ArrayList<>();
                while (rs.next()) {
                    postID = rs.getInt("PostID");
                    title = rs.getString("Title");
                    description = rs.getString("Description");
                    image = rs.getString("Image");
                    String txtDate = rs.getString("Date");
                    long dateTime = Long.parseLong(txtDate);
                    date = convertDateToString(new Date(dateTime));
                    status = rs.getString("Status");
                    countComment = rs.getInt("CommentCount");
                    dto = new ArticlesDTO(postID, title, description, image, date, email, status, countComment);
                    result.add(dto);
                }
            }
        } catch (NumberFormatException | SQLException | ParseException | NamingException e) {
            e.printStackTrace();

        } finally {
            closeConnection();
        }
        return result;
    }

    public ArticlesDTO get(int id) throws SQLException, NamingException, ParseException {
        String title, description, image, date, email, status;
        ArticlesDTO dto = null;
        try {
            String sql = "SELECT PostID, Title, Description, Image, Date, Email, Status FROM tbl_Articles WHERE PostID = ? AND Status = 'Active'";
            conn = MyConnection.getConnection();
            if (conn != null) {
                preStm = conn.prepareStatement(sql);
                preStm.setInt(1, id);
                rs = preStm.executeQuery();
                if (rs.next()) {
                    title = rs.getString("Title");
                    description = rs.getString("Description");
                    image = rs.getString("Image");
                    date = convertDateToString(new Date(Long.parseLong(rs.getString("Date"))));
                    email = rs.getString("Email");
                    status = rs.getString("Status");
                    dto = new ArticlesDTO(id, title, description, image, date, email, status);
                }
            }
        } finally {
            closeConnection();
        }
        return dto;

    }

    public ArticlesDTO getPostByAuthor(int id, String email) throws NamingException, SQLException, ParseException, NumberFormatException {
        String title, description, image, date, status;
        ArticlesDTO dto = null;
        try {
            String sql = "SELECT PostID, Title, Description, Image, Date, Email, Status FROM tbl_Articles WHERE PostID = ? AND Status = 'Active' AND Email = ?";
            conn = MyConnection.getConnection();
            if (conn != null) {
                preStm = conn.prepareStatement(sql);
                preStm.setInt(1, id);
                preStm.setString(2, email);
                rs = preStm.executeQuery();
                if (rs.next()) {
                    title = rs.getString("Title");
                    description = rs.getString("Description");
                    image = rs.getString("Image");
                    date = convertDateToString(new Date(Long.parseLong(rs.getString("Date"))));
                    status = rs.getString("Status");
                    dto = new ArticlesDTO(id, title, description, image, date, email, status);
                }
            }
        } finally {
            closeConnection();
        }
        return dto;
    }

    @Override
    public boolean insert(ArticlesDTO dto) throws SQLException, NamingException {
        boolean check = false;
        try {
            String sql = "INSERT INTO tbl_Articles(Title, Description, Image, Date, Email, Status) VALUES (?,?,?,?,?,?)";
            conn = MyConnection.getConnection();
            if (conn != null) {
                preStm = conn.prepareStatement(sql);
                preStm.setString(1, dto.getTitle());
                preStm.setString(2, dto.getDescription());
                preStm.setString(3, dto.getImage());
                preStm.setLong(4, System.currentTimeMillis());
                preStm.setString(5, dto.getEmail());
                preStm.setString(6, "Active");
                check = preStm.executeUpdate() > 0;
            }
        } finally {
            closeConnection();
        }
        return check;
    }

    public void delete(String postID) throws SQLException, NamingException {
        boolean check = false;
        try {
            String sql = "UPDATE tbl_Articles SET Status = ? WHERE PostID = ?";
            conn = MyConnection.getConnection();
            if (conn != null) {
                preStm = conn.prepareStatement(sql);
                preStm.setString(1, "Deleted");
                preStm.setString(2, postID);
                preStm.executeUpdate();
            }

        } catch (SQLException | NamingException e) {
            System.out.println(e);
        } finally {
            closeConnection();
        }
    }

    @Override
    public boolean update(ArticlesDTO k, String v) throws SQLException, NamingException {
        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }

    @Override
    public boolean delete(ArticlesDTO k) throws SQLException, NamingException {
        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }

    @Override
    public ArticlesDTO get(String v) throws SQLException, NamingException {
        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }

}
