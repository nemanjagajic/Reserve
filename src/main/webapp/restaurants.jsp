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
    <body class="restaurants">
        <!-- Navbar -->
        <nav class="navbar navbar-inverse sticky">
            <div class="container">
                <ul class="nav navbar-nav">
                    <li><a href="index.jsp">Home</a></li>
                    <li class="selected-nav-item"><a href=<c:url value="/restaurant/getAll"/>>Restaurants</a></li>
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
                    <c:forEach items="${restaurants}" var="restaurant">
                        <div class="restaurant row animated fadeIn" data-toggle="modal" data-target="#restaurantModal"
                             onclick="setRestaurant({name:'${restaurant.name}', image: '${restaurant.image}'}); clearReservationDiv(); clearCommentsDiv(); clearLeaveCommentDiv()">
                            <div class="col-sm-3">
                                <img src="${restaurant.image}">
                            </div>
                            <div class="col-sm-4">
                                <div class="restaurant-header">
                                    ${restaurant.name}
                                </div>
                                <div class="stars">
                                    <c:if test="${restaurant.stars == 0}">
                                        <span class="fa fa-star"></span>
                                        <span class="fa fa-star"></span>
                                        <span class="fa fa-star"></span>
                                        <span class="fa fa-star"></span>
                                        <span class="fa fa-star"></span>
                                    </c:if>
                                    <c:if test="${restaurant.stars == 1}">
                                        <span class="fa fa-star checked"></span>
                                        <span class="fa fa-star"></span>
                                        <span class="fa fa-star"></span>
                                        <span class="fa fa-star"></span>
                                        <span class="fa fa-star"></span>
                                    </c:if>
                                    <c:if test="${restaurant.stars == 2}">
                                        <span class="fa fa-star checked"></span>
                                        <span class="fa fa-star checked"></span>
                                        <span class="fa fa-star"></span>
                                        <span class="fa fa-star"></span>
                                        <span class="fa fa-star"></span>
                                    </c:if>
                                    <c:if test="${restaurant.stars == 3}">
                                        <span class="fa fa-star checked"></span>
                                        <span class="fa fa-star checked"></span>
                                        <span class="fa fa-star checked"></span>
                                        <span class="fa fa-star"></span>
                                        <span class="fa fa-star"></span>
                                    </c:if>
                                    <c:if test="${restaurant.stars == 4}">
                                        <span class="fa fa-star checked"></span>
                                        <span class="fa fa-star checked"></span>
                                        <span class="fa fa-star checked"></span>
                                        <span class="fa fa-star checked"></span>
                                        <span class="fa fa-star"></span>
                                    </c:if>
                                    <c:if test="${restaurant.stars == 5}">
                                        <span class="fa fa-star checked"></span>
                                        <span class="fa fa-star checked"></span>
                                        <span class="fa fa-star checked"></span>
                                        <span class="fa fa-star checked"></span>
                                        <span class="fa fa-star checked"></span>
                                    </c:if>
                                </div>

                                <div class="info">
                                    <ion-icon name="pin"></ion-icon> ${restaurant.location}<br>
                                    <ion-icon name="time"></ion-icon> ${restaurant.workingHours}<br>
                                    <ion-icon name="phone-portrait"></ion-icon> ${restaurant.number}
                                </div>
                            </div>
                            <div class="col-sm-5">
                                <c:if test="${restaurant.promoCode != 0}">
                                    <div class="about-label-green">Promo code</div>
                                </c:if>
                                <c:if test="${not empty restaurant.additionalLabel}">
                                    <div class="about-label-gray">${restaurant.additionalLabel}</div>
                                </c:if>
                                <div class="about">
                                        ${restaurant.about}
                                </div>
                            </div>
                        </div>
                    </c:forEach>

                    <!-- Modal -->
                    <div id="restaurantModal" class="modal fade" role="dialog">
                        <div class="modal-dialog">

                            <!-- Modal content-->
                            <div class="modal-content">
                                <div class="modal-header">
                                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                                    <h4 id="modalRestaurantTitle" class="modal-title"></h4>
                                </div>
                                <div class="modal-body">
                                    <img id="modalRestaurantImage" src="">
                                    <button id="reservationButton" class="show-button" onclick="showReservationDiv()">Make reservation</button>
                                    <button id="showCommentsButton" class="show-button" onclick="showCommentsDiv()">Show comments</button>
                                    <button id="showLeaveCommentButton" class="show-button" onclick="showLeaveCommentDiv()">Leave comment</button>
                                </div>

                                <!-- Reservation -->
                                <div id="modalReservationDiv" class="animated fadeIn">
                                    <h3>Reservation</h3>
                                    <form class="modal-form" action="${pageContext.request.contextPath}/reservation/add" method="post">
                                        <input id="formRestaurantName" type="hidden" name="restaurantName">
                                        <div class="form-group">
                                            <input class="form-control" type="text" name="numberOfPersons" placeholder="Number of persons*">
                                        </div>
                                        <div class="form-group">
                                            <input class="form-control" type="text" name="time" placeholder="Time*">
                                        </div>
                                        <div class="form-group">
                                            <input  class="modal-submit" type="submit" value="Submit">
                                        </div>
                                    </form>
                                    <c:if test="${empty username}">
                                        <div class="modal-error-text">
                                            You must be logged in to make a reservation
                                        </div>
                                    </c:if>
                                </div>

                                <!-- Comments -->
                                <div id="modalCommentsDiv" class="animated fadeIn">
                                    <h3>Comments</h3>
                                    <div class="comments">
                                        <c:forEach items="${comments}" var="comment">
                                            <div class="comment">
                                                ${comment.comment}
                                                <div id="userCommented" class="user-commented">${comment.user.username}</div>
                                                <div class="commented-restaurant">${comment.restaurant.name}</div>
                                            </div>
                                        </c:forEach>
                                    </div>
                                </div>

                                <!-- Leave comment -->
                                <div id="modalLeaveCommentDiv" class="animated fadeIn">
                                    <h3>Comment</h3>
                                    <form action="/comment/add" method="post">
                                        <input id="formCommentRestaurantName" type="hidden" name="restaurantName">
                                        <div class="form-group">
                                            <textarea placeholder="Write your comment here" name="comment"></textarea>
                                        </div>
                                        <div class="form-group">
                                            <input  class="modal-submit" type="submit" value="Submit">
                                        </div>
                                    </form>
                                </div>

                                <div class="modal-footer">
                                    <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                                </div>
                            </div>

                        </div>
                    </div>
                </div>
            </div>
        </div>

        <script src="https://unpkg.com/ionicons@4.1.2/dist/ionicons.js"></script>
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
        <script>
            var reservationOpen = false;
            var commentsOpen = false;
            var leaveCommentOpen = false;

            function setRestaurant(restaurant) {
                document.getElementById("modalRestaurantTitle").innerHTML = restaurant.name;
                document.getElementById("modalRestaurantImage").src = restaurant.image;
            }

            function showReservationDiv() {
                if (!reservationOpen) {
                    document.getElementById('modalReservationDiv').style.display = "block";
                    document.getElementById('reservationButton').style.background = "#333";
                    document.getElementById("modalRestaurantImage").style.display = "none";
                    document.getElementById('formRestaurantName').value = document.getElementById('modalRestaurantTitle').innerHTML;
                    reservationOpen = true;
                } else {
                    document.getElementById('modalReservationDiv').style.display = "none";
                    document.getElementById('reservationButton').style.background = "#555";
                    document.getElementById("modalRestaurantImage").style.display = "block";
                    document.getElementById('reservationButton').onmouseover = function () {
                        this.style.background = '#333';
                    }
                    document.getElementById('reservationButton').onmouseleave = function () {
                        if (!reservationOpen) {
                            this.style.background = '#555';
                        }
                    }
                    reservationOpen = false;
                }

                clearCommentsDiv();
                clearLeaveCommentDiv();
            }

            function showCommentsDiv() {
                if (!commentsOpen) {
                    document.getElementById('modalCommentsDiv').style.display = "block";
                    document.getElementById('showCommentsButton').style.background = "#333";
                    document.getElementById("modalRestaurantImage").style.display = "none";
                    commentsOpen = true;
                } else {
                    document.getElementById('modalCommentsDiv').style.display = "none";
                    document.getElementById('showCommentsButton').style.background = "#555";
                    document.getElementById("modalRestaurantImage").style.display = "block";
                    document.getElementById('showCommentsButton').onmouseover = function () {
                        this.style.background = '#333';
                    }
                    document.getElementById('showCommentsButton').onmouseleave = function () {
                        if (!commentsOpen) {
                            this.style.background = '#555';
                        }
                    }
                    commentsOpen = false;
                }

                // Show only comments for selected restaurant
                var comments = document.getElementsByClassName("comment");
                var i;
                for (i = 0; i < comments.length; i++) {
                    if (comments[i].innerText.substr(comments[i].innerText.length - document.getElementById("modalRestaurantTitle").innerText.length - 1, comments[i].innerText.length - 1)
                            .includes(document.getElementById("modalRestaurantTitle").innerText)) {
                        comments[i].style.position = "relative";
                        comments[i].style.left = "0";
                    } else {
                        comments[i].style.position = "absolute";
                        comments[i].style.left = "-9999px";
                    }
                }

                clearReservationDiv();
                clearLeaveCommentDiv();
            }

            function showLeaveCommentDiv() {
                if (!leaveCommentOpen) {
                    document.getElementById('modalLeaveCommentDiv').style.display = "block";
                    document.getElementById('showLeaveCommentButton').style.background = "#333";
                    document.getElementById("modalRestaurantImage").style.display = "none";
                    document.getElementById('formCommentRestaurantName').value = document.getElementById('modalRestaurantTitle').innerHTML;
                    leaveCommentOpen = true;
                } else {
                    document.getElementById('modalLeaveCommentDiv').style.display = "none";
                    document.getElementById('showLeaveCommentButton').style.background = "#555";
                    document.getElementById("modalRestaurantImage").style.display = "block";
                    document.getElementById('showLeaveCommentButton').onmouseover = function () {
                        this.style.background = '#333';
                    }
                    document.getElementById('showLeaveCommentButton').onmouseleave = function () {
                        if (!leaveCommentOpen) {
                            this.style.background = '#555';
                        }
                    }
                    leaveCommentOpen = false;
                }

                clearReservationDiv();
                clearCommentsDiv();
            }

            function clearReservationDiv() {
                if (reservationOpen) {
                    document.getElementById('modalReservationDiv').style.display = "none";
                    document.getElementById('reservationButton').style.background = "#555";
                    if (!commentsOpen && !leaveCommentOpen) {
                        document.getElementById("modalRestaurantImage").style.display = "block";
                    }
                    document.getElementById('reservationButton').onmouseover = function () {
                        this.style.background = '#333';
                    }
                    document.getElementById('reservationButton').onmouseleave = function () {
                        if (!reservationOpen) {
                            this.style.background = '#555';
                        }
                    }
                    reservationOpen = false;
                }
            }

            function clearCommentsDiv() {
                if (commentsOpen) {
                    document.getElementById('modalCommentsDiv').style.display = "none";
                    document.getElementById('showCommentsButton').style.background = "#555";
                    if (!reservationOpen && !leaveCommentOpen) {
                        document.getElementById("modalRestaurantImage").style.display = "block";
                    }
                    document.getElementById('showCommentsButton').onmouseover = function () {
                        this.style.background = '#333';
                    }
                    document.getElementById('showCommentsButton').onmouseleave = function () {
                        if (!commentsOpen) {
                            this.style.background = '#555';
                        }
                    }
                    commentsOpen = false;
                }
            }

            function clearLeaveCommentDiv() {
                if (leaveCommentOpen) {
                    document.getElementById('modalLeaveCommentDiv').style.display = "none";
                    document.getElementById('showLeaveCommentButton').style.background = "#555";
                    if (!reservationOpen && !commentsOpen) {
                        document.getElementById("modalRestaurantImage").style.display = "block";
                    }
                    document.getElementById('showLeaveCommentButton').onmouseover = function () {
                        this.style.background = '#333';
                    }
                    document.getElementById('showLeaveCommentButton').onmouseleave = function () {
                        if (!leaveCommentOpen) {
                            this.style.background = '#555';
                        }
                    }
                    leaveCommentOpen = false;
                }
            }
        </script>
    </body>
</html>
