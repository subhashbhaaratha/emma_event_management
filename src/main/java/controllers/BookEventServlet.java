package controllers;

import dao.BookingDAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/BookEventServlet")
public class BookEventServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        
        if (session == null || session.getAttribute("userId") == null) {
            response.sendRedirect("login.jsp?error=Please log in first.");
            return;
        }

        int userId = (int) session.getAttribute("userId");
        int eventId = Integer.parseInt(request.getParameter("eventId"));

        // Check if event is already booked
        if (BookingDAO.isEventBooked(userId, eventId)) {
            response.sendRedirect("user_dashboard.jsp?error=You have already booked this event.");
            return;
        }

        // Book the event
        boolean success = BookingDAO.bookEvent(userId, eventId);
        
        if (success) {
            response.sendRedirect("user_dashboard.jsp?message=Event booked successfully.");
        } else {
            response.sendRedirect("user_dashboard.jsp?error=Booking failed. Try again.");
        }
    }
}

