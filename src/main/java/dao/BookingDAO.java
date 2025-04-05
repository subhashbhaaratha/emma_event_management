package dao;

import models.Booking;
import utils.DBConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class BookingDAO {

    // Insert a new booking
    public static boolean bookEvent(int userId, int eventId) {
        String query = "INSERT INTO bookings (user_id, event_id) VALUES (?, ?)";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {
             
            stmt.setInt(1, userId);
            stmt.setInt(2, eventId);
            
            int rowsAffected = stmt.executeUpdate();
            return rowsAffected > 0;
            
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
    
    

    // Check if a user has already booked an event
    public static boolean isEventBooked(int userId, int eventId) {
        String query = "SELECT COUNT(*) FROM bookings WHERE user_id = ? AND event_id = ?";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {
             
            stmt.setInt(1, userId);
            stmt.setInt(2, eventId);
            
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                return rs.getInt(1) > 0;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
    
    public static List<Booking> getBookingsByOrganizer(int organizerId) {
        List<Booking> bookings = new ArrayList<>();
        String query = "SELECT b.id, e.title AS event_title, u.name AS user_name, b.booking_date " +
                       "FROM bookings b " +
                       "JOIN events e ON b.event_id = e.id " +
                       "JOIN users u ON b.user_id = u.id " +
                       "WHERE e.created_by = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setInt(1, organizerId);
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                bookings.add(new Booking(rs.getInt("id"), rs.getString("event_title"),
                    rs.getString("user_name"), rs.getTimestamp("booking_date")));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return bookings;
    }
    
    public static List<Booking> getBookingsByEvent(int eventId) {
        List<Booking> bookings = new ArrayList<>();
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(
                 "SELECT b.id, e.title AS event_title, u.name AS user_name, b.booking_date " +
                 "FROM bookings b " +
                 "JOIN events e ON b.event_id = e.id " +
                 "JOIN users u ON b.user_id = u.id " +
                 "WHERE b.event_id = ?")) {
            ps.setInt(1, eventId);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                bookings.add(new Booking(
                    rs.getInt("id"),
                    rs.getString("event_title"),
                    rs.getString("user_name"),
                    rs.getTimestamp("booking_date")
                ));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return bookings;
    }
    public static void deleteBooking(int bookingId) {
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement("DELETE FROM bookings WHERE id = ?")) {
            ps.setInt(1, bookingId);
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
    
    public static List<Booking> getBookingsByUserId(int userId) {
        List<Booking> bookings = new ArrayList<>();
        String sql = "SELECT b.id, e.title, e.event_date, e.location FROM bookings b JOIN events e ON b.event_id = e.id WHERE b.user_id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, userId);
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                bookings.add(new Booking(
                    rs.getInt("id"),
                    rs.getString("title"),
                    rs.getString("event_date"),  // Ensure event_date is stored as String or adjust data type
                    rs.getString("location")
                ));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return bookings;
    }
    
    public static boolean deleteUserBooking(int bookingId) {
        String query = "DELETE FROM bookings WHERE id = ?";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(query)) {
            ps.setInt(1, bookingId);
            int rowsAffected = ps.executeUpdate();
            return rowsAffected > 0;  // Returns true if at least one row is deleted
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }



}
