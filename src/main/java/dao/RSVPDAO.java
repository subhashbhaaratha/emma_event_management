package dao;

import models.RSVP;
import utils.DBConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class RSVPDAO {

    // ✅ Method to add a new RSVP (if not already RSVPed)
    public static boolean addRSVP(int userId, int eventId, String status) {
        String checkSQL = "SELECT id FROM rsvp WHERE user_id = ? AND event_id = ?";
        String insertSQL = "INSERT INTO rsvp (user_id, event_id, status) VALUES (?, ?, ?)";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement checkStmt = conn.prepareStatement(checkSQL);
             PreparedStatement insertStmt = conn.prepareStatement(insertSQL)) {

            checkStmt.setInt(1, userId);
            checkStmt.setInt(2, eventId);
            try (ResultSet rs = checkStmt.executeQuery()) {
                if (rs.next()) {
                    return false; // User has already RSVPed
                }
            }

            insertStmt.setInt(1, userId);
            insertStmt.setInt(2, eventId);
            insertStmt.setString(3, status);
            insertStmt.executeUpdate();
            return true;

        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    // ✅ Method to count RSVPs for an event
    public static int getRSVPCount(int eventId) {
        String sql = "SELECT COUNT(*) FROM rsvp WHERE event_id = ?";
        int count = 0;

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, eventId);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    count = rs.getInt(1);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return count;
    }

    // ✅ Method to add or update an RSVP
    public static boolean addOrUpdateRSVP(int userId, int eventId, String status) {
        String checkSQL = "SELECT id FROM rsvp WHERE user_id = ? AND event_id = ?";
        String updateSQL = "UPDATE rsvp SET status = ? WHERE user_id = ? AND event_id = ?";
        String insertSQL = "INSERT INTO rsvp (user_id, event_id, status) VALUES (?, ?, ?)";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement checkStmt = conn.prepareStatement(checkSQL);
             PreparedStatement updateStmt = conn.prepareStatement(updateSQL);
             PreparedStatement insertStmt = conn.prepareStatement(insertSQL)) {

            checkStmt.setInt(1, userId);
            checkStmt.setInt(2, eventId);
            try (ResultSet rs = checkStmt.executeQuery()) {
                if (rs.next()) {
                    // If RSVP exists, update it
                    updateStmt.setString(1, status);
                    updateStmt.setInt(2, userId);
                    updateStmt.setInt(3, eventId);
                    updateStmt.executeUpdate();
                } else {
                    // If RSVP does not exist, insert a new record
                    insertStmt.setInt(1, userId);
                    insertStmt.setInt(2, eventId);
                    insertStmt.setString(3, status);
                    insertStmt.executeUpdate();
                }
            }
            return true;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    // ✅ Method to retrieve RSVP list for a specific event
    public static List<RSVP> getRSVPByEvent(int eventId) {
        List<RSVP> rsvpList = new ArrayList<>();
        String query = "SELECT r.id, r.user_id, r.event_id, r.status, u.name FROM rsvp r " +
                       "JOIN users u ON r.user_id = u.id WHERE r.event_id = ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {

            stmt.setInt(1, eventId);
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    RSVP rsvp = new RSVP();
                    rsvp.setId(rs.getInt("id"));
                    rsvp.setUserId(rs.getInt("user_id"));
                    rsvp.setEventId(rs.getInt("event_id"));
                    rsvp.setStatus(rs.getString("status"));
                    rsvp.setUserName(rs.getString("name")); // Assuming the `RSVP` model has a userName field

                    rsvpList.add(rsvp);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return rsvpList;
    }
}
