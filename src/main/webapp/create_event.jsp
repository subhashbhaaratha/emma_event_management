<%@ page import="jakarta.servlet.http.HttpSession" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%
    HttpSession sessionOrganizer = request.getSession(false);
    if (sessionOrganizer == null || !"organizer".equals(sessionOrganizer.getAttribute("role"))) {
        response.sendRedirect("login.jsp?error=Unauthorized access");
        return;
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Create Event | Event Management</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css">
    <style>
        body {
            background-color: #f4f1ea;
            font-family: 'Times New Roman', Times, serif;
        }
        .dashboard-container {
            max-width: 900px;
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
        .btn-create {
            background-color: #5d4037;
            color: white;
        }
        .btn-create:hover {
            background-color: #4e342e;
        }
        .nav-link {
            color: white !important;
            font-size: 16px;
        }
    </style>
</head>
<body>
    <nav class="navbar navbar-expand-lg navbar-dark">
        <div class="container">
            <a class="navbar-brand" href="organizer_dashboard.jsp">Event Management</a>
            <div class="collapse navbar-collapse">
                <ul class="navbar-nav ms-auto">
                    <li class="nav-item"><a class="nav-link" href="organizer_dashboard.jsp">Dashboard</a></li>
                    <li class="nav-item"><a class="nav-link text-danger" href="logout.jsp">Logout</a></li>
                </ul>
            </div>
        </div>
    </nav>

    <div class="container dashboard-container">
        <h2 class="mb-4 text-dark text-center">Create a New Event</h2>
        <p class="text-muted text-center">Fill in the details below to create an event.</p>
        
        <form method="post" action="EventServlet">
            <input type="hidden" name="action" value="create">
            
            <div class="mb-3">
                <label class="form-label">Event Title:</label>
                <input type="text" name="title" class="form-control" required placeholder="Enter event title">
            </div>

            <div class="mb-3">
                <label class="form-label">Date:</label>
                <input type="date" name="eventDate" class="form-control" required>
            </div>

            <div class="mb-3">
                <label class="form-label">Location:</label>
                <input type="text" name="location" class="form-control" required placeholder="Enter event location">
            </div>

            <div class="mb-3">
                <label class="form-label">Description:</label>
                <textarea name="description" class="form-control" required placeholder="Describe the event"></textarea>
            </div>

            <div class="text-center">
                <button type="submit" class="btn btn-create btn-lg">Create Event</button>
            </div>
        </form>
    </div>
    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
