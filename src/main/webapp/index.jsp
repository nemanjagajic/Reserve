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
        <link rel="stylesheet" type="text/css" href="/resources/css/home.css">
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
                        <li><a class="hvr-underline-from-center" href=<c:url value="/restaurant/getAll"/>>Restaurants</a></li>
                        <li><a class="hvr-underline-from-center" href="#about-us">About us</a></li>
                    </ul>
                </nav>
            </div>

            <c:if test="${param.register == null && param.login == null}">
                <!-- Video background -->
                <video src="/resources/video/background-video.mp4" autoplay muted loop></video>

                <!-- Header text -->
                <div class="header-text animated fadeIn">
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
                        background: #262626;
                    }
                </style>
                <!-- Header text -->
                <div class="header-text">
                    <c:choose>
                        <c:when test="${not empty param.successfullyRegistered}">
                            <c:choose>
                                <c:when test="${param.successfullyRegistered}">
                                    <div class="registration-message-text  animated fadeIn">
                                        Successfully registered!
                                    </div>
                                    <a href="index.jsp?login" class="logo-button button-dark  animated fadeIn">Login</a>
                                </c:when>
                                <c:otherwise>
                                    <div class="registration-failed-message-text animated fadeIn">
                                        Username or email already exists<br>please register again with a different one
                                    </div>
                                    <a onclick="goBack()" class="logo-button button-dark  animated fadeIn">Back to register</a>
                                </c:otherwise>
                            </c:choose>
                        </c:when>
                        <c:otherwise>
                            <h2>Register</h2>
                            <!-- Register form -->
                            <form class="register-form" action="${pageContext.request.contextPath}/user/register" method="post">
                                <div class="form-group">
                                    <input class="form-control" name="username" placeholder="Username" required="required">
                                </div>
                                <div class="form-group">
                                    <input class="form-control" name="name" placeholder="Name" required="required">
                                </div>
                                <div class="form-group">
                                    <input class="form-control" name="lastName" placeholder="Last name" required="required">
                                </div>
                                <div class="form-group">
                                    <input class="form-control" name="email" placeholder="Email" required="required" type="email"
                                           pattern="[a-z0-9._%+-]+@[a-z0-9.-]+\.[a-z]{2,3}$">
                                </div>
                                <div class="form-group">
                                    <input class="form-control" name="phone" placeholder="Phone number" required="required">
                                </div>
                                <div class="form-group">
                                    <input class="form-control" name="password" placeholder="Password" type="password" required="required"
                                           pattern=".{8,}" title="Password must contain 8 or more characters">
                                </div>
                                <input type="submit" value="Register" class="button-transparent submit-button animated fadeIn">
                            </form>
                        </c:otherwise>
                    </c:choose>
                </div>
            </c:if>

            <!-- LOGIN -->
            <c:if test="${param.login != null}">
                <style>
                    .home {
                        background: #262626;
                    }
                </style>
                <!-- Header text -->
                <div class="header-text">
                    <c:if test="${param.loginFailed == 1}">
                        <div class="registration-failed-message-text animated fadeIn">
                            Username doesn't exist
                        </div>
                    </c:if>
                    <c:if test="${param.loginFailed == 2}">
                        <div class="registration-failed-message-text animated fadeIn">
                            Incorrect password
                        </div>
                    </c:if>
                    <h2>Login</h2>
                    <!-- Contact form -->
                    <form class="register-form" action="${pageContext.request.contextPath}/user/login" method="post">
                        <div class="form-group">
                            <input class="form-control" name="username" placeholder="Username" required="required" value="${username}">
                        </div>
                        <div class="form-group">
                            <input class="form-control" name="password" type="password" placeholder="Password" required="required"
                                   pattern=".{8,}" title="Password must contain 8 or more characters">
                        </div>
                        <input type="submit" value="Log in" class="button-transparent submit-button animated fadeIn">
                    </form>
                </div>
            </c:if>
        </div>

        <script>
            function goBack() {
                window.history.back();
            }
        </script>
    </body>
</html>
