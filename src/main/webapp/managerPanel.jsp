<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
    <!-- HEAD -->
    <head>
        <title>Manager panel</title>
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
                        <li class="selected-nav-item"><a href="managerPanel.jsp">Manager panel</a></li>
                    </c:if>
                    <c:if test="${not empty admin}">
                        <li><a href="adminPanel.jsp">Admin panel</a></li>
                    </c:if>
                </ul>
                <ul class="nav navbar-nav navbar-right">
                    <div class="dropdown logout">
                        <button class="btn btn-primary dropdown-toggle animated fadeIn" type="button" data-toggle="dropdown"><ion-icon name="person"></ion-icon>
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

        <!-- Panel -->
        <div class="container">
            <c:if test="${not empty managedRestaurant}">
                    <c:if test="${manager == true}">
                        <h2>${managedRestaurant.name}</h2>

                        <div class="admin-buttons manager-button-line">
                            <a href=<c:url value="/reservation/getAllManagerTable"/>><button class="admin-panel-button">Reservations</button></a>
                            <a><button class="admin-panel-button">Menu</button></a>
                        </div>
                    </c:if>
            </c:if>

            <!-- Reservations table -->
            <c:if test="${not empty reservations && param.showReservations == true}">
                <table class="table table-striped animated fadeIn">
                    <thead>
                    <tr>
                        <th>Id</th>
                        <th>User</th>
                        <th>Time</th>
                        <th>Persons</th>
                        <th>Status</th>
                        <th>Delete</th>
                        <th>Accept</th>
                    </tr>
                    </thead>
                    <tbody>
                    <c:forEach items="${reservations}" var="reservation">
                        <tr>
                            <td>${reservation.id}</td>
                            <td>${reservation.user.username}</td>
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
                            <td><button type="button" class="delete-button" data-toggle="modal" data-target="#deleteReservationModal" onclick="setClickedReservation(${reservation.id})"><ion-icon name="trash"></ion-icon></button></td>
                            <td><button type="button" class="confirm-button"  data-toggle="modal" data-target="#acceptReservationModal" onclick="setConfirmingReservation(${reservation.id})"><ion-icon name="checkmark-circle"></ion-icon></button></td>
                        </tr>
                    </c:forEach>
                    </tbody>
                </table>

                <!-- Delete dialog modal -->
                <div class="modal fade" id="deleteReservationModal" role="dialog">
                    <div class="modal-dialog">

                        <!-- Modal content-->
                        <div class="modal-content">
                            <div class="modal-header">
                                <button type="button" class="close" data-dismiss="modal">&times;</button>
                                <h4 class="modal-title">Delete reservation</h4>
                            </div>
                            <div class="modal-body">
                                <p id="modalMessageReservation">Are you sure you want to delete reservation with id </p>
                                <form action="/reservation/delete" method="post">
                                    <input id="reservationIdHiddenField" type="hidden" name="reservationId">
                                    <input class="modal-confirm-button" type="submit" value="Yes">
                                </form>
                            </div>
                            <div class="modal-footer">
                                <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                            </div>
                        </div>

                    </div>
                </div>

                <!-- Accept dialog modal -->
                <div class="modal fade" id="acceptReservationModal" role="dialog">
                    <div class="modal-dialog">

                        <!-- Modal content-->
                        <div class="modal-content">
                            <div class="modal-header">
                                <button type="button" class="close" data-dismiss="modal">&times;</button>
                                <h4 class="modal-title">Accept reservation</h4>
                            </div>
                            <div class="modal-body">
                                <p id="modalAcceptMessageReservation">Are you sure you want to delete reservation with id </p>
                                <form action="/reservation/accept" method="post">
                                    <input id="reservationAcceptIdHiddenField" type="hidden" name="reservationId">
                                    <input class="modal-confirm-button" type="submit" value="Yes">
                                </form>
                            </div>
                            <div class="modal-footer">
                                <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                            </div>
                        </div>

                    </div>
                </div>
            </c:if>
        </div>

        <script src="https://unpkg.com/ionicons@4.1.2/dist/ionicons.js"></script>
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
        <script>
            function setClickedReservation(reservationId) {
                document.getElementById('reservationIdHiddenField').value = reservationId;
                document.getElementById('modalMessageReservation').innerText = "Are you sure you want to delete reservation with id " + reservationId + "?";
            }

            function setConfirmingReservation(reservationId) {
                document.getElementById('reservationAcceptIdHiddenField').value = reservationId;
                document.getElementById('modalAcceptMessageReservation').innerText = "Are you sure you want to accept reservation with id " + reservationId + "?";
            }
        </script>
    </body>
</html>