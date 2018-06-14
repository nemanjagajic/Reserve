<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<html>
    <!-- HEAD -->
    <head>
        <title>Restaurants</title>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">

        <!-- Bootstrap -->
        <link rel="stylesheet" href="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap.min.css">

        <!-- VENDORS CSS -->
        <link href='https://fonts.googleapis.com/css?family=Roboto:400,300italic,400italic,700,700italic' rel='stylesheet' type='text/css'>
        <link href="https://fonts.googleapis.com/css?family=Lato:300,400,700" rel="stylesheet">

        <!-- CSS -->
        <link rel="stylesheet" type="text/css" href="/resources/css/restaurants.css">
        <link rel="stylesheet" type="text/css" href="/vendors/css/animate.css">
    </head>

    <!-- BODY -->
    <body class="restaurants">
        <!-- Navbar -->
        <nav class="navbar navbar-inverse sticky">
            <div class="container">
                <ul class="nav navbar-nav">
                    <li><a href="index.jsp">Home</a></li>
                    <li class="selected-nav-item"><a href="restaurants.jsp">Restaurants</a></li>
                    <li><a href="#">About us</a></li>
                </ul>
                <ul class="nav navbar-nav navbar-right">
                    <div class="dropdown logout">
                        <button class="btn btn-primary dropdown-toggle animated fadeIn" type="button" data-toggle="dropdown"><ion-icon name="person"></ion-icon>
                            <span class="caret"></span></button>
                        <ul class="dropdown-menu">
                            <c:choose>
                                <c:when test="${not empty username}">
                                    <li class="username-logout">${username}</li>
                                    <li><a href="restaurants.jsp">My profile</a></li>
                                    <li><a href="${pageContext.request.contextPath}/user/logout">Logout</a></li>
                                </c:when>
                                <c:otherwise>
                                    <li class="username-logout">Not logged in</li>
                                    <li><a href="index.jsp?login">Log in</a></li>
                                </c:otherwise>
                            </c:choose>
                        </ul>
                    </div>
                </ul>
            </div>
        </nav>

        <!-- Restaurants -->
        <div class="container">
            <div class="row">
                <!-- Filters -->
                <div class="col-sm-3">
                    <h2>Filter</h2>
                    <div class="filters-container">
                        <h4>Cost</h4>
                        <ul class="filters-list">
                            <li>
                                <input type="checkbox"> Cheap
                            </li>
                            <li>
                                <input type="checkbox"> Medium
                            </li>
                            <li>
                                <input type="checkbox"> Expensive
                            </li>
                        </ul>
                        <h4>Food</h4>
                        <ul class="filters-list">
                            <li>
                                <input type="checkbox"> Italian food
                            </li>
                            <li>
                                <input type="checkbox"> Serbian food
                            </li>
                            <li>
                                <input type="checkbox"> Pizza
                            </li>
                            <li>
                                <input type="checkbox"> Greek food
                            </li>
                            <li>
                                <input type="checkbox"> Pasta
                            </li>
                            <li>
                                <input type="checkbox"> Burgers
                            </li>
                            <li>
                                <input type="checkbox"> American food
                            </li>
                            <li>
                                <input type="checkbox"> Barbecue
                            </li>
                            <li>
                                <input type="checkbox"> Mediterranean food
                            </li>
                            <li>
                                <input type="checkbox"> Sandwiches
                            </li>
                            <li>
                                <input type="checkbox"> Pancakes
                            </li>
                            <li>
                                <input type="checkbox"> Breakfast
                            </li>
                            <li>
                                <input type="checkbox"> Chinese food
                            </li>
                            <li>
                                <input type="checkbox"> Asian food
                            </li>
                            <li>
                                <input type="checkbox"> Fish and seafood
                            </li>
                            <li>
                                <input type="checkbox"> Chicken
                            </li>
                            <li>
                                <input type="checkbox"> Vegetarian food
                            </li>
                            <li>
                                <input type="checkbox"> Vegan food
                            </li>
                            <li>
                                <input type="checkbox"> Mexican food
                            </li>
                            <li>
                                <input type="checkbox"> Fit food
                            </li>
                            <li>
                                <input type="checkbox"> Hungarian food
                            </li>
                            <li>
                                <input type="checkbox"> Sweets
                            </li>
                            <li>
                                <input type="checkbox"> Drinks
                            </li>
                        </ul>
                    </div>
                </div>
                <!-- Restaurants -->
                <div class="col-sm-9">
                    <h2>Available restaurants</h2>
                </div>
            </div>
        </div>

        <script src="https://unpkg.com/ionicons@4.1.2/dist/ionicons.js"></script>
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
        <script>
            $(document).ready(function(){
                $('[data-toggle="popover"]').popover();
            });
        </script>
    </body>
</html>
