<%@ page import="java.util.List, models.Event, dao.EventDAO" %>
<%@ page session="true" %>

<%
    String query = request.getParameter("query");
    String eventType = request.getParameter("eventType");
    
    if (query == null) query = "";
    if (eventType == null) eventType = "";

    List<Event> searchResults = EventDAO.searchEvents(query, eventType);
%>

<!DOCTYPE html>
<html>
<head>
    <title>Search Events</title>
</head>
<body>
    <h2>Search Results</h2>

    <ul>
        <% for (Event event : searchResults) { %>
            <li>
                <b><%= event.getTitle() %></b> - <%= event.getEventDate() %> - <%= event.getLocation() %>
                <p><%= event.getDescription() %></p>
            </li>
        <% } %>
    </ul>

    <p><a href="user_dashboard.jsp">Back to Dashboard</a></p>
</body>
</html>
