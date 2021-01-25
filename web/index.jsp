<%-- 
    Document   : index
    Created on : Sep 14, 2020, 4:00:03 PM
    Author     : Cyrus
--%>

<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Mini Social Network</title>
        <link rel="stylesheet" href="./css/index.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.14.0/css/all.min.css">
        <link rel="stylesheet" href="./css/bootstrap.min.css">
        <link rel="stylesheet" href="https://pro.fontawesome.com/releases/v5.10.0/css/all.css" integrity="sha384-AYmEC3Yw5cVb3ZcuHtOA93w35dYTsvhLPVnYs9eStHfGJvOvKxVfELGroGkvsg+p" crossorigin="anonymous"/>
    </head>

    <body class="bg-light">
        <c:if test="${empty sessionScope.USER}">
            <c:redirect url="login.jsp"/>
        </c:if>


        <c:set var="name" value="${sessionScope.NAME}" />
        <c:set var="id" value="${sessionScope.USER.email}"/>
        <c:set var="role" value="${sessionScope.USER.role}" />



        <div class="container-fluid">
            <nav class="navbar navbar-expand-lg navbar-dark bg-dark active">
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
                        <ul class="nav navbar-top-links navbar-left m-l-20 hidden-xs">
                            <li class="nav-item">
                                <c:if test="${empty sessionScope.ADMIN}">
                                    <input  type="button" value="Post your article" class="btn btn-primary my-2 my-sm-0" data-toggle="modal"
                                            data-target="#insertModal" />
                                </c:if>
                            </li>
                        </ul>
                        <ul class="navbar-nav mx-auto">
                            <div class="input-group mx-5">
                                <div class="input-group-prepend">
                                    <span class="input-group-text" id="basic-addon1">
                                        <i class="fas fa-search"></i>
                                    </span>
                                </div>
                                <input class="form-control" type="text" placeholder="Search" value="${param.txtSearch}"
                                       name="txtSearch"/>
                                <input class="btn btn-success" type="submit" value="Search" name="action" />
                            </div>
                        </ul>


                    </form>


                </div>
                <c:if test="${not empty name}">

                    <a class="mx-3" style="text-decoration: none" href="ViewOurPostsController">
                        <i class="fa fa-user"></i> <span class="text-white">Welcome back</span> ${name}
                    </a>
                    <a href="NotificationController" class="btn btn-info " >
                        <i class="fas fa-bell"></i>
                    </a> 
                    <a class="btn btn-secondary ml-3" style="text-decoration: none; right:30px" href="LogoutController">
                        <i class="fas fa-sign-out-alt"></i>
                    </a>
                </c:if>
            </nav>
        </div>

        <div class="container">
            <c:if test="${not empty requestScope.LIST}">
                <c:if test="${not empty requestScope.LIST}" var="checkList">
                    <c:forEach items="${requestScope.LIST}" var="dto">
                        <input type="hidden" value="${dto.email}" name="txtEmail" />

                        <div class="well">
                            <div class="media">
                                <c:if test="${not empty dto.image}">
                                    <a class="pull-left" href="#">
                                        <img class="img-fluid" src="img/${dto.image}">
                                    </a>
                                </c:if>

                                <div class class="media-body">
                                    <input type="hidden" name="txtPostID" value="${dto.postID}" />
                                    <input type="hidden" name="txtPostEmail" value="${dto.email}" />
                                    <h1 style="font-family:'Franklin Gothic Medium', 'Arial Narrow', Arial, sans-serif" class="py-4" >${dto.title}</h1>
                                    <blockquote style="font-size: small" class="blockquote-footer">From
                                        ${dto.email}</blockquote> <br /> <br />
                                    <p class="text-monospace jumbotron">" ${dto.description} "</p> <br />
                                    <ul class="list-inline list-unstyled">
                                        <li class="list-inline-item"><span><i class="fas fa-calendar-times"></i></span> ${dto.date}</li>
                                        <li class="list-inline-item">|</li>
                                        <span ><i class="fas fa-comments"></i> ${dto.countComment} comments</span> <br/>
                                    </ul>
                                    <a href="MainController?action=View Detail&txtPostID=${dto.postID}"  type="submit" value="View Detail"
                                       name="action"> <button class="btn btn-warning">View Detail
                                        </button></a>


                                    <c:if test="${id == dto.email or role == 'admin'}">

                                        <button class="btn btn-danger" data-target="#deleteModal" data-toggle="modal" type="button" >
                                            <i class="fas fa-trash"></i></button> 

                                        <!--confirmation of delete-->
                                        <div class="modal" tabindex="-1" role="dialog" id="deleteModal">
                                            <div class="modal-dialog" role="document">
                                                <div class="modal-content">
                                                    <div class="modal-header">
                                                        <h5 class="modal-title">Delete Confirm's form</h5>
                                                    </div>
                                                    <div class="modal-body">
                                                        <p>Do you really want to delete your article?</p>
                                                    </div>
                                                    <div class="modal-footer">
                                                        <form action="MainController" method="POST">
                                                            <input type="hidden" value="${dto.postID}" name="txtPostID" />
                                                            <input type="hidden" value="${dto.email}" name="txtPostEmail" />
                                                            <input class="btn btn-danger" type="submit" value="Delete" name="action" />
                                                        </form>
                                                        <button type="button" class="btn btn-secondary" data-dismiss="modal">No Thanks</button>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <!--</a>-->
                                    </c:if>
                                </div>

                            </div>
                        </div>
                        <hr>
                    </c:forEach>
                </c:if>
                <c:if test="${!checkList}">
                    <div class="alert alert-dark my-5">
                        <i class="fas fa-search"></i><strong> NOT FOUND </strong> OOPSS There is no result.
                    </div>
                </c:if>
            </c:if>




            <c:if test="${not empty requestScope.LIST}">
                <ul class="pagination d-flex- justify-content-center">
                    <li class="page-item <c:if test="${requestScope.CURPAGE eq 0 }">disabled</c:if>">
                        <a  class="page-link" href="SocialNetworkController?page=${requestScope.CURPAGE - 1}">Previous</a>
                    </li>
                    <c:forEach var="i" begin="1" end="${requestScope.PAGE}" step="1">
                        <li class="page-item <c:if test="${requestScope.CURPAGE + 1 eq i}">active</c:if>">
                            <a class="page-link" href="SocialNetworkController?page=${i - 1}">${i}</a>
                        </li> 
                    </c:forEach>

                    <li class="page-item <c:if test="${requestScope.CURPAGE eq requestScope.PAGE - 1}">disabled</c:if>">
                        <a class="page-link" href="SocialNetworkController?page=${requestScope.CURPAGE + 1}">Next</a>
                    </li>
                </ul>
            </c:if>
            <c:if test="${empty requestScope.LIST}">
                <div class="alert alert-dark my-5">
                    <i class="fas fa-search"></i><strong> NOT FOUND </strong>  OOPS You haven't posted anything.......
                </div>
            </c:if>

        </div>

        <!--inssert article-->
        <div class="modal" id="insertModal">
            <form enctype="multipart/form-data" action="MainController" method="POST">
                <div class="modal-dialog">
                    <div class="modal-content">

                        <!-- Modal Header -->
                        <div class="modal-header">
                            <h5 class="modal-title d-flex justify-content-center">Create Post</h5>
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                <span aria-hidden="true">&times;</span>
                            </button>
                        </div>

                        <!-- Modal body -->
                        <div class="modal-body form-group">

                            Title: <input class="form-control" type="text" name="txtTitle" value=""}" />
                            <br />
                            <input type="hidden" name="txtPostID" value="" />
                            <label>Description:</label>
                            <textarea name="txtDescription" class="form-control" rows="5" id="comment"
                                      placeholder="What's on your mind ${name}?"></textarea>
                            <label>Image:</label>
                            <input class="form-control" type="file" name="txtImage" value="" /> <br />


                        </div>

                        <!-- Modal footer -->
                        <div class="modal-footer">
                            <input class="btn btn-outline-danger" type="submit" value="Post the article" name="action" />
                        </div>

                    </div>
                </div>
            </form>
        </div>
        <c:if test="${not empty requestScope.ERROR}">
            <div class="modal" id="errorModal">
                <div class="modal-dialog">
                    <div class="modal-content">

                        <!-- Modal Header -->
                        <div class="modal-header">
                            <h5 class="modal-title-danger d-flex justify-content-center">Error</h5>
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                <span aria-hidden="true">&times;</span>
                            </button>
                        </div>

                        <!-- Modal body -->
                        <div class="modal-body form-group">
                            <c:out value="${requestScope.ERROR.titleError}" />
                            <c:if test="${not empty requestScope.ERROR.descriptionError}">
                                <c:out value="${requestScope.ERROR.descriptionError}" />
                            </c:if>

                        </div>
                    </div>
                </div>
            </div>
            <script>window.addEventListener('load',()=>{$("#errorModal").modal();});</script>
        </c:if>



        <script>
            $(document).ready(function () {
                console.log('<c:out value="${sessionScope.USER.email}"/>');
            });
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
