CREATE DATABASE EventManagement;

USE EventManagement;

CREATE TABLE users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100),
    email VARCHAR(100) UNIQUE,
    password VARCHAR(255),
    role ENUM('user', 'organizer') NOT NULL
);

CREATE TABLE events (
    id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    event_date DATE NOT NULL,
    location VARCHAR(255) NOT NULL,
    description TEXT,
    event_type ENUM('Conference', 'Wedding', 'Workshop', 'Party'),
    created_by INT,
    FOREIGN KEY (created_by) REFERENCES users(id) ON DELETE CASCADE
);

CREATE TABLE rsvp (
    id INT AUTO_INCREMENT PRIMARY KEY,
    event_id INT,
    user_id INT,
    status ENUM('Going', 'Not Going'),
    FOREIGN KEY (event_id) REFERENCES events(id) ON DELETE CASCADE,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
);

CREATE TABLE bookings (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    event_id INT NOT NULL,
    booking_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
    FOREIGN KEY (event_id) REFERENCES events(id) ON DELETE CASCADE
);


INSERT INTO events (title, event_date, location, description, event_type, created_by) 
VALUES 
('Tech Innovators Conference 2025', '2025-06-15', 'New York Convention Center', 'A gathering of tech leaders discussing AI advancements.', 'Conference', 1),

('John & Emily Wedding', '2025-07-10', 'Lakeview Resort', 'A beautiful lakeside wedding celebration.', 'Wedding', 1),

('AI & Machine Learning Workshop', '2025-05-20', 'Tech Hub, San Francisco', 'A hands-on workshop on deep learning and AI models.', 'Workshop', 1),

('Startup Networking Party', '2025-08-05', 'Sky Lounge, London', 'An exclusive event for startup founders and investors.', 'Party', 1),

('Cybersecurity Awareness Seminar', '2025-09-12', 'CyberTech Hall, Berlin', 'A seminar on modern cybersecurity threats and solutions.', 'Conference', 1);
