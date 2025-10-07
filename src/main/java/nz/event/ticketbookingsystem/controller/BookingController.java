/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package nz.event.ticketbookingsystem.controller;

import nz.event.ticketbookingsystem.model.Seat;
import nz.event.ticketbookingsystem.model.SeatStatus;
import java.text.NumberFormat;
import java.util.*;

/**
 *
 * @author shanamusekiwa
 */
public class BookingController {
    private static final double PRICE_PER_SEAT = 84.00;
    private final List<Seat> seats = new ArrayList<>();

    public BookingController() {
        initializeSeats();
    }

    private void initializeSeats() {
        char[] rows = {'A', 'B', 'C', 'D', 'E'};
        for (char row : rows) {
            for (int i = 1; i <= 20; i++) {
                seats.add(new Seat(row + String.valueOf(i), SeatStatus.AVAILABLE));
            }
        }
        // Example reserved seats
        for (String code : List.of("D9", "D10", "D11")) {
            findSeatByCode(code).setStatus(SeatStatus.RESERVED);
        }
    }

    private Seat findSeatByCode(String code) {
        return seats.stream()
                .filter(s -> s.getCode().equals(code))
                .findFirst()
                .orElseThrow();
    }

    public String bookSeats(List<String> selectedCodes) {
        List<Seat> selectedSeats = new ArrayList<>();
        for (String code : selectedCodes) {
            Seat seat = findSeatByCode(code);
            if (seat.getStatus() == SeatStatus.AVAILABLE) {
                seat.setStatus(SeatStatus.SELECTED);
                selectedSeats.add(seat);
            }
        }

        double totalPrice = selectedSeats.size() * PRICE_PER_SEAT;
        return NumberFormat.getCurrencyInstance(Locale.US).format(totalPrice);
    }

    public List<Seat> getAllSeats() {
        return seats;
    }
}