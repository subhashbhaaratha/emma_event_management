<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page pageEncoding="UTF-8" %>
<%@ page session="true" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Emma’s Event Management</title>

    <!-- Bootstrap 5 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">

    <style>
        body {
            background: linear-gradient(to right, #ff9a9e, #fad0c4, #fad0c4, #ffdde1);
            font-family: 'Poppins', sans-serif;
            color: #333;
        }
        .container {
            margin-top: 20px;
        }
        .hero-section {
            background: url('https://source.unsplash.com/1600x900/?festival,concert') center/cover no-repeat;
            height: 350px;
            display: flex;
            align-items: center;
            justify-content: center;
            color: black;
            text-align: center;
            font-size: 2rem;
            font-weight: bold;
            text-shadow: 3px 3px 10px rgba(0, 0, 0, 0.7);
            border-radius: 10px;
            margin-top: 20px;
        }
        .action-buttons {
            margin-top: 30px;
        }
        .navbar {
            background: linear-gradient(to right, #6a11cb, #2575fc);
        }
        .navbar-brand {
            font-size: 1.5rem;
            font-weight: bold;
        }
        .content-section {
            background: white;
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0px 0px 15px rgba(0, 0, 0, 0.1);
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
                    <% if (session.getAttribute("userId") == null) { %>
                        <li class="nav-item">
                            <a class="nav-link" href="login.jsp">Login</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="register.jsp">Register</a>
                        </li>
                    <% } else { %>
                        <li class="nav-item">
                            <a class="nav-link btn btn-outline-light me-2" href="events.jsp">View Events</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link btn btn-danger" href="logout.jsp">Logout</a>
                        </li>
                    <% } %>
                </ul>
            </div>
        </div>
    </nav>

    <!-- Hero Section -->
    <div class="container">
        <div class="hero-section">
            Welcome to Emma’s Event Management
        </div>
    </div>

    <!-- Content Section -->
    <div class="container text-center mt-4">
        <div class="content-section">
            <p class="fs-5">Easily create, explore, and manage events with ease.</p>
            <% if (session.getAttribute("userId") == null) { %>
                <div class="action-buttons">
                    <a href="login.jsp" class="btn btn-primary btn-lg me-2">Login</a>
                    <a href="register.jsp" class="btn btn-success btn-lg">Register</a>
                </div>
            <% } else { %>
                <div class="action-buttons">
                    <a href="events.jsp" class="btn btn-info btn-lg">Explore Events</a>
                    <a href="logout.jsp" class="btn btn-danger btn-lg ms-2">Logout</a>
                </div>
            <% } %>
        </div>
    </div>

    <!-- Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>