/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package nz.event.ticketbookingsystem.controller;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import java.io.IOException;
import java.util.Arrays;
import java.util.List;

import nz.event.ticketbookingsystem.model.Seat;

/**
 *
 * @author shanamusekiwa
 */
@WebServlet("/booking")
public class BookingServlet extends HttpServlet {

    private BookingController controller;

    @Override
    public void init() throws ServletException {
        controller = new BookingController();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String date = request.getParameter("date");
        if (date == null) date = "Thu, 28 Aug — 7:30 pm"; 

        List<Seat> seats = controller.getSeatsForDate(date);
        request.setAttribute("seats", seats);
        request.setAttribute("selectedDate", date);

        RequestDispatcher dispatcher = request.getRequestDispatcher("booking.jsp");
        dispatcher.forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String date = request.getParameter("date");
        String[] selectedCodes = request.getParameterValues("seats");
        if (selectedCodes == null) selectedCodes = new String[0];

        List<String> selected = Arrays.asList(selectedCodes);
        String total = controller.bookSeats(date, selected);

        request.setAttribute("date", date);
        request.setAttribute("totalPrice", total);
        request.setAttribute("selectedSeats", selected);

        RequestDispatcher dispatcher = request.getRequestDispatcher("confirmation.jsp");
        dispatcher.forward(request, response);
    }
}
