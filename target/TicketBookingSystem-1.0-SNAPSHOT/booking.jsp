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
    .stage {
      text-align: center;
      font-size: 24px;
      font-weight: bold;
      color: #fff;
      background-color: #999;
      padding: 10px 0;
      margin: 20px auto 30px auto;
      border-radius: 4px;
      width: 80%;
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

        <div class="stage">STAGE</div>

        <div id="seatGrid" class="seat-grid"></div>

        <button id="bookBtn" class="book-btn" type="button">Book Tickets</button>
      </div>

      <div class="divider"></div>

      <div class="right">
        <h4>Your Information</h4>
        <label class="field">DATE
          <select id="dateSelect" class="select">
            <option value="28Aug">Thu, 28 Aug — 7:30 pm</option>
            <option value="30Aug">Sat, 30 Aug — 2:00 pm</option>
          </select>
        </label>

        <div class="summary">
          <div><strong>TICKET NUMBER</strong><span id="ticketNums">—</span></div>
          <div><strong>TICKETS</strong><span id="ticketCount">0</span></div>
          <div><strong>PRICE</strong><span id="price">0.00</span></div>
        </div>

        <div class="meta">
          <div><strong>Event:</strong><span>Mamma Mia</span></div>
          <div><strong>Price per ticket:</strong><span>$84.00</span></div>
        </div>
      </div>
    </div>
  </div>

  <script>
    const PRICE = 84.00;
    const rows = ['A','B','C','D','E'];
    const cols = 20;

    // Seat availability per date
    const seatAvailability = {
      "28Aug": ["C10","C11","C12","C13"],
      "30Aug": ["D17","D18","D19","B5","B6"]
    };

    const seatGrid = document.getElementById('seatGrid');
    const ticketNums = document.getElementById('ticketNums');
    const ticketCount = document.getElementById('ticketCount');
    const price = document.getElementById('price');
    const dateSelect = document.getElementById('dateSelect');

    function buildGrid(dateKey) {
      seatGrid.innerHTML = "";
      const availableCodes = seatAvailability[dateKey] || [];

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

          if (!availableCodes.includes(code)) {
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
      ticketNums.textContent = checked.length ? checked.sort((a,b)=>a.localeCompare(b,undefined,{numeric:true})).join(', ') : '—';
      ticketCount.textContent = checked.length;
      price.textContent = (checked.length * PRICE).toFixed(2);
    }

    document.addEventListener('change', e => {
      if (e.target.matches('.seat input[type="checkbox"]')) {
        e.target.parentElement.classList.toggle('is-selected', e.target.checked);
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
