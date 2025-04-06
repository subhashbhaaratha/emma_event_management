package controllers;

import dao.RSVPDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import models.RSVP;

import java.io.IOException;
import java.util.List;
import java.util.logging.Logger;

@WebServlet("/RSVPServlet")
public class RSVPServlet extends HttpServlet {
    private static final Logger logger = Logger.getLogger(RSVPServlet.class.getName());

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);

        // Validate user session
        if (session == null || session.getAttribute("userId") == null) {
            response.sendRedirect("login.jsp?error=Session expired. Please log in again.");
            return;
        }

        int userId = (int) session.getAttribute("userId");
        String role = (String) session.getAttribute("role");

        String eventIdStr = request.getParameter("eventId");
        String status = request.getParameter("status");

        // Validate parameters
        if (eventIdStr == null || status == null || eventIdStr.isEmpty() || status.isEmpty()) {
            response.sendRedirect("user_dashboard.jsp?error=Invalid RSVP details.");
            return;
        }

        try {
            int eventId = Integer.parseInt(eventIdStr);
            boolean success = RSVPDAO.addOrUpdateRSVP(userId, eventId, status);

            if (success) {
                response.sendRedirect("user_dashboard.jsp?success=RSVP updated successfully.");
            } else {
                response.sendRedirect("user_dashboard.jsp?error=Could not update RSVP. Try again.");
            }
        } catch (NumberFormatException e) {
            logger.warning("Invalid event ID format: " + eventIdStr);
            response.sendRedirect("user_dashboard.jsp?error=Invalid event ID.");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);

        // Ensure the user is an organizer
        if (session == null || !"organizer".equals(session.getAttribute("role"))) {
            response.sendRedirect("login.jsp?error=Unauthorized access.");
            return;
        }

        String eventIdStr = request.getParameter("eventId");

        if (eventIdStr == null || eventIdStr.isEmpty()) {
            response.sendRedirect("organizer_dashboard.jsp?error=Invalid event ID.");
            return;
        }

        try {
            int eventId = Integer.parseInt(eventIdStr);
            List<RSVP> rsvpList = RSVPDAO.getRSVPByEvent(eventId);

            request.setAttribute("rsvpList", rsvpList);
            request.getRequestDispatcher("rsvp_list.jsp").forward(request, response);
        } catch (NumberFormatException e) {
            logger.warning("Invalid event ID format in GET request: " + eventIdStr);
            response.sendRedirect("organizer_dashboard.jsp?error=Invalid event ID.");
        }
    }
}
