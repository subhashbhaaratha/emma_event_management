package controllers;

import dao.BookingDAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/DeleteBookingServlet")
public class DeleteBookingServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            int bookingId = Integer.parseInt(request.getParameter("bookingId"));
            String eventId = request.getParameter("eventId"); // Get event ID from request

            BookingDAO.deleteBooking(bookingId);

            // Redirect back to booking details page with eventId
            response.sendRedirect("booking_details.jsp?eventId=" + eventId);
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("booking_details.jsp?error=Unable to delete booking");
        }
    }
}

