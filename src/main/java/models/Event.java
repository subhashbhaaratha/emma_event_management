package models;

import java.sql.Date;

public class Event {
    private int id;
    private String title, location, description, eventType;
    private Date eventDate;
    private int createdBy;

    public Event(int id, String title, Date eventDate, String location, String description, String eventType, int createdBy) {
        this.id = id;
        this.title = title;
        this.eventDate = eventDate;
        this.location = location;
        this.description = description;
        this.eventType = eventType;
        this.createdBy = createdBy;
    }

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getLocation() {
		return location;
	}

	public void setLocation(String location) {
		this.location = location;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public String getEventType() {
		return eventType;
	}

	public void setEventType(String eventType) {
		this.eventType = eventType;
	}

	public Date getEventDate() {
		return eventDate;
	}

	public void setEventDate(Date eventDate) {
		this.eventDate = eventDate;
	}

	public int getCreatedBy() {
		return createdBy;
	}

	public void setCreatedBy(int createdBy) {
		this.createdBy = createdBy;
	}

    
}
