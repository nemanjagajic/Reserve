<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
    <!-- HEAD -->
    <head>
        <title>Profile</title>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">

        <!-- Bootstrap -->
        <link rel="stylesheet" href="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap.min.css">

        <!-- Font Awesome Icon Library -->
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">

        <!-- VENDORS CSS -->
        <link href='https://fonts.googleapis.com/css?family=Roboto:400,300italic,400italic,700,700italic' rel='stylesheet' type='text/css'>
        <link href="https://fonts.googleapis.com/css?family=Lato:300,400,700" rel="stylesheet">

        <!-- CSS -->
        <link rel="stylesheet" type="text/css" href="/resources/css/restaurants.css">
        <link rel="stylesheet" type="text/css" href="/vendors/css/animate.css">


    </head>

    <!-- BODY -->
    <body>
    <!-- Navbar -->
    <nav class="navbar navbar-inverse sticky">
        <div class="container">
            <ul class="nav navbar-nav">
                <li><a href="index.jsp">Home</a></li>
                <li><a href=<c:url value="/restaurant/getAll"/>>Restaurants</a></li>
                <li><a href="#">About us</a></li>
                <c:if test="${not empty manager}">
                    <li><a href="managerPanel.jsp">Manager panel</a></li>
                </c:if>
                <c:if test="${not empty admin}">
                    <li><a href="adminPanel.jsp">Admin panel</a></li>
                </c:if>
            </ul>
            <ul class="nav navbar-nav navbar-right">
                <div class="dropdown logout">
                    <button  class="btn btn-primary dropdown-toggle animated fadeIn" type="button" data-toggle="dropdown"><ion-icon name="person"></ion-icon>
                        <span class="caret"></span></button>
                    <ul class="dropdown-menu">
                        <c:choose>
                            <c:when test="${not empty username && successfullyLoggedIn == true}">
                                <li class="username-logout">${username}</li>
                                <li><a href=<c:url value="/user/getProfile"/>>My profile</a></li>
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

    <c:if test="${not empty user}">
        <div class="user-info row">
            <div class="col-sm-6">
                <img class="profile-image img-circle" src="${user.image}">
            </div>
            <div class="col-sm-6 user-text">
                <span class="label">username:</span> ${user.username}<br>
                <span class="label">name:</span> ${user.name}<br>
                <span class="label">last name:</span> ${user.lastName}<br>
                <span class="label">email:</span> ${user.email}<br>
                <span class="label">phone:</span> ${user.phone}<br>
                <span class="label">role:</span> ${user.role}<br>
            </div>
        </div>
        <button class="edit-profile-button btn btn-light" data-toggle="modal" data-target="#editModal">Edit profile</button>

        <!-- Edit modal -->
        <div class="modal fade" id="editModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal">&times;</button>
                        <h4 class="modal-title">Edit profile</h4>
                    </div>
                    <div class="modal-body">
                        <form class="edit-restaurant-form" action="${pageContext.request.contextPath}/user/update" method="post" enctype="multipart/form-data">
                            <div class="form-group">
                                <input class="form-control" name="name" placeholder="Name" value="${user.name}" required="required">
                            </div>
                            <div class="form-group">
                                <input class="form-control" name="lastName" placeholder="Last name" value="${user.lastName}" required="required">
                            </div>
                            <div class="form-group">
                                <input class="form-control" name="phone" placeholder="Phone number" value="${user.phone}" required="required">
                            </div>
                            <div class="form-group">
                                <input class="form-control" name="password" placeholder="Password" type="password" value="${user.password}" required="required"
                                       pattern=".{8,}" title="Password must contain 8 or more characters">
                            </div>
                            <div class="form-group">
                                <input class="form-control" value="choose image" type="file" name="file" accept="image/*">
                            </div>
                            <input type="submit" value="Confirm" class="button-transparent submit-button animated fadeIn">
                        </form>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                    </div>
                </div>
            </div>
        </div>
    </c:if>

    <h2 class="reservations-title">My reservations</h2>

    <!-- Reservations table -->
    <c:if test="${not empty myReservations}">
        <div class="container">
            <table class="table table-striped animated fadeIn">
                <thead>
                <tr>
                    <th>Restaurant</th>
                    <th>Restaurant location</th>
                    <th>Restaurant number</th>
                    <th>Time</th>
                    <th>Persons</th>
                    <th>Status</th>
                </tr>
                </thead>
                <tbody>
                <c:forEach items="${myReservations}" var="reservation">
                    <tr>
                        <td>${reservation.restaurant.name}</td>
                        <td>${reservation.restaurant.location}</td>
                        <td>${reservation.restaurant.number}</td>
                        <td>${reservation.time}</td>
                        <td>${reservation.numberOfPersons}</td>
                        <td>
                            <c:if test="${reservation.accepted == 0}">
                                <div class="table-label-orange">Pending</div>
                            </c:if>
                            <c:if test="${reservation.accepted == 1}">
                                <div class="table-label-green">Accepted</div>
                            </c:if>
                            <c:if test="${reservation.accepted == 2}">
                                <div class="table-label-red">Rejected</div>
                            </c:if>
                        </td>
                    </tr>
                </c:forEach>
                </tbody>
            </table>
        </div>
    </c:if>

    <script src="https://unpkg.com/ionicons@4.1.2/dist/ionicons.js"></script>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
    </body>
</html>
