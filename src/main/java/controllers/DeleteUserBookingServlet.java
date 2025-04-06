package controllers;

import dao.BookingDAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/DeleteUserBookingServlet")
public class DeleteUserBookingServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int bookingId = Integer.parseInt(request.getParameter("bookingId"));

        boolean deleted = BookingDAO.deleteUserBooking(bookingId);  // Now returns a boolean
        if (deleted) {
            response.sendRedirect("user_bookings.jsp?message=Booking cancelled successfully");
        } else {
            response.sendRedirect("user_bookings.jsp?message=Failed to cancel booking");
        }
    }
}
