<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<html>
    <!-- HEAD -->
    <head>
        <title>Admin panel</title>
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
                <c:if test="${not empty admin}">
                    <li class="selected-nav-item"><a href="adminPanel.jsp">Admin panel</a></li>
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

    <div class="container">
        <h2>Admin panel</h2>

        <div class="admin-buttons">
            <button class="admin-panel-button" type="button" data-toggle="modal" data-target="#addRestaurantModal">Add restaurant</button>
            <a href=<c:url value="/restaurant/getAllAdminTable"/>><button class="admin-panel-button">Show restaurants</button></a>
            <a href=<c:url value="/reservation/getAllAdminTable"/>><button class="admin-panel-button">Show reservations</button></a>
        </div>

        <!-- Add modal -->
        <div id="addRestaurantModal" class="modal fade" role="dialog">
            <div class="modal-dialog">

                <!-- Modal content-->
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal">&times;</button>
                        <h4 class="modal-title">Restaurant form</h4>
                    </div>
                    <div class="modal-body">
                        <form class="add-restaurant-form" action="${pageContext.request.contextPath}/restaurant/add" method="post" enctype="multipart/form-data">
                            <div class="form-group">
                                <input class="form-control" name="name" placeholder="Name*" required="required">
                            </div>
                            <div class="form-group">
                                <input class="form-control" name="location" placeholder="Location*" required="required">
                            </div>
                            <div class="form-group">
                                <input class="form-control" name="workingHours" placeholder="Working hours*" required="required">
                            </div>
                            <div class="form-group">
                                <input class="form-control" name="number" placeholder="Phone number*" required="required">
                            </div>
                            <div class="form-group">
                                <input class="form-control" name="about" placeholder="Description" type="text">
                            </div>
                            <div class="form-group">
                                <input class="form-control" name="promoCode" placeholder="Has promo codes (1 if yes, 0 otherwise)" type="number">
                            </div>
                            <div class="form-group">
                                <input class="form-control" name="additionalLabel" placeholder="Additional label (e.g. Pet friendly)">
                            </div>
                            <div class="form-group">
                                <input class="form-control" value="choose image" type="file" name="file" accept="image/*">
                            </div>
                            <input type="submit" value="Add restaurant" class="submit-button">
                        </form>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                    </div>
                </div>

            </div>
        </div>

        <c:if test="${not empty param.successfullyAddedRestaurant}">
            <c:choose>
                <c:when test="${param.successfullyAddedRestaurant == true}">
                    <div class="success-message-text animated fadeIn">
                        Successfully added restaurant!
                    </div>
                </c:when>
                <c:otherwise>
                    <div class="fail-message-text animated fadeIn">
                        Something went wrong. Restaurant not added.
                    </div>
                </c:otherwise>
            </c:choose>
        </c:if>

        <!-- Restaurants table -->
        <c:if test="${not empty restaurants && param.showTable == true}">
            <table class="table table-striped animated fadeIn">
                <thead>
                <tr>
                    <th>Id</th>
                    <th>Name</th>
                    <th>Location</th>
                    <th>Working hours</th>
                    <th>Phone number</th>
                    <th>Stars</th>
                    <th>Delete</th>
                </tr>
                </thead>
                <tbody>
                <c:forEach items="${restaurants}" var="restaurant">
                    <tr>
                        <td>${restaurant.id}</td>
                        <td>${restaurant.name}</td>
                        <td>${restaurant.location}</td>
                        <td>${restaurant.workingHours}</td>
                        <td>${restaurant.number}</td>
                        <td>${restaurant.stars}</td>
                        <td><button type="button" class="delete-button" data-toggle="modal" data-target="#deleteRestaurantModal" onclick="setClickedRestaurant(${restaurant.id})"><ion-icon name="trash"></ion-icon></button></td>
                    </tr>
                </c:forEach>
                </tbody>
            </table>

            <!-- Delete dialog modal -->
            <div class="modal fade" id="deleteRestaurantModal" role="dialog">
                <div class="modal-dialog">

                    <!-- Modal content-->
                    <div class="modal-content">
                        <div class="modal-header">
                            <button type="button" class="close" data-dismiss="modal">&times;</button>
                            <h4 class="modal-title">Delete restaurant</h4>
                        </div>
                        <div class="modal-body">
                            <p id="modalMessage">Are you sure you want to delete restaurant with id </p>
                            <form action="/restaurant/delete" method="post">
                                <input id="restaurantIdHiddenField" type="hidden" name="restaurantId">
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

        <!-- Reservations table -->
        <c:if test="${not empty reservations && param.showReservations == true}">
            <table class="table table-striped animated fadeIn">
                <thead>
                <tr>
                    <th>Id</th>
                    <th>User</th>
                    <th>Restaurant</th>
                    <th>Time</th>
                    <th>Persons</th>
                    <th>Status</th>
                    <th>Delete</th>
                </tr>
                </thead>
                <tbody>
                <c:forEach items="${reservations}" var="reservation">
                    <tr>
                        <td>${reservation.id}</td>
                        <td>${reservation.user.username}</td>
                        <td>${reservation.restaurant.name}</td>
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
                            <h4 class="modal-title">Delete restaurant</h4>
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
        </c:if>
    </div>


    <script src="https://unpkg.com/ionicons@4.1.2/dist/ionicons.js"></script>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
    <script>
        $(document).ready(function(){
            $('[data-toggle="popover"]').popover();
        });

        function setClickedRestaurant(restaurantId) {
            document.getElementById('restaurantIdHiddenField').value = restaurantId;
            document.getElementById('modalMessage').innerText = "Are you sure you want to delete restaurant with id " + restaurantId;
        }

        function setClickedReservation(reservationId) {
            document.getElementById('reservationIdHiddenField').value = reservationId;
            document.getElementById('modalMessageReservation').innerText = "Are you sure you want to delete reservation with id " + reservationId;
        }
    </script>
    </body>
</html>

