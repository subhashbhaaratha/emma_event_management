<%@ page import="java.util.List" %>
<%@ page import="models.Event" %>
<%@ page import="dao.EventDAO" %>
<%@ page import="jakarta.servlet.http.HttpSession" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%
    HttpSession sessionUser = request.getSession(false);
    if (sessionUser == null || !"user".equals(sessionUser.getAttribute("role"))) {
        response.sendRedirect("login.jsp?error=Unauthorized access");
        return;
    }

    // Get User ID
    int userId = (sessionUser.getAttribute("userId") != null) 
        ? (int) sessionUser.getAttribute("userId") 
        : -1;

    // Get search query
    String searchQuery = request.getParameter("search");
    List<Event> events = (searchQuery != null && !searchQuery.isEmpty()) 
        ? EventDAO.searchEvents(searchQuery, "")  
        : EventDAO.getAllEvents();

    // Booking messages
    String bookingMessage = request.getParameter("message");
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>User Dashboard - Event Management</title>

    <!-- Bootstrap 5 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">

    <style>
        body {
            background-color: #e6e6e6; /* Changed from blue */
            font-family: 'Times New Roman', Times, serif;
        }
        .container {
            margin-top: 20px;
        }
        .table {
            background-color: white;
        }
        .navbar {
            background-color: #333 !important; /* Dark gray */
        }
        .navbar-brand {
            font-weight: bold;
            font-size: 3rem;
            color: #d9534f !important;
        }
        .nav-link {
            color: white !important;
        }
        .btn-white {
            color: white !important;
            border-color: white !important;
        }
        .btn-outline-light {
            color: white;
            border-color: white;
        }
         .btn-outline-light:hover {
            background-color: white;
            color: black;
        }
        .message {
            padding: 10px;
            border-radius: 5px;
            margin-bottom: 10px;
            text-align: center;
            font-weight: bold;
        }
        .message.success {
            background-color: #d4edda;
            color: #155724;
        }
        .message.error {
            background-color: #f8d7da;
            color: #721c24;
        }
    </style>
</head>
<body>

    <!-- Navbar -->
    <nav class="navbar navbar-expand-lg">
        <div class="container">
            <a class="navbar-brand text-light" href="#">Event Management</a>
            <div class="collapse navbar-collapse">
                <ul class="navbar-nav ms-auto">
                    <li class="nav-item">
                        <a class="nav-link btn btn-white me-2" href="user_bookings.jsp">View My Bookings</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link btn btn-white" href="logout.jsp">Logout</a>
                    </li>
                </ul>
            </div>
        </div>
    </nav>

    <!-- Main Content -->
    <div class="container">
        <div class="row mt-4">
            <div class="col-md-12">
                <h2 class="text-center text-dark">Explore and Manage Your Events</h2>
                
                <!-- Success/Error Message -->
                <% if (bookingMessage != null) { %>
                    <div class="message <%= bookingMessage.contains("success") ? "success" : "error" %>" id="messageBox">
                        <%= bookingMessage %>
                    </div>
                <% } %>

                <!-- Search Bar -->
                <form method="get" action="user_dashboard.jsp" class="input-group mt-4">
                    <input type="text" class="form-control" name="search" placeholder="Search events..." value="<%= (searchQuery != null) ? searchQuery : "" %>">
                    <button type="submit" class="btn btn-dark">Search</button>
                </form>

                <!-- Events Table -->
                <div class="table-responsive mt-4">
                    <table class="table table-bordered table-hover shadow-sm rounded">
                        <thead class="table-dark">
                            <tr>
                                <th>Title</th>
                                <th>Date</th>
                                <th>Location</th>
                                <th>Description</th>
                                <th>Event Type</th>
                                <th>RSVP</th>
                                <th>Book Event</th>
                            </tr>
                        </thead>
                        <tbody>
                            <% for (Event event : events) { %>
                                <tr>
                                    <td><%= event.getTitle() %></td>
                                    <td><%= event.getEventDate() %></td>
                                    <td><%= event.getLocation() %></td>
                                    <td><%= event.getDescription() %></td>
                                    <td><%= event.getEventType() %></td>
                                    <td>
                                        <form action="RSVPServlet" method="post" class="rsvp-form">
                                            <input type="hidden" name="eventId" value="<%= event.getId() %>">
                                            <select name="status" class="form-select">
                                                <option value="Going">Going</option>
                                                <option value="Not Going">Not Going</option>
                                            </select>
                                            <button type="submit" class="btn btn-success mt-2">Submit</button>
                                        </form>
                                    </td>
                                    <td>
                                        <form action="BookEventServlet" method="post" class="book-form">
                                            <input type="hidden" name="eventId" value="<%= event.getId() %>">
                                            <input type="hidden" name="userId" value="<%= userId %>">
                                            <button type="submit" class="btn btn-primary">Book Now</button>
                                        </form>
                                    </td>
                                </tr>
                            <% } %>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>

    <!-- Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

    <!-- Hide success message after 3 seconds -->
    <script>
        setTimeout(function() {
            var messageBox = document.getElementById("messageBox");
            if (messageBox) {
                messageBox.style.display = "none";
            }
        }, 3000);
    </script>

</body>
</html>
