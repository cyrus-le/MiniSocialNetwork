<%-- 
    Document   : login
    Created on : Sep 16, 2020, 10:41:15 AM
    Author     : Cyrus
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Login Page</title>
        <link rel="stylesheet" href="./css/login.css">
        <link rel="stylesheet" type="text/css" href="css/util.css">
        <link rel="stylesheet" type="text/css" href="css/main.css">
        <link href="https://fonts.googleapis.com/css2?family=Roboto+Mono&display=swap" rel="stylesheet">
        <link href="https://fonts.googleapis.com/css?family=Indie+Flower|Overpass+Mono" rel="stylesheet">
        <link rel="SHORTCUT ICON" href="./img/logo.jpg">    
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css"
              integrity="sha384-JcKb8q3iqJ61gNV9KGb8thSsNjpSL0n8PARn9HuZOnIxN0hoP+VmmDGMN5t9UJ0Z" crossorigin="anonymous">
        <link href="https://fonts.googleapis.com/css?family=Source+Sans+Pro:300,400,400i,700" rel="stylesheet">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.11.2/css/all.css">

    </head>
    <body>
        <form class="form-group" action="MainController" method="POST">
            <div class="login__content">
                <div class="login__left">
                    <img src="./img/photo-1432888622747-4eb9a8efeb07.png" alt="">
                </div>
                <div class="login__right">               

                    <div class="container-login100">
                        <div class="wrap-login100 p-l-85 p-r-85 p-t-55 p-b-55">

                            <span class="login100-form-title p-b-32">
                                Account Login
                            </span>
                            <font color="red">${requestScope.ERROR.notExistedError}</font> <br/>
                            <span class="txt1 p-b-11">
                                Email
                            </span>
                            <div class="wrap-input100 validate-input m-b-36">
                                <input class="input100" type="text" name="txtEmail" placeholder="Input your email">

                                <span class="focus-input100"></span>
                            </div>
                            <br/>
                            <span class="txt1 p-b-11">
                                Password
                            </span>
                            <div class="wrap-input100 validate-input m-b-12">
                                <span class="btn-show-pass">
                                    <i class="fa fa-eye"></i>
                                </span>
                                <input class="input100" type="password" name="txtPassword" placeholder="Input your password" >
                                <span class="focus-input100"></span>
                            </div>
                            <br/>

                            <input type="submit" class=" btn btn-outline-success py-2" value="Login" name="action"/>                                                                           

                            <br/>

                            <a href="signup.jsp">Don't have an account? Sign up here</a>


                        </div>
                    </div>
                </div>

            </div>
        </form>
    </body>
    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"
            integrity="sha384-DfXdz2htPH0lsSSs5nCTpuj/zy4C+OGpamoFVy38MVBnE+IbbVYUew+OrCXaRkfj"
    crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"
            integrity="sha384-9/reFTGAW83EW2RDu2S0VKaIzap3H66lZH81PoYlFhbGU+6BZp6G7niu735Sk7lN"
    crossorigin="anonymous"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"
            integrity="sha384-B4gt1jrGC7Jh4AgTPSdUtOBvfO8shuf57BaghqFfPlYxofvL8/KUEfYiJOMMV+rV"
    crossorigin="anonymous"></script>
    <script src="js/main.js"></script>
</html>
