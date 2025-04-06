package dao;

import models.Event;
import utils.DBConnection;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class EventDAO {

	public static boolean createEvent(Event event) throws SQLException {
        String query = "INSERT INTO events (title, event_date, location, description, event_type, created_by) VALUES (?, ?, ?, ?, ?, ?)";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {
            
            stmt.setString(1, event.getTitle());
            stmt.setDate(2, event.getEventDate());
            stmt.setString(3, event.getLocation());
            stmt.setString(4, event.getDescription());
            stmt.setString(5, event.getEventType());
            stmt.setInt(6, event.getCreatedBy());

            int rowsInserted = stmt.executeUpdate();
            return rowsInserted > 0;
        }
    }

    public static List<Event> getEventsByOrganizer(int organizerId) {
        List<Event> events = new ArrayList<>();
        try (Connection conn = DBConnection.getConnection()) {
            String sql = "SELECT * FROM events WHERE created_by = ?";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setInt(1, organizerId);
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                events.add(new Event(
                    rs.getInt("id"),
                    rs.getString("title"),
                    rs.getDate("event_date"),
                    rs.getString("location"),
                    rs.getString("description"),
                    rs.getString("event_type"),
                    rs.getInt("created_by")
                ));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return events;
    }
    
 // Method to get all events from the database
    public static List<Event> getAllEvents() throws SQLException {
        List<Event> eventList = new ArrayList<>();
        String query = "SELECT * FROM events";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query);
             ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                Event event = new Event(
                    rs.getInt("id"),
                    rs.getString("title"),
                    rs.getDate("event_date"),
                    rs.getString("location"),
                    rs.getString("description"),
                    rs.getString("event_type"),
                    rs.getInt("created_by")
                );
                eventList.add(event);
            }
        }
        return eventList;
    }
    
    public static List<Event> searchEvents(String keyword, String eventType) {
        List<Event> events = new ArrayList<>();
        String sql = "SELECT * FROM events WHERE (title LIKE ? OR location LIKE ?) AND event_type LIKE ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            String searchPattern = "%" + keyword + "%";
            String eventTypePattern = "%" + eventType + "%"; // Match any event type if empty

            stmt.setString(1, searchPattern);
            stmt.setString(2, searchPattern);
            stmt.setString(3, eventTypePattern);

            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                Event event = new Event(
                    rs.getInt("id"),
                    rs.getString("title"),
                    rs.getDate("event_date"),
                    rs.getString("location"),
                    rs.getString("description"),
                    rs.getString("event_type"),
                    rs.getInt("created_by")
                );
                events.add(event);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return events;
    }

    
    public static boolean deleteEvent(int eventId) {
        String sql = "DELETE FROM events WHERE id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, eventId);
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }


}
