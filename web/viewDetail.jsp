<%-- 
    Document   : viewDetail
    Created on : Sep 28, 2020, 9:20:02 PM
    Author     : Cyrus
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <link rel="stylesheet" href="./css/index.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.14.0/css/all.min.css">
        <link rel="stylesheet" href="./css/bootstrap.min.css">
    </head>
    <style>
        textarea{
            resize: none;
            white-space: pre-wrap;
            width: 440px;
        }
    </style>

    <body class="bg-light">
        <c:if test="${empty sessionScope.USER}">
            <c:redirect url="login.jsp"/>
        </c:if>

        <c:if test="${requestScope.LIST.status == 'Deleted'}">
            <c:redirect url="SocialNetworkController"/>
        </c:if>


        <c:set var="id" value="${sessionScope.USER.email}"/>
        <c:set var="role" value="${sessionScope.USER.role}" />
        <c:set var="dto" value="${requestScope.DTO}" />
        <c:set var="comment" value="${requestScope.COMMENT}"/>

        <div class="container">


            <c:if test="${not empty dto}">


                <h1 class="d-flex justify-content-center mx-3 display-4"
                    style="font-family:'Franklin Gothic Medium', 'Arial Narrow', Arial, sans-serif">${dto.title}</h1>
                <input type="hidden" name="txtPostID" value="${dto.postID}" />
                <blockquote style="font-size: small; float: right" class="blockquote-footer text-right my-2">From
                    ${dto.email}</blockquote> <br /> <br />
                <p class="text-monospace jumbotron">" ${dto.description} "</p> <br />

                <img class="img-thumbnail mx-auto d-block" src="img/${dto.image}">
                <br /> <br />


                <div class="float-right">
                    <i class="fas fa-calendar-times"></i> ${dto.date}
                </div>
                <br />
                Status: <font color="green">${dto.status}</font>
                <br /> <br />
                <hr />
                <div class="py-5 ">
                    <form action="MainController" method="POST">
                        <c:if test="${role != 'admin'}">
                            <a class="btn btn-outline-primary" href="MainController?action=React&txtPostID=${dto.postID}&txtReact=liked">
                                <i class="far fa-thumbs-up"></i>
                            </a>
                            <a class="btn btn-outline-danger" href="MainController?action=React&txtPostID=${dto.postID}&txtReact=disliked">                             
                                <i class="far fa-thumbs-down"></i>

                            </a>

                        </c:if>
                    </form>
                </div>
                <h5 class="text-primary">Like: <small class="text-primary" >${requestScope.LIKE}</small></h5>
                <h5 class="text-danger" >Dislike: <small class="text-danger" >${requestScope.DISLIKE}</small></h5>

                <br/>
                <div class="form-group">
                    <!--comment nè-->
                    <form action="MainController" method="POST">
                        <input type="hidden" name="txtPostID" value="${dto.postID}" />
                        <input type="hidden" value="${dto.email}" name="txtAuthorPost" />
                        <c:if test="${sessionScope.USER.role != 'admin'}">
                            <label for="comment">Comment:</label>
                            <textarea required class="form-control col-md-8" rows="5"  name="txtComment" id="comment"></textarea> <br/>
                            <input class="btn btn-success" type="submit" value="Comment" name="action" />
                            <a class="btn btn-secondary" href="SocialNetworkController">
                                <i class="fa fa-backward"></i> Go back
                            </a>
                        </c:if>
                    </form>



                </c:if>

                <c:if test="${not empty requestScope.COMMENT}">                       
                    <c:forEach var="comment" items="${requestScope.COMMENT}">                        

                        <hr>
                        <h3>${comment.email}</h3>  <span class="blockquote-footer"> ${comment.date}</span> <br/>
                        <p class="text-monospace jumbotron">" ${comment.content} "</p> 
                        <c:if test="${comment.email == id or role == 'admin' }">                           
                            <button class="btn btn-danger" data-target="#deleteModal" data-toggle="modal" type="button" >
                                <i class="fas fa-trash"></i></button> 

                            <!--form delete comment-->
                            <div class="modal" tabindex="-1" role="dialog" id="deleteModal">
                                <div class="modal-dialog" role="document">
                                    <div class="modal-content">
                                        <div class="modal-header">
                                            <h5 class="modal-title">Delete Confirm's comment</h5>
                                        </div>
                                        <div class="modal-body">
                                            <p>Do you really want to delete your comment?</p>
                                        </div>
                                        <div class="modal-footer">
                                            <form action="MainController" method="POST">

                                                <input type="hidden" value="${dto.postID}" name="txtPostID" />
                                                <input type="hidden" value="${comment.commentID}" name="txtCommentID" />
                                                <input type="hidden" value="${comment.email}" name="txtCommentMail" />
                                                <input class="btn btn-danger" type="submit" value="Delete Comment" name="action" />
                                            </form>
                                            <button type="button" class="btn btn-secondary" data-dismiss="modal">No Thanks</button>
                                        </div>
                                    </div>
                                </div>
                            </div>



                        </c:if>




                    </c:forEach>
                </c:if>

                <c:if test="${empty requestScope.COMMENT}">
                    <div class ="alert alert-success">
                        <strong>Be the first one</strong> to comment this article
                    </div>
                </c:if>     




            </div>


        </div>


        <script type="text/javascript"> 
            function divide() { 
                var txt; 
                txt = document.getElementById('comment').value; 
                var text = txt.split("."); 
                var str = text.join('.</br>'); 
                document.write(str); 
            } 
        </script> 

        <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"
                integrity="sha384-DfXdz2htPH0lsSSs5nCTpuj/zy4C+OGpamoFVy38MVBnE+IbbVYUew+OrCXaRkfj"
        crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"
                integrity="sha384-9/reFTGAW83EW2RDu2S0VKaIzap3H66lZH81PoYlFhbGU+6BZp6G7niu735Sk7lN"
        crossorigin="anonymous"></script>
        <script src="./js/bootstrap.min.js"></script>
    </body>

</html>
