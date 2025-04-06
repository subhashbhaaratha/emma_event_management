package models;

public class RSVP {
    private int id, eventId, userId;
    private String status;
    private String userName; // Added field for user's name

    // ✅ Default (no-argument) constructor
    public RSVP() {
    }

    // ✅ Parameterized constructor
    public RSVP(int id, int eventId, int userId, String status, String userName) {
        this.id = id;
        this.eventId = eventId;
        this.userId = userId;
        this.status = status;
        this.userName = userName;
    }

    // ✅ Getter and setter methods
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getEventId() {
        return eventId;
    }

    public void setEventId(int eventId) {
        this.eventId = eventId;
    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    // ✅ New getter and setter for userName
    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }
}
