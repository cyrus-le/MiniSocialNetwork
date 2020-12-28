/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.cyrus.dtos;

/**
 *
 * @author Cyrus
 */
public class NotificationDTO {

    private int notifyID;
    private int postID;
    private String email;
    private String date;
    private String type;
    private String commenter;
    private String reacter;
    private String title;

    public NotificationDTO(int notifyID, int postID, String email, String date, String type) {
        this.notifyID = notifyID;
        this.postID = postID;
        this.email = email;
        this.date = date;
        this.type = type;
    }

    public NotificationDTO(int postID, String email, String date, String type) {
        this.postID = postID;
        this.email = email;
        this.date = date;
        this.type = type;
    }

    public NotificationDTO(int notifyID, int postID, String email, String date, String type, String commenter, String reacter, String title) {
        this.notifyID = notifyID;
        this.postID = postID;
        this.email = email;
        this.date = date;
        this.type = type;
        this.commenter = commenter;
        this.reacter = reacter;
        this.title = title;
    }

    public NotificationDTO() {
    }

    public int getNotifyID() {
        return notifyID;
    }

    public void setNotifyID(int notifyID) {
        this.notifyID = notifyID;
    }

    public int getPostID() {
        return postID;
    }

    public void setPostID(int postID) {
        this.postID = postID;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getDate() {
        return date;
    }

    public void setDate(String date) {
        this.date = date;
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    public String getCommenter() {
        return commenter;
    }

    public void setCommenter(String commenter) {
        this.commenter = commenter;
    }

    public String getReacter() {
        return reacter;
    }

    public void setReacter(String reacter) {
        this.reacter = reacter;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

}
