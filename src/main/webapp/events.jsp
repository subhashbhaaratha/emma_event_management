<%@ page import="java.util.List, models.Event, dao.EventDAO" %>
<%@ page session="true" %>

<%
    List<Event> events = EventDAO.getAllEvents();
    String userRole = (String) session.getAttribute("role");
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Events - Emma’s Event Management</title>

    <!-- Bootstrap 5 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">

    <style>
        body {
            background: linear-gradient(to right, #ff9966, #ff5e62);
            min-height: 100vh;
            display: flex;
            flex-direction: column;
        }
        .navbar {
            background: linear-gradient(to right, #cc3300, #660000);
        }
        .navbar-brand {
            font-weight: bold;
            font-size: 1.6rem;
        }
        .container {
            margin-top: 50px;
        }
        .event-card {
            background: white;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0px 4px 8px rgba(0, 0, 0, 0.2);
            margin-bottom: 20px;
        }
        .btn-custom {
            border-radius: 8px;
            font-weight: bold;
        }
        .btn-danger {
            background: #cc0000;
            border: none;
        }
        .btn-danger:hover {
            background: #990000;
        }
    </style>
</head>
<body>

    <!-- Navigation Bar -->
    <nav class="navbar navbar-expand-lg navbar-dark">
        <div class="container">
            <a class="navbar-brand" href="index.jsp">Emma’s Event Management</a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarNav">
                <ul class="navbar-nav ms-auto">
                    <li class="nav-item">
                        <a class="nav-link" href="index.jsp">Home</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link active" href="events.jsp">Events</a>
                    </li>
                    <% if (session.getAttribute("role") != null) { %>
                        <li class="nav-item">
                            <a class="nav-link btn btn-outline-light" href="logout.jsp">Logout</a>
                        </li>
                    <% } %>
                </ul>
            </div>
        </div>
    </nav>

    <!-- Main Event Listings -->
    <div class="container">
        <h2 class="text-center text-light">Event Listings</h2>

        <% if ("organizer".equals(userRole)) { %>
            <div class="text-center">
                <a href="create_event.jsp" class="btn btn-primary btn-custom">Create New Event</a>
            </div>
        <% } %>

        <div class="row mt-4">
            <% for (Event event : events) { %>
                <div class="col-md-6">
                    <div class="event-card">
                        <h4 class="text-primary"><%= event.getTitle() %></h4>
                        <p><strong>Date:</strong> <%= event.getEventDate() %></p>
                        <p><strong>Location:</strong> <%= event.getLocation() %></p>
                        <p><%= event.getDescription() %></p>

                        <% if ("user".equals(userRole)) { %>
                            <form method="post" action="RSVPServlet">
                                <input type="hidden" name="eventId" value="<%= event.getId() %>">
                                <button type="submit" name="status" value="Going" class="btn btn-success btn-custom">RSVP: Going</button>
                                <button type="submit" name="status" value="Not Going" class="btn btn-secondary btn-custom">RSVP: Not Going</button>
                            </form>
                        <% } %>

                        <% if ("organizer".equals(userRole) && event.getCreatedBy() == (Integer) session.getAttribute("userId")) { %>
                            <form method="post" action="DeleteEventServlet" class="mt-2">
                                <input type="hidden" name="eventId" value="<%= event.getId() %>">
                                <button type="submit" class="btn btn-danger btn-custom">Delete</button>
                            </form>
                        <% } %>
                    </div>
                </div>
            <% } %>
        </div>
    </div>

    <!-- Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>
