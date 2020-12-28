/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.cyrus.dtos;

import java.util.Date;

/**
 *
 * @author Cyrus
 */
public class EmotionDTO {

    private int emotionID;
    private int postID;
    private String email;
    private int like;
    private int dislike;
    private String date;

    public EmotionDTO() {
    }

    public EmotionDTO(int emotionID, int postID, String email, int like, int dislike, String date) {
        this.emotionID = emotionID;
        this.postID = postID;
        this.email = email;
        this.like = like;
        this.dislike = dislike;
        this.date = date;
    }

    public EmotionDTO(int postID, String email, int like, int dislike, String date) {
        this.postID = postID;
        this.email = email;
        this.like = like;
        this.dislike = dislike;
        this.date = date;
    }
    

    public int getEmotionID() {
        return emotionID;
    }

    public void setEmotionID(int emotionID) {
        this.emotionID = emotionID;
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

    public int getLike() {
        return like;
    }

    public void setLike(int like) {
        this.like = like;
    }

    public int getDislike() {
        return dislike;
    }

    public void setDislike(int dislike) {
        this.dislike = dislike;
    }

    public String getDate() {
        return date;
    }

    public void setDate(String date) {
        this.date = date;
    }

}



