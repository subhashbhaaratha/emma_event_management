<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page pageEncoding="UTF-8" %>
<%@ page session="true" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Login - Emma’s Event Management</title>

    <!-- Bootstrap 5 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">

    <style>
        body {
            background: linear-gradient(to right, #ff9a9e, #fad0c4, #fad0c4, #ffdde1);
            min-height: 100vh;
            display: flex;
            flex-direction: column;
        }
        .navbar {
            background: linear-gradient(to right, #ff6f61, #de6262);
        }
        .navbar-brand {
            font-weight: bold;
            font-size: 1.6rem;
        }
        .login-container {
            max-width: 400px;
            margin: auto;
            background: white;
            padding: 30px;
            border-radius: 15px;
            box-shadow: 0px 0px 20px rgba(0, 0, 0, 0.2);
            text-align: center;
            margin-top: 80px;
        }
        .form-control {
            margin-bottom: 15px;
            border-radius: 8px;
        }
        .btn-primary {
            width: 100%;
            border-radius: 8px;
            background: #ff6f61;
            border: none;
            font-weight: bold;
        }
        .btn-primary:hover {
            background: #e64c3c;
        }
        .register-link {
            margin-top: 10px;
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
                        <a class="nav-link" href="events.jsp">Events</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link btn btn-outline-light" href="register.jsp">Register</a>
                    </li>
                </ul>
            </div>
        </div>
    </nav>

    <!-- Login Section -->
    <div class="container">
        <div class="login-container">
            <h3 class="text-primary">Login</h3>
            <p class="text-muted">Access your event management account</p>

            <form action="UserServlet" method="post">
                <input type="hidden" name="action" value="login">
                
                <div class="mb-3">
                    <label class="form-label">Email:</label>
                    <input type="email" name="email" class="form-control" required>
                </div>

                <div class="mb-3">
                    <label class="form-label">Password:</label>
                    <input type="password" name="password" class="form-control" required>
                </div>

                <button type="submit" class="btn btn-primary">Login</button>
            </form>

            <p class="register-link">Don't have an account? <a href="register.jsp">Register here</a></p>
        </div>
    </div>

    <!-- Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>
