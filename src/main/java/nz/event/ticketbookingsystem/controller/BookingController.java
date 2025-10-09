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

    // Key = date string, Value = seats for that date
    private final Map<String, List<Seat>> seatMaps = new HashMap<>();

    public BookingController() {
        initializeSeats();
    }

    private void initializeSeats() {
        // two different shows with different seat availability
        seatMaps.put("Thu, 28 Aug — 7:30 pm", generateSeats(List.of("D9", "D10", "D11")));
        seatMaps.put("Sat, 30 Aug — 2:00 pm", generateSeats(List.of("C10", "C11", "C12", "C13")));
    }

    private List<Seat> generateSeats(List<String> reservedCodes) {
        List<Seat> list = new ArrayList<>();
        char[] rows = {'A', 'B', 'C', 'D', 'E'};
        for (char row : rows) {
            for (int i = 1; i <= 20; i++) {
                String code = row + String.valueOf(i);
                Seat seat = new Seat(code, SeatStatus.AVAILABLE);
                if (reservedCodes.contains(code)) {
                    seat.setStatus(SeatStatus.RESERVED);
                }
                list.add(seat);
            }
        }
        return list;
    }

    private Seat findSeatByCode(String date, String code) {
        return seatMaps.get(date).stream()
                .filter(s -> s.getCode().equals(code))
                .findFirst()
                .orElseThrow();
    }

    public String bookSeats(String date, List<String> selectedCodes) {
        List<Seat> selectedSeats = new ArrayList<>();
        for (String code : selectedCodes) {
            Seat seat = findSeatByCode(date, code);
            if (seat.getStatus() == SeatStatus.AVAILABLE) {
                seat.setStatus(SeatStatus.SELECTED);
                selectedSeats.add(seat);
            }
        }
        double totalPrice = selectedSeats.size() * PRICE_PER_SEAT;
        return NumberFormat.getCurrencyInstance(Locale.US).format(totalPrice);
    }

    public List<Seat> getSeatsForDate(String date) {
        return seatMaps.getOrDefault(date, List.of());
    }
}
