<%-- 
    Document   : notify
    Created on : Sep 26, 2020, 5:42:32 PM
    Author     : Cyrus
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<!DOCTYPE html>
<html lang="en">
    <html>
        <head>
            <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
            <title>Notification</title>
            <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" integrity="sha384-JcKb8q3iqJ61gNV9KGb8thSsNjpSL0n8PARn9HuZOnIxN0hoP+VmmDGMN5t9UJ0Z" crossorigin="anonymous">
            <link rel="stylesheet" href="https://pro.fontawesome.com/releases/v5.10.0/css/all.css" integrity="sha384-AYmEC3Yw5cVb3ZcuHtOA93w35dYTsvhLPVnYs9eStHfGJvOvKxVfELGroGkvsg+p" crossorigin="anonymous"/>
            <link rel="stylesheet" href="css/style.css" />
        </head>
        <body class="bg-light">

            <c:if test="${empty sessionScope.USER}">
                <c:redirect url="login.jsp"/>
            </c:if>
            <c:set var="name" value="${sessionScope.NAME}" />

            <div class="container-fluid">
                <nav class="navbar navbar-expand-lg navbar-dark bg-dark">
                    <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
                        <span class="navbar-toggler-icon"></span>
                    </button>
                    <a class="navbar-brand" href="SocialNetworkController">Mini<span class="text-primary" > Social Network</span></a>
                    <div class="collapse navbar-collapse" id="navbarSupportedContent">

                        <form method="POST" class="form-inline my-2 my-lg-0" action="MainController">
                            <ul class="navbar-nav mr-auto">
                                <li class="nav-item active">
                                    <a class="nav-link" href="SocialNetworkController">Home <span class="sr-only">(current)</span></a>
                                </li>

                            </ul>
                        </form>


                    </div>
                    <c:if test="${not empty name}">
                        <a class="mx-3" style="text-decoration: none" href="ViewOurPostsController">
                            <i class="fa fa-user"></i> <span class="text-white">Welcome back</span> ${name}
                        </a>
                        <a class="btn btn-secondary ml-3" style="text-decoration: none; right:30px" href="LogoutController">
                            <i class="fas fa-sign-out-alt"></i>
                        </a>
                    </c:if>
                </nav>
            </div>









            <c:set var="user" value="${sessionScope.USER}"/>
            <c:set var="list" value="${requestScope.LIST_NOTIFY}"/>

            <c:forEach var="dto" items="${list}" varStatus="counter">
                <c:set var="urlDetail" value="MainController?action=View Detail&txtPostID=${dto.postID}"/>
                <c:choose>
                    <c:when test="${dto.type == 'comment'}">
                        <a href="${urlDetail}" style="text-decoration: none">
                            <div class="alert alert-secondary" style="margin: 10px 390px; position: relative; top: 100px">
                                <b>${dto.commenter}</b> commented on your <b>${dto.title}</b>'s post.<br/>
                                <small>${dto.date}</small>
                            </div>
                        </a>
                    </c:when>
                    <c:when test="${dto.type == 'like'}">
                        <a href="${urlDetail}" style="text-decoration: none">
                            <div class="alert alert-secondary" style="margin: 10px 390px; position: relative; top: 100px">
                                <b>${dto.reacter}</b> liked your <b>${dto.title}</b>'s post.<br/>
                                <small>${dto.date}</small>
                            </div>
                        </a>
                    </c:when>
                    <c:when test="${dto.type == 'dislike'}">
                        <a href="${urlDetail}" style="text-decoration: none">
                            <div class="alert alert-secondary" style="margin: 10px 390px; position: relative; top: 100px">
                                <b>${dto.reacter}</b> disliked your <b>${dto.title}</b>'s post.<br/>
                                <small>${dto.date}</small>
                            </div>

                        </a>
                    </c:when>
                    <c:otherwise>

                    </c:otherwise>

                </c:choose>

            </c:forEach>







            <!--when there is no result matched-->
            <c:if test="${empty list}">
                <c:if test="${empty list}">
                    <div id="noResult">
                        <img src="https://www.iconfinder.com/data/icons/facebook-and-social-media-1/64/Facebook_and_Social_Media-17-512.png"/>
                        <h3>There is not any notifications!</h3>
                    </div>
                </c:if>
            </c:if>
            <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js" integrity="sha384-DfXdz2htPH0lsSSs5nCTpuj/zy4C+OGpamoFVy38MVBnE+IbbVYUew+OrCXaRkfj" crossorigin="anonymous"></script>
            <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js" integrity="sha384-9/reFTGAW83EW2RDu2S0VKaIzap3H66lZH81PoYlFhbGU+6BZp6G7niu735Sk7lN" crossorigin="anonymous"></script>
            <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js" integrity="sha384-B4gt1jrGC7Jh4AgTPSdUtOBvfO8shuf57BaghqFfPlYxofvL8/KUEfYiJOMMV+rV" crossorigin="anonymous"></script>

        </body>
    </html>
