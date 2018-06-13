<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<html>
    <!-- HEAD -->
    <head>
        <title>Reserve</title>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">

        <!-- Bootstrap -->
        <link rel="stylesheet" href="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap.min.css">

        <!-- VENDORS CSS -->
        <link href='https://fonts.googleapis.com/css?family=Roboto:400,300italic,400italic,700,700italic' rel='stylesheet' type='text/css'>
        <link href="https://fonts.googleapis.com/css?family=Lato:300,400,700" rel="stylesheet">

        <!-- CSS -->
        <link rel="stylesheet" type="text/css" href="/resources/css/style.css">
        <link rel="stylesheet" type="text/css" href="/vendors/css/ionicons.css">
        <link rel="stylesheet" type="text/css" href="/vendors/css/animate.css">
    </head>

    <!-- BODY -->
    <body>
        <!-- HOME SECTION -->
        <div class="home container-fluid">
            <div class="home container-fluid">
                <!-- Navbar -->
                <nav class="navbar navbar-default">
                    <ul class="nav navbar-nav">
                        <li class="active"><a class="hvr-underline-from-center" href="index.jsp">Home</a></li>
                        <li><a class="hvr-underline-from-center" href="#restaurants">Restaurants</a></li>
                        <li><a class="hvr-underline-from-center" href="#about-us">About us</a></li>
                    </ul>
                </nav>
            </div>

            <c:if test="${param.register == null && param.login == null}">
                <!-- Video background -->
                <video src="/resources/video/background-video.mp4" autoplay muted loop></video>

                <!-- Header text -->
                <div class="header-text">
                    Welcome to Reserve
                    <div class="sub-text">
                        the easiest way to make a restaurant reservation
                    </div>
                    <a href="index.jsp?register" class="logo-button button-dark">Register</a>
                    <a href="index.jsp?login" class="logo-button button-dark">Login</a>
                </div>
            </c:if>

            <!-- REGISTER -->
            <c:if test="${param.register != null}">
                <style>
                    .home {
                        background: linear-gradient(rgba(51, 51, 51, 0.7), rgba(51, 51, 51, 0.7)), url(resources/imgs/stars.jpg);
                        background-size: cover;
                    }
                </style>
                <!-- Header text -->
                <div class="header-text">
                    <h2>Register</h2>
                    <!-- Contact form -->
                    <form class="register-form" action="/user/registerUser" method="post">
                        <div class="form-group">
                            <input class="form-control" name="username" placeholder="Username">
                        </div>
                        <div class="form-group">
                            <input class="form-control" name="name" placeholder="Name">
                        </div>
                        <div class="form-group">
                            <input class="form-control" name="lastName" placeholder="Last name">
                        </div>
                        <div class="form-group">
                            <input class="form-control" name="email" placeholder="Email">
                        </div>
                        <div class="form-group">
                            <input class="form-control" name="phone" placeholder="Phone number">
                        </div>
                        <div class="form-group">
                            <input class="form-control" name="password" placeholder="Password" type="password">
                        </div>
                        <div class="form-group">
                            <input class="form-control" name="rePassword" placeholder="Re-password" type="password">
                        </div>
                        <input type="submit" value="Register" class="button-transparent submit-button">
                    </form>
                </div>
            </c:if>

            <!-- LOGIN -->
            <c:if test="${param.login != null}">
                <style>
                    .home {
                        background: linear-gradient(rgba(51, 51, 51, 0.7), rgba(51, 51, 51, 0.7)), url(resources/imgs/stars.jpg);
                        background-size: cover;
                    }
                </style>
                <!-- Header text -->
                <div class="header-text">
                    <c:if test="${successfullyRegistered != null}">
                        <div class="registration-message-text">
                            Successfully registered!
                        </div>
                    </c:if>
                    <h2>Login</h2>
                    <!-- Contact form -->
                    <form class="register-form">
                        <div class="form-group">
                            <input class="form-control" name="usernameLogin" placeholder="Username">
                        </div>
                        <div class="form-group">
                            <input class="form-control" name="passwordLogin" placeholder="Password">
                        </div>
                        <input type="submit" value="Log in" class="button-transparent submit-button">
                    </form>
                </div>
            </c:if>
        </div>
    </body>
</html>
