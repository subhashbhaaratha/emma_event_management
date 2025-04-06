package controllers;

import dao.EventDAO;
import models.Event;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.sql.Date;
import java.util.regex.Pattern;

@WebServlet("/EventServlet")
public class EventServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");

        if ("create".equals(action)) {
            String title = request.getParameter("title");
            String eventDateStr = request.getParameter("eventDate"); // FIXED: Match the form field name
            String location = request.getParameter("location");
            String description = request.getParameter("description");
            String eventType = request.getParameter("eventType"); // FIXED: Match the form field name

            // Validate event date
            if (eventDateStr == null || eventDateStr.isEmpty() || !isValidDate(eventDateStr)) {
                response.sendRedirect("create_event.jsp?error=Invalid date format. Use YYYY-MM-DD.");
                return;
            }

            Date eventDate = Date.valueOf(eventDateStr); // Safe conversion

            // Get logged-in user's ID
            HttpSession session = request.getSession(false);
            if (session == null || session.getAttribute("userId") == null) {
                response.sendRedirect("login.jsp?error=Please login first.");
                return;
            }
            int createdBy = (int) session.getAttribute("userId");

            // Save event
            try {
                EventDAO.createEvent(new Event(0, title, eventDate, location, description, eventType, createdBy));
                response.sendRedirect("organizer_dashboard.jsp?success=Event created successfully.");
            } catch (Exception e) {
                e.printStackTrace();
                response.sendRedirect("create_event.jsp?error=Database error while creating event.");
            }
        }
    }

    // Utility method to validate date format
    private boolean isValidDate(String date) {
        String regex = "^\\d{4}-\\d{2}-\\d{2}$"; // YYYY-MM-DD format
        return Pattern.matches(regex, date);
    }
}
