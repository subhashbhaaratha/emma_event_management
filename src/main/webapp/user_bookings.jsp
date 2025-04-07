<%@ page import="java.util.List" %>
<%@ page import="models.Booking" %>
<%@ page import="dao.BookingDAO" %>
<%@ page import="jakarta.servlet.http.HttpSession" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%
    HttpSession sessionUser = request.getSession(false);
    if (sessionUser == null || !"user".equals(sessionUser.getAttribute("role"))) {
        response.sendRedirect("login.jsp?error=Unauthorized access");
        return;
    }

    int userId = (sessionUser.getAttribute("userId") != null) ? (int) sessionUser.getAttribute("userId") : -1;
    List<Booking> userBookings = BookingDAO.getBookingsByUserId(userId);
    
    // Success message handling
    String bookingMessage = request.getParameter("message");
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>My Bookings - Event Management</title>

    <!-- Bootstrap 5 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">

    <style>
        body {
            font-family: "Times New Roman", Times, serif;
            background-color: #e6e6e6; /* Changed background color */
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
            color: #d9534f !important; /* Making Event Management stand out */
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
<nav class="navbar navbar-expand-lg navbar-dark bg-dark">
    <div class="container">
        <a class="navbar-brand" href="user_dashboard.jsp">Event Management</a>
        <div class="collapse navbar-collapse">
            <ul class="navbar-nav ms-auto">
                <li class="nav-item">
                    <a class="nav-link btn btn-outline-light me-2" href="user_dashboard.jsp">Dashboard</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link btn btn-outline-light" href="logout.jsp">Logout</a>
                </li>
            </ul>
        </div>
    </div>
</nav>

<!-- Main Content -->
<div class="container">
    <div class="row mt-4">
        <div class="col-md-12">
            <h2 class="text-center text-danger">My Bookings</h2>
            
            <!-- Success/Error Message -->
            <% if (bookingMessage != null) { %>
                <div class="message <%= bookingMessage.contains("success") ? "success" : "error" %>" id="message-box">
                    <%= bookingMessage %>
                </div>
            <% } %>

            <!-- Bookings Table -->
            <div class="table-responsive mt-4">
                <table class="table table-bordered table-hover shadow-sm rounded">
                    <thead class="table-dark">
                        <tr>
                            <th>Event Title</th>
                            <th>Date</th>
                            <th>Location</th>
                            <th>Action</th>
                        </tr>
                    </thead>
                    <tbody>
                        <% for (Booking booking : userBookings) { %>
                            <tr>
                                <td><%= booking.getEventTitle() %></td>
                                <td><%= booking.getEventDate() %></td>
                                <td><%= booking.getEventLocation() %></td>
                                <td>
                                    <form action="DeleteUserBookingServlet" method="post">
                                        <input type="hidden" name="bookingId" value="<%= booking.getId() %>">
                                        <button type="submit" class="btn btn-danger">Cancel Booking</button>
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

<!-- Auto-hide success message after 3 seconds -->
<script>
    setTimeout(() => {
        let messageBox = document.getElementById("message-box");
        if (messageBox) {
            messageBox.style.display = "none";
        }
    }, 3000);
</script>

</body>
</html>
