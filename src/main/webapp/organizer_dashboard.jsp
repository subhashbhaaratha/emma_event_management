<%@ page import="java.util.List" %>
<%@ page import="models.Event, models.Booking" %>
<%@ page import="dao.EventDAO, dao.BookingDAO" %>
<%@ page import="jakarta.servlet.http.HttpSession" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%
    HttpSession sessionOrganizer = request.getSession(false);
    if (sessionOrganizer == null || !"organizer".equals(sessionOrganizer.getAttribute("role"))) {
        response.sendRedirect("login.jsp?error=Unauthorized access");
        return;
    }

    int organizerId = (int) sessionOrganizer.getAttribute("userId");
    List<Event> events = EventDAO.getEventsByOrganizer(organizerId);

    String successMessage = request.getParameter("success");
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Organizer Dashboard | Event Management</title>
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
            background-color: #6d4c41 !important; /* Brown color */
        }
        .navbar-brand {
            font-size: 36px;
            font-weight: bold;
            color: #fff !important;
        }
        .table th { 
            background-color: #8d6e63; /* Coffee color */
            color: white; 
        }
        .btn-create { background-color: #5d4037; color: white; }
        .btn-create:hover { background-color: #4e342e; }
        .btn-rsvp { background-color: #6d4c41; color: white; }
        .btn-rsvp:hover { background-color: #5d4037; }
        .btn-delete { background-color: #a93226; color: white; }
        .btn-delete:hover { background-color: #922b21; }
        .btn-booking { background-color: #34495e; color: white; }
        .btn-booking:hover { background-color: #2c3e50; }
        .nav-link { color: white !important; font-size: 16px; }
        .success-message {
            display: <%= (successMessage != null) ? "block" : "none" %>;
            background-color: #28a745;
            color: white;
            text-align: center;
            padding: 10px;
            margin-bottom: 15px;
            border-radius: 5px;
            font-size: 18px;
        }
    </style>
</head>
<body>
    <nav class="navbar navbar-expand-lg navbar-dark">
        <div class="container">
            <a class="navbar-brand" href="#">Event Management</a>
            <div class="collapse navbar-collapse">
                <ul class="navbar-nav ms-auto">
                    <li class="nav-item"><a class="nav-link" href="create_event.jsp">Create Event</a></li>
                    <li class="nav-item"><a class="nav-link text-danger" href="logout.jsp">Logout</a></li>
                </ul>
            </div>
        </div>
    </nav>

    <% if (successMessage != null) { %>
        <div class="container">
            <div class="success-message" id="successMessage">
                <%= successMessage %>
            </div>
        </div>
    <% } %>

    <div class="container dashboard-container">
        <h2 class="mb-4 text-dark">Organizer Dashboard</h2>
        <div class="d-flex justify-content-between mb-3">
            <h4>Events</h4>
	        </div>

        <div class="table-responsive">
            <table class="table table-striped table-hover">
                <thead>
                    <tr>
                        <th>Title</th>
                        <th>Date</th>
                        <th>Location</th>
                        <th>Description</th>
                        <th>Type</th>
                        <th>RSVP</th>
                        <th>Bookings</th>
                        <th>Action</th>
                    </tr>
                </thead>
                <tbody>
                    <% if (events.isEmpty()) { %>
                        <tr><td colspan="8" class="text-center text-muted">No events created yet.</td></tr>
                    <% } else { 
                        for (Event event : events) { %>
                            <tr>
                                <td><%= event.getTitle() %></td>
                                <td><%= event.getEventDate() %></td>
                                <td><%= event.getLocation() %></td>
                                <td><%= event.getDescription() %></td>
                                <td><%= event.getEventType() %></td>
                                <td>
                                    <a href="RSVPServlet?eventId=<%= event.getId() %>" class="btn btn-rsvp btn-sm">
                                        View RSVPs
                                    </a>
                                </td>
                                <td>
                                    <a href="booking_details.jsp?eventId=<%= event.getId() %>" class="btn btn-booking btn-sm">
                                        View Bookings
                                    </a>
                                </td>
                                <td>
                                    <a href="DeleteEventServlet?eventId=<%= event.getId() %>" class="btn btn-delete btn-sm"
                                       onclick="return confirm('Are you sure you want to delete this event?');">
                                        Delete
                                    </a>
                                </td>
                            </tr>
                        <% }
                    } %>
                </tbody>
            </table>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        // Hide the success message after 3 seconds
        setTimeout(() => {
            let messageBox = document.getElementById('successMessage');
            if (messageBox) {
                messageBox.style.display = 'none';
            }
        }, 3000);
    </script>
</body>
</html>
