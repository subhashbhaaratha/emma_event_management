package controllers;

import dao.UserDAO;
import models.User;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.sql.SQLException;

@WebServlet("/UserServlet")
public class UserServlet extends HttpServlet {
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Redirect GET requests to login page instead of showing an error
        response.sendRedirect("login.jsp?error=Invalid request");
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");

        if ("register".equals(action)) {
            registerUser(request, response);
        } else if ("login".equals(action)) {
            loginUser(request, response);
        } else {
            response.sendRedirect("login.jsp?error=Invalid action");
        }
    }

    private void registerUser(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String role = request.getParameter("role"); // "organizer" or "user"

        try {
            // Check if email is already registered
            if (UserDAO.getUserByEmail(email) != null) {
                response.sendRedirect("register.jsp?error=Email already registered");
                return;
            }

            User newUser = new User(0, name, email, password, role);
            boolean success = UserDAO.registerUser(newUser);
            if (success) {
                response.sendRedirect("login.jsp?success=Registration successful, please login");
            } else {
                response.sendRedirect("register.jsp?error=Registration failed");
            }
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendRedirect("register.jsp?error=Database error");
        }
    }

    private void loginUser(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String email = request.getParameter("email");
        String password = request.getParameter("password");

        try {
            User user = UserDAO.loginUser(email, password);
            if (user != null) {
                HttpSession session = request.getSession();
                session.setAttribute("userId", user.getId());
                session.setAttribute("role", user.getRole());

                // Redirect based on role
                if ("admin".equals(user.getRole())) {
                    response.sendRedirect("admin_dashboard.jsp");
                } else if ("organizer".equals(user.getRole())) {
                    response.sendRedirect("organizer_dashboard.jsp");
                } else { // Default to user
                    response.sendRedirect("user_dashboard.jsp");
                }
            } else {
                response.sendRedirect("login.jsp?error=Invalid credentials");
            }
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendRedirect("login.jsp?error=Database error");
        }
    }
}
