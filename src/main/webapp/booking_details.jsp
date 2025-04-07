<%@ page import="java.util.List" %>
<%@ page import="models.Booking" %>
<%@ page import="dao.BookingDAO" %>
<%@ page import="jakarta.servlet.http.HttpSession" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%
    String eventIdParam = request.getParameter("eventId");
    int eventId = 0;

    if (eventIdParam != null && !eventIdParam.isEmpty()) {
        try {
            eventId = Integer.parseInt(eventIdParam);
        } catch (NumberFormatException e) {
            eventId = 0; // Default value if invalid
        }
    }

    if (eventId == 0) {
        out.println("<p class='text-danger text-center'>Invalid Event ID. Please go back and select an event.</p>");
        return;
    }

    List<Booking> bookings = BookingDAO.getBookingsByEvent(eventId);
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Booking Details | Event Management</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css">
    <style>
        body { 
            background-color: #f4f1ea; 
            font-family: 'Times New Roman', Times, serif;
        }
        .dashboard-container {
            max-width: 1200px;
            margin: 40px auto;
            background: white;
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0px 4px 10px rgba(0, 0, 0, 0.15);
        }
        .navbar-dark {
            background-color: #6d4c41 !important;
        }
        .navbar-brand {
            font-size: 36px;
            font-weight: bold;
            color: #fff !important;
        }
        .table th { 
            background-color: #8d6e63;
            color: white; 
        }
        .btn-back { background-color: #5d4037; color: white; }
        .btn-back:hover { background-color: #4e342e; }
        .btn-delete { background-color: #a93226; color: white; }
        .btn-delete:hover { background-color: #922b21; }
        .nav-link { color: white !important; font-size: 16px; }
    </style>
</head>
<body>
    <nav class="navbar navbar-expand-lg navbar-dark">
        <div class="container">
            <a class="navbar-brand" href="#">Event Management</a>
            <div class="collapse navbar-collapse">
                <ul class="navbar-nav ms-auto">
                    <li class="nav-item"><a class="nav-link" href="organizer_dashboard.jsp">Dashboard</a></li>
                    <li class="nav-item"><a class="nav-link text-danger" href="logout.jsp">Logout</a></li>
                </ul>
            </div>
        </div>
    </nav>

    <div class="container dashboard-container">
        <h2 class="mb-4 text-dark">Booking Details</h2>
        <div class="table-responsive">
            <table class="table table-striped table-hover">
                <thead>
                    <tr>
                        <th>Booking ID</th>
                        <th>User Name</th>
                        <th>Event Title</th>
                        <th>Booking Date</th>
                        <th>Action</th>
                    </tr>
                </thead>
                <tbody>
                    <% if (bookings.isEmpty()) { %>
                        <tr><td colspan="5" class="text-center text-muted">No bookings found for this event.</td></tr>
                    <% } else { 
                        for (Booking booking : bookings) { %>
                            <tr>
                                <td><%= booking.getId() %></td>
                                <td><%= booking.getUserName() %></td>
                                <td><%= booking.getEventTitle() %></td>
                                <td><%= booking.getBookingDate() %></td>
                                <td>
                                    <a href="DeleteBookingServlet?bookingId=<%= booking.getId() %>" 
                                       class="btn btn-delete btn-sm" 
                                       onclick="return confirm('Are you sure you want to delete this booking?');">
                                        Delete
                                    </a>
                                </td>
                            </tr>
                        <% }
                    } %>
                </tbody>
            </table>
        </div>
        <a href="organizer_dashboard.jsp" class="btn btn-back"><i class="fas fa-arrow-left"></i> Back</a>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
