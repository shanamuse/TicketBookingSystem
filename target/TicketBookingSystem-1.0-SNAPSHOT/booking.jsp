<%-- 
    Document   : booking
    Created on : 8 Oct 2025, 12:18:45 am
    Author     : shanamusekiwa
--%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="nz.event.ticketbookingsystem.model.Seat" %>
<%@ page import="java.util.*" %>
<link rel="stylesheet" href="base.css">

<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>Buy Tickets — Mamma Mia</title>
  <link rel="stylesheet" href="base.css">
  <style>
    .seat-grid { display: flex; flex-direction: column; gap: 8px; }
    .row { display: flex; align-items: center; }
    .row-seats { display: flex; gap: 4px; flex: 1; }
    .row-label-right { margin-left: 8px; font-weight: bold; }
    .seat input { display: none; }

    /* default seat */
    .seat span { 
      display: inline-block; 
      width: 24px; height: 24px; 
      line-height: 24px; 
      text-align: center; 
      border-radius: 50%; 
      background: #eee; 
      font-size: 12px;
      cursor: not-allowed;
      transition: background 0.2s;
    }

    /* available (purple) */
    .seat.available span {
      background: #8A2BE2;
      color: white;
      cursor: pointer;
    }

    /* selected (green + tick) */
    .seat input:checked + span {
      background: #32CD32;
      color: white;
      font-weight: bold;
      content: "✓";
    }
    .seat input:checked + span::before {
      content: "✓";
      font-size: 14px;
    }

    /* disabled */
    .seat input:disabled + span {
      background: #ddd;
      color: #aaa;
    }
  </style>
</head>
<body>
  <div class="backdrop"></div>

  <div class="modal-card">
    <div class="modal-header">
      <span>Buy Tickets</span>
      <button class="close" aria-label="close">×</button>
    </div>

    <div class="modal-body">
      <div class="left">
        <h4>Seat</h4>
        <div class="screen-label">Screen</div>
        <div id="seatGrid" class="seat-grid"></div>
        <button id="bookBtn" class="book-btn" type="button">Book Tickets</button>
      </div>

      <div class="divider"></div>

      <div class="right">
        <h4>Your Information</h4>
        <label class="field">DATE
          <select id="dateSelect" class="select">
            <option value="thu">Thu, 28 Aug — 7:30 pm</option>
            <option value="sat">Sat, 30 Aug — 2:00 pm</option>
          </select>
        </label>

        <div class="summary">
          <div><strong>TICKET NUMBER</strong> <span id="ticketNums">—</span></div>
          <div><strong>TICKETS</strong> <span id="ticketCount">0</span></div>
          <div><strong>PRICE</strong> <span id="price">0.00</span></div>
        </div>

        <div class="meta">
          <div><strong>Event:</strong> <span>Mamma Mia</span></div>
          <div><strong>Price per ticket:</strong> <span>$84.00</span></div>
        </div>
      </div>
    </div>
  </div>

  <script>
    const PRICE = 84.00;
    const rows = ['A','B','C','D','E'];
    const cols = 20;

    const availability = {
      "thu": ["C10","C11","C12","C13"],
      "sat": ["D17","D18","D19","B5","B6"]
    };

    const seatGrid = document.getElementById('seatGrid');
    const ticketNums = document.getElementById('ticketNums');
    const ticketCount = document.getElementById('ticketCount');
    const price = document.getElementById('price');
    const dateSelect = document.getElementById('dateSelect');

    function buildGrid(dateKey) {
      seatGrid.innerHTML = '';
      const availableCodes = availability[dateKey] || [];

      rows.forEach(r => {
        const row = document.createElement('div');
        row.className = 'row';

        const seatsWrap = document.createElement('div');
        seatsWrap.className = 'row-seats';

        for (let i=1;i<=cols;i++) {
          const code = r + i;
          const label = document.createElement('label');
          label.className = 'seat';
          const input = document.createElement('input');
          input.type = 'checkbox';
          input.value = code;

          if (availableCodes.includes(code)) {
            label.classList.add("available");
          } else {
            input.disabled = true;
          }

          const span = document.createElement('span');
          span.textContent = i;

          label.appendChild(input);
          label.appendChild(span);
          seatsWrap.appendChild(label);
        }

        const rowLetterRight = document.createElement('div');
        rowLetterRight.className = 'row-label-right';
        rowLetterRight.textContent = r;

        row.appendChild(seatsWrap);
        row.appendChild(rowLetterRight);
        seatGrid.appendChild(row);
      });
    }

    function updateSummary() {
      const checked = [...document.querySelectorAll('.seat input:checked')].map(i=>i.value);
      ticketNums.textContent = checked.length ? checked.join(', ') : '—';
      ticketCount.textContent = checked.length;
      price.textContent = (checked.length * PRICE).toFixed(2);
    }

    document.addEventListener('change', e => {
      if (e.target.matches('.seat input[type="checkbox"]')) {
        updateSummary();
      }
    });

    dateSelect.addEventListener('change', () => {
      buildGrid(dateSelect.value);
      updateSummary();
    });

    document.getElementById('bookBtn').addEventListener('click', () => updateSummary());

    buildGrid(dateSelect.value);
    updateSummary();
  </script>
</body>
</html>


