<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ page import="java.util.List, models.RSVP" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>RSVP List | Event Management</title>

    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- FontAwesome for Icons -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css">

    <style>
        body {
            background-color: #f4f1ea;
            font-family: 'Times New Roman', Times, serif;
        }
        .dashboard-container {
            max-width: 900px;
            margin: 50px auto;
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
        .table td {
            text-align: center;
        }
        .badge-success {
            background-color: #28a745;
        }
        .badge-danger {
            background-color: #a93226;
        }
        .btn-back {
            background-color: #6d4c41;
            color: white;
        }
        .btn-back:hover {
            background-color: #5d4037;
        }
        .nav-link {
            color: white !important;
            font-size: 16px;
        }
    </style>
</head>
<body>
    <!-- Navigation Bar -->
    <nav class="navbar navbar-expand-lg navbar-dark">
        <div class="container">
            <a class="navbar-brand" href="organizer_dashboard.jsp">
                Event Management
            </a>
            <div class="collapse navbar-collapse">
                <ul class="navbar-nav ms-auto">
                    <li class="nav-item">
                        <a class="nav-link" href="organizer_dashboard.jsp">Dashboard</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link text-danger" href="logout.jsp">Logout</a>
                    </li>
                </ul>
            </div>
        </div>
    </nav>

    <!-- RSVP List Container -->
    <div class="container dashboard-container">
        <h2 class="mb-4 text-dark text-center">
            <i class="fas fa-users"></i> RSVP List for Event
        </h2>

        <!-- RSVP Table -->
        <div class="table-responsive">
            <table class="table table-striped table-hover">
                <thead>
                    <tr>
                        <th>User ID</th>
                        <th>User Name</th>
                        <th>Status</th>
                    </tr>
                </thead>
                <tbody>
                    <% List<RSVP> rsvpList = (List<RSVP>) request.getAttribute("rsvpList");
                        if (rsvpList != null && !rsvpList.isEmpty()) {
                            for (RSVP rsvp : rsvpList) { %>
                                <tr>
                                    <td><%= rsvp.getUserId() %></td>
                                    <td><%= rsvp.getUserName() %></td>
                                    <td>
                                        <span class="badge <%= rsvp.getStatus().equals("Going") ? "badge-success" : "badge-danger" %>">
                                            <%= rsvp.getStatus() %>
                                        </span>
                                    </td>
                                </tr>
                    <% } } else { %>
                        <tr>
                            <td colspan="3" class="text-center text-muted">No RSVPs found for this event.</td>
                        </tr>
                    <% } %>
                </tbody>
            </table>
        </div>

        <!-- Back Button -->
        <div class="text-center">
            <a href="organizer_dashboard.jsp" class="btn btn-back">
                <i class="fas fa-arrow-left"></i> Back to Dashboard
            </a>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
