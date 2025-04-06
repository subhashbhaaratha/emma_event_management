package controllers;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import dao.EventDAO;

@WebServlet("/DeleteEventServlet")
public class DeleteEventServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Get event ID from request
        String eventIdParam = request.getParameter("eventId");

        if (eventIdParam != null) {
            try {
                int eventId = Integer.parseInt(eventIdParam);
                
                // Delete event
                boolean success = EventDAO.deleteEvent(eventId);
                
                // Redirect to dashboard with a message
                if (success) {
                    response.sendRedirect("organizer_dashboard.jsp?message=Event Deleted Successfully");
                } else {
                    response.sendRedirect("organizer_dashboard.jsp?error=Failed to delete event");
                }
            } catch (NumberFormatException e) {
                response.sendRedirect("organizer_dashboard.jsp?error=Invalid event ID");
            }
        } else {
            response.sendRedirect("organizer_dashboard.jsp?error=Missing event ID");
        }
    }
}

