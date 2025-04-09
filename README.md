# Emma Event Management System

## Project Overview

Emma Event Management is a web-based platform that facilitates the creation, management, and discovery of various events. The application offers functionalities for both end-users and event organizers, along with a built-in machine learning model to predict event types using the WEKA API.

---

## Part A: Minimum Functionalities

### 1. Display Events

* Events are listed and categorized by type: Conference, Wedding, Workshop, and Party.
* Each event displays its name, type, description, location, and scheduled date.

### 2. Add New Events

Users can add new events through a form that captures:
* Event Name
* Date (with proper format validation)
* Location (validated against allowed formats)
* Description
* Event Type

### 3. RSVP and Attendance Management

* Users can RSVP to confirm attendance for events.
* Organizers can view and manage the number of attendees.

### 4. Search and Filter

* Users can search for events by:
  * Event Type
  * Location
  * Date
* Filter functionality ensures easier event discovery.

### 5. Edit and Update Events

* Event organizers can edit existing events or delete them if needed.

### 6. Data Validation

* Proper input validations are implemented:
  * Date must follow a valid format
  * Mandatory fields must be filled
  * Location and description inputs are validated

---

## Part B: Machine Learning Integration

### 1. Overview

The application uses the WEKA API to predict the event type of new listings based on their attributes such as date, location, and description.

### 2. Dataset

* The dataset is stored in `events.arff`.
* Additional synthetic data has been generated to enhance training effectiveness.

### 3. Attributes Considered

* `event_name`
* `description`
* `location`
* `date`
* `event_type` (class label)

### 4. Model Training

* Algorithm Used: J48 Decision Tree
* Preprocessing: StringToWordVector for converting text to numerical features

### 5. Evaluation Results

* Correctly Classified Instances: 70%
* Incorrectly Classified Instances: 30%
* Kappa Statistic: 0.5775
* MAE: 0.1714
* RMSE: 0.3226

**Confusion Matrix:**

| Predicted → \ Actual ↓ | Conference | Wedding | Workshop | Party |
|------------------------|------------|---------|----------|-------|
| **Conference**          | 3          | 0       | 0        | 0     |
| **Wedding**             | 0          | 1       | 0        | 0     |
| **Workshop**            | 1          | 0       | 1        | 0     |
| **Party**               | 1          | 0       | 0        | 2     |

### 6. Prediction Use

After training, the model can predict the event type for any new listing. Classification result is displayed or stored as part of the new event record.

---

## Technologies Used

* Java (Servlets, JSP) for application logic
* MySQL for backend database
* Apache Tomcat 10.1 as web server
* WEKA for machine learning classification

---

## How to Set Up & Run

### 1. Clone the Repository

```bash
git clone https://github.com/subhashbhaaratha/EmmaEventManagement.git
```
### 2. Import the Project into IDE

* Open the project in Eclipse or IntelliJ.
* Ensure Java and Apache Tomcat 10.1 are properly configured.

### 3. Configure the Database

* Create a MySQL database named emmaeventmanagement.
* Import the schema and configure credentials in DBConnection.java.

### 4. Build and Run the App

* Right-click on the project folder (EmmaEventManagement) → Run As → Run on Server.
* Select Tomcat v10.1 Server at localhost.
* Application runs at: http://localhost:8080/EmmaEventManagement/

Project Structure
```
EmmaEventManagement/
├── src/
│   └── main/
│       ├── java/
│       │   ├── controller/
│       │   │   ├── BookEventServlet.java
│       │   │   ├── DeleteBookingServlet.java
│       │   │   ├── EventServlet.java
│       │   │   └── DeleteEventServlet.java
│       │   ├── dao/
│       │   │   ├── BookingDAO.java
│       │   │   ├── EventDAO.java
│       │   │   ├── RSVPDAO.java
│       │   │   └── UserDAO.java
│       │   ├── models/
│       │   │   ├── Booking.java
│       │   │   ├── Event.java
│       │   │   ├── RSVP.java
│       │   │   └── User.java
│       │   ├── utils/
│       │   │   └── DBConnection.java
│       │   └── weka/
│       │       └── EventClassifier.java
│       └── webapp/
│           ├── WEB-INF/
│           │   └── lib/ (contains mysql-connector, servlet-api, weka jars)
│           ├── booking_details.jsp
│           ├── create_event.jsp
│           ├── events.jsp
│           ├── index.jsp
│           ├── login.jsp
│           ├── logout.jsp
│           ├── organiser.jsp
│           ├── register.jsp
│           └── rsvp_list.jsp
├── events.arff
├── .gitignore
└── README.md
```
### Future Enhancements

* Email notifications for event RSVPs
* Admin dashboard for better event control
* Visual data analytics on user interactions

### Author

* Subhash Chandra Bhaaratha
* 15629814 * MSc Computer Science , Coventry University