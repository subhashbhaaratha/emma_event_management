package models;

import java.sql.Timestamp;

public class Booking {
    private int id;
    private int userId;
    private int eventId;
    private String eventTitle;
    private String userName;
    private Timestamp bookingDate;
    private String eventDate;
    private String eventLocation;

    // Existing constructor
    public Booking(int id, int userId, int eventId, Timestamp bookingDate) {
        this.id = id;
        this.userId = userId;
        this.eventId = eventId;
        this.bookingDate = bookingDate;
    }

    // Constructor for organizer view
    public Booking(int id, String eventTitle, String userName, Timestamp bookingDate) {
        this.id = id;
        this.eventTitle = eventTitle;
        this.userName = userName;
        this.bookingDate = bookingDate;
    }

    // Constructor for user bookings (includes event details)
    public Booking(int id, String eventTitle, String eventDate, String eventLocation) {
        this.id = id;
        this.eventTitle = eventTitle;
        this.eventDate = eventDate;
        this.eventLocation = eventLocation;
    }

    public int getId() {
        return id;
    }

    public int getUserId() {
        return userId;
    }

    public int getEventId() {
        return eventId;
    }

    public String getEventTitle() {
        return eventTitle;
    }

    public String getUserName() {
        return userName;
    }

    public Timestamp getBookingDate() {
        return bookingDate;
    }

    public String getEventDate() {
        return eventDate;
    }

    public String getEventLocation() {
        return eventLocation;
    }
}
