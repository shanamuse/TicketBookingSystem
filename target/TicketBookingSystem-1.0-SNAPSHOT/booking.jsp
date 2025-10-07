<%-- 
    Document   : booking
    Created on : 8 Oct 2025, 12:18:45 am
    Author     : shanamusekiwa
--%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="nz.event.ticketbookingsystem.model.Seat" %>
<%@ page import="java.util.*" %>

<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>Book Tickets — Mamma Mia</title>
  <link rel="stylesheet" href="base.css">
</head>
<body>
  <h1 style="color:#5D3FD3;">Book Your Seats</h1>

  <form method="post" action="booking">
    <div class="seat-grid">
      <%
        List<Seat> seats = (List<Seat>) request.getAttribute("seats");
        if (seats != null) {
          for (Seat seat : seats) {
            String status = seat.getStatus().toString();
      %>
            <label class="seat <%= status.toLowerCase() %>">
              <input type="checkbox" name="seats" value="<%= seat.getCode() %>"
                <%= status.equals("RESERVED") ? "disabled" : "" %> />
              <span><%= seat.getCode() %></span>
            </label>
      <%
          }
        }
      %>
    </div>

    <br><br>
    <button type="submit" class="book-btn">Book Now</button>
  </form>

  <br>
  <a href="index.html" style="color:#5D3FD3;text-decoration:none;">← Back to Home</a>
</body>
</html>
