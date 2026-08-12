<!DOCTYPE html>
<html lang="it">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">

<title>Halo Desk</title>

<style>
:root {
    --blue:#0057B0;
    --green:#19C875;
    --red:#F04444;
    --focus:#3578E5;

    --bg:#F5F7FA;
    --card:#FFFFFF;
    --text:#101828;
    --muted:#7C8490;
    --border:#E6EAF0;
}

body.dark {
    --bg:#071A33;
    --card:#0D2747;
    --text:#FFFFFF;
    --muted:#91A0B4;
    --border:#173858;
}

* {
    box-sizing:border-box;
    -webkit-tap-highlight-color:transparent;
}

body {
    margin:0;
    min-height:100vh;
    background:var(--bg);
    color:var(--text);
    font-family:-apple-system,BlinkMacSystemFont,"SF Pro Display","Inter",Arial,sans-serif;
    transition:.3s;
}

.app {
    width:100%;
    max-width:520px;
    margin:auto;
    min-height:100vh;
    padding-bottom:100px;
}

/* HEADER */

.header {
    display:flex;
    justify-content:space-between;
    align-items:center;
    padding:24px 20px 10px;
}

.logo {
    font-size:28px;
    font-weight:850;
    letter-spacing:-1px;
}

.add-button {
    width:42px;
    height:42px;
    border:0;
    border-radius:50%;
    background:var(--blue);
    color:white;
    font-size:27px;
}

/* PAGINE */

.page {
    display:none;
    padding:10px 20px;
}

.page.active {
    display:block;
}

.page-title {
    font-size:30px;
    font-weight:850;
    letter-spacing:-1px;
    margin-top:10px;
}

.page-subtitle {
    color:var(--muted);
    margin-top:5px;
    margin-bottom:22px;
}

/* =========================
   HOME
========================= */

.home-center {
    display:flex;
    flex-direction:column;
    align-items:center;
}

/* CERCHIO CRONOMETRO */

.timer-ring {
    width:285px;
    height:285px;
    border-radius:50%;
    display:flex;
    justify-content:center;
    align-items:center;
    position:relative;

    --state-color:var(--green);

    border:3px solid var(--state-color);

    box-shadow:
        0 0 15px var(--state-color),
        0 0 40px var(--state-color),
        0 0 85px color-mix(in srgb, var(--state-color) 55%, transparent);

    transition:
        border-color .4s ease,
        box-shadow .4s ease;
}

.timer-ring::before {
    content:"";
    position:absolute;
    inset:12px;
    border-radius:50%;
    border:1px solid color-mix(
        in srgb,
        var(--state-color) 45%,
        transparent
    );
    opacity:.7;
}

.timer-inner {
    width:235px;
    height:235px;
    border-radius:50%;
    background:var(--card);
    display:flex;
    flex-direction:column;
    align-items:center;
    justify-content:center;
    position:relative;
    z-index:2;
}

.timer-label {
    color:var(--muted);
    font-size:12px;
    font-weight:700;
    letter-spacing:1.2px;
    margin-bottom:10px;
}

.timer {
    font-size:46px;
    font-weight:800;
    letter-spacing:-3px;
    font-variant-numeric:tabular-nums;
}

.current-status {
    display:flex;
    align-items:center;
    gap:7px;
    margin-top:12px;
    padding:7px 13px;
    border-radius:30px;
    background:var(--bg);
    font-size:13px;
    font-weight:700;
}

.status-dot {
    width:8px;
    height:8px;
    border-radius:50%;
    background:var(--green);
}

/* STATI */

.state-buttons {
    width:100%;
    display:grid;
    grid-template-columns:repeat(3,1fr);
    gap:9px;
    margin-top:25px;
}

.state-button {
    border:0;
    border-radius:40px;
    padding:15px 5px;
    color:white;
    font-size:14px;
    font-weight:750;
    transition:.2s;
}

.state-button:active {
    transform:scale(.95);
}

.free {
    background:var(--green);
}

.busy {
    background:var(--red);
}

.focus {
    background:var(--focus);
}

/* CARD */

.card {
    background:var(--card);
    border:1px solid var(--border);
    border-radius:25px;
    padding:20px;
    margin-top:16px;
}

.card-title {
    font-size:18px;
    font-weight:800;
}

.card-text {
    color:var(--muted);
    font-size:14px;
    margin-top:6px;
}

/* =========================
   STATISTICHE
========================= */

.tabs {
    display:grid;
    grid-template-columns:repeat(3,1fr);
    background:var(--card);
    border:1px solid var(--border);
    border-radius:20px;
    padding:4px;
}

.tab {
    border:0;
    background:transparent;
    color:var(--muted);
    padding:12px 5px;
    border-radius:16px;
    font-weight:700;
}

.tab.active {
    background:var(--blue);
    color:white;
}

.total-time {
    font-size:38px;
    font-weight:850;
    margin-top:8px;
}

.stat-row {
    margin-top:22px;
}

.stat-header {
    display:flex;
    justify-content:space-between;
    font-size:14px;
    font-weight:700;
    margin-bottom:8px;
}

.bar {
    height:10px;
    border-radius:20px;
    background:var(--bg);
    overflow:hidden;
}

.fill {
    height:100%;
    border-radius:20px;
    transition:.5s;
}

.green-fill {
    background:var(--green);
}

.red-fill {
    background:var(--red);
}

.blue-fill {
    background:var(--focus);
}

.day-list {
    margin-top:20px;
}

.day-row {
    display:flex;
    justify-content:space-between;
    padding:13px 0;
    border-bottom:1px solid var(--border);
}

.day-row:last-child {
    border-bottom:0;
}

/* =========================
   STUDIO
========================= */

.study-time {
    text-align:center;
    font-size:62px;
    font-weight:800;
    margin:25px 0;
    font-variant-numeric:tabular-nums;
}

.primary-button {
    width:100%;
    border:0;
    background:var(--blue);
    color:white;
    border-radius:20px;
    padding:17px;
    font-size:17px;
    font-weight:800;
}

.secondary-buttons {
    display:grid;
    grid-template-columns:repeat(3,1fr);
    gap:8px;
    margin-top:10px;
}

.secondary-button {
    border:0;
    border-radius:17px;
    padding:14px 4px;
    background:var(--bg);
    color:var(--text);
    font-weight:700;
}

/* =========================
   LISTE / IMPOSTAZIONI
========================= */

.list {
    margin-top:5px;
}

.list-item {
    display:flex;
    align-items:center;
    justify-content:space-between;
    padding:17px 0;
    border-bottom:1px solid var(--border);
}

.list-item:last-child {
    border-bottom:0;
}

.item-left {
    display:flex;
    align-items:center;
    gap:13px;
}

.item-icon {
    width:44px;
    height:44px;
    border-radius:15px;
    display:flex;
    align-items:center;
    justify-content:center;
    background:var(--bg);
    font-size:20px;
}

.arrow {
    color:var(--muted);
    font-size:22px;
}

/* SWITCH */

.switch {
    width:48px;
    height:28px;
    border:0;
    border-radius:30px;
    background:#C9D0D9;
    padding:3px;
}

.switch-circle {
    width:22px;
    height:22px;
    border-radius:50%;
    background:white;
    transition:.2s;
}

.switch.on {
    background:var(--blue);
}

.switch.on .switch-circle {
    transform:translateX(20px);
}

/* =========================
   BOTTOM NAV
========================= */

.bottom-nav {
    position:fixed;
    z-index:30;
    bottom:0;
    left:50%;
    transform:translateX(-50%);
    width:min(520px,100%);
    display:grid;
    grid-template-columns:repeat(5,1fr);
    padding:9px 8px calc(9px + env(safe-area-inset-bottom));
    background:color-mix(in srgb,var(--card) 92%,transparent);
    backdrop-filter:blur(20px);
    border-top:1px solid var(--border);
}

.nav-button {
    border:0;
    background:transparent;
    color:var(--muted);
    font-size:10px;
    font-weight:700;
}

.nav-button.active {
    color:var(--blue);
}

.nav-icon {
    display:block;
    font-size:20px;
    margin-bottom:3px;
}

/* =========================
   MODALE
========================= */

.modal {
    display:none;
    position:fixed;
    inset:0;
    z-index:100;
    background:rgba(0,0,0,.55);
    align-items:flex-end;
}

.modal.show {
    display:flex;
}

.modal-box {
    width:100%;
    max-width:520px;
    margin:auto;
    background:var(--card);
    border-radius:30px 30px 0 0;
    padding:25px;
}

.modal-title {
    font-size:23px;
    font-weight:850;
    margin-bottom:18px;
}

.input {
    width:100%;
    padding:15px;
    border-radius:16px;
    border:1px solid var(--border);
    background:var(--bg);
    color:var(--text);
    font-size:16px;
    margin-bottom:10px;
}

.modal-button {
    width:100%;
    border:0;
    border-radius:18px;
    padding:16px;
    background:var(--blue);
    color:white;
    font-weight:800;
    margin-top:5px;
}

.modal-close {
    background:var(--bg);
    color:var(--text);
}
</style>
</head>


<body>

<div class="app">

<header class="header">

    <div class="logo">
        Halo Desk
    </div>

    <button class="add-button"
            onclick="openDevice()">
        +
    </button>

</header>


<!-- ================= HOME ================= -->

<section id="home" class="page active">

<div class="home-center">

    <div id="timerRing" class="timer-ring">

        <div class="timer-inner">

            <div class="timer-label">
                STATO ATTUALE
            </div>

            <div id="mainTimer"
                 class="timer">
                00:00:00
            </div>

            <div class="current-status">

                <span id="statusDot"
                      class="status-dot">
                </span>

                <span id="statusText">
                    Libero
                </span>

            </div>

        </div>

    </div>


    <div class="state-buttons">

        <button class="state-button free"
                onclick="changeState('Libero')">
            Libero
        </button>

        <button class="state-button busy"
                onclick="changeState('Occupato')">
            Occupato
        </button>

        <button class="state-button focus"
                onclick="changeState('Focus')">
            Focus
        </button>

    </div>

</div>


<div class="card">

    <div class="card-title">
        Sessione corrente
    </div>

    <div id="sessionText"
         class="card-text">
        Libero
    </div>

</div>

</section>


<!-- ================= STATISTICHE ================= -->

<section id="stats" class="page">

    <div class="page-title">
        Statistiche
    </div>

    <div class="page-subtitle">
        Il tuo tempo, analizzato.
    </div>


    <div class="tabs">

        <button class="tab active"
                onclick="changeStats('day',this)">
            Giorno
        </button>

        <button class="tab"
                onclick="changeStats('week',this)">
            Settimana
        </button>

        <button class="tab"
                onclick="changeStats('month',this)">
            Mese
        </button>

    </div>


    <div class="card">

        <div class="card-title">
            Tempo totale
        </div>

        <div id="totalTime"
             class="total-time">
            0 min
        </div>


        <div class="stat-row">

            <div class="stat-header">
                <span>🟢 Libero</span>
                <span id="freeTime">0 min</span>
            </div>

            <div class="bar">
                <div id="freeBar"
                     class="fill green-fill">
                </div>
            </div>

        </div>


        <div class="stat-row">

            <div class="stat-header">
                <span>🔴 Occupato</span>
                <span id="busyTime">0 min</span>
            </div>

            <div class="bar">
                <div id="busyBar"
                     class="fill red-fill">
                </div>
            </div>

        </div>


        <div class="stat-row">

            <div class="stat-header">
                <span>🔵 Focus</span>
                <span id="focusTime">0 min</span>
            </div>

            <div class="bar">
                <div id="focusBar"
                     class="fill blue-fill">
                </div>
            </div>

        </div>

    </div>


    <div id="periodDetails"
         class="card">

    </div>

</section>


<!-- ================= STUDIO ================= -->

<section id="study" class="page">

    <div class="page-title">
        Studio
    </div>

    <div class="page-subtitle">
        Una modalità separata per studiare.
    </div>


    <div class="card">

        <div class="card-title">
            Pomodoro
        </div>

        <div class="card-text">
            25 minuti di studio · 5 minuti di pausa
        </div>

        <button class="primary-button"
                onclick="startPomodoro()">
            Avvia Pomodoro
        </button>

    </div>


    <div class="card">

        <div id="studyTimer"
             class="study-time">
            25:00
        </div>

        <div class="secondary-buttons">

            <button class="secondary-button"
                    onclick="startStudy()">
                ▶ Avvia
            </button>

            <button class="secondary-button"
                    onclick="pauseStudy()">
                ⏸ Pausa
            </button>

            <button class="secondary-button"
                    onclick="resetStudy()">
                ↺ Reset
            </button>

        </div>

    </div>

</section>


<!-- ================= TEAM ================= -->

<section id="team" class="page">

    <div class="page-title">
        Team
    </div>

    <div class="page-subtitle">
        Gestisci più Halo Desk.
    </div>


    <div class="card list">

        <div class="list-item">

            <div class="item-left">

                <div class="item-icon">
                    👥
                </div>

                <div>
                    <b>Partecipanti</b>
                    <div class="card-text">
                        Aggiungi persone al team
                    </div>
                </div>

            </div>

            <span class="arrow"
                  onclick="alert('Funzione Team in preparazione')">
                +
            </span>

        </div>


        <div class="list-item">

            <div class="item-left">

                <div class="item-icon">
                    ⏱
                </div>

                <div>
                    <b>Tempo di parola</b>
                    <div class="card-text">
                        Turni automatici
                    </div>
                </div>

            </div>

            <span class="arrow">›</span>

        </div>

    </div>

</section>


<!-- ================= ALTRO ================= -->

<section id="more" class="page">

    <div class="page-title">
        Altro
    </div>

    <div class="page-subtitle">
        Tutti gli strumenti di Halo Desk.
    </div>


    <div class="card list">


        <!-- AUTOMAZIONI -->

        <div class="list-item"
             onclick="openFeature('automations')">

            <div class="item-left">

                <div class="item-icon">
                    ⚡
                </div>

                <div>
                    <b>Automazioni</b>

                    <div class="card-text">
                        Routine e stati automatici
                    </div>
                </div>

            </div>

            <span class="arrow">
                ›
            </span>

        </div>


        <!-- CALENDARIO -->

        <div class="list-item"
             onclick="openFeature('calendar')">

            <div class="item-left">

                <div class="item-icon">
                    📅
                </div>

                <div>
                    <b>Calendario</b>

                    <div class="card-text">
                        Riunioni e cambi automatici
                    </div>
                </div>

            </div>

            <span class="arrow">
                ›
            </span>

        </div>


        <!-- NOTIFICHE -->

        <div class="list-item"
             onclick="openFeature('notifications')">

            <div class="item-left">

                <div class="item-icon">
                    🔔
                </div>

                <div>
                    <b>Notifiche</b>

                    <div class="card-text">
                        Timer e cambi di stato
                    </div>
                </div>

            </div>

            <span class="arrow">
                ›
            </span>

        </div>


        <!-- PERSONALIZZAZIONE -->

        <div class="list-item"
             onclick="openFeature('custom')">

            <div class="item-left">

                <div class="item-icon">
                    ✨
                </div>

                <div>
                    <b>Personalizzazione</b>

                    <div class="card-text">
                        LED, luminosità ed effetti
                    </div>
                </div>

            </div>

            <span class="arrow">
                ›
            </span>

        </div>


        <!-- DARK MODE -->

        <div class="list-item">

            <div class="item-left">

                <div class="item-icon">
                    🌙
                </div>

                <div>
                    <b>Modalità Dark</b>

                    <div class="card-text">
                        Blu notte
                    </div>
                </div>

            </div>


            <button id="themeSwitch"
                    class="switch"
                    onclick="toggleTheme()">

                <div class="switch-circle"></div>

            </button>

        </div>

    </div>

</section>


<!-- NAV -->

<nav class="bottom-nav">

    <button class="nav-button active"
            onclick="showPage('home',this)">

        <span class="nav-icon">⌂</span>
        Home

    </button>


    <button class="nav-button"
            onclick="showPage('stats',this)">

        <span class="nav-icon">▥</span>
        Statistiche

    </button>


    <button class="nav-button"
            onclick="showPage('study',this)">

        <span class="nav-icon">◷</span>
        Studio

    </button>


    <button class="nav-button"
            onclick="showPage('team',this)">

        <span class="nav-icon">♧</span>
        Team

    </button>


    <button class="nav-button"
            onclick="showPage('more',this)">

        <span class="nav-icon">•••</span>
        Altro

    </button>

</nav>

</div>


<!-- MODALE DISPOSITIVO -->

<div id="deviceModal"
     class="modal">

    <div class="modal-box">

        <div class="modal-title">
            Aggiungi Halo Desk
        </div>

        <input id="deviceName"
               class="input"
               placeholder="Nome dispositivo">

        <input id="deviceCode"
               class="input"
               placeholder="Codice dispositivo">

        <button class="modal-button"
                onclick="saveDevice()">
            Aggiungi dispositivo
        </button>

        <button class="modal-button modal-close"
                onclick="closeDevice()">
            Annulla
        </button>

    </div>

</div>


<script>

/* =========================
   DATI
========================= */

let state =
    localStorage.getItem("haloState") || "Libero";

let sessions =
    JSON.parse(
        localStorage.getItem("haloSessions") || "[]"
    );

let currentStart =
    Number(
        localStorage.getItem("haloCurrentStart")
    ) || Date.now();

let statsPeriod = "day";


/* =========================
   CRONOMETRO
========================= */

function formatTime(seconds) {

    let h =
        Math.floor(seconds / 3600);

    let m =
        Math.floor((seconds % 3600) / 60);

    let s =
        seconds % 60;

    return (
        String(h).padStart(2,"0") +
        ":" +
        String(m).padStart(2,"0") +
        ":" +
        String(s).padStart(2,"0")
    );
}


function updateTimer() {

    let seconds =
        Math.floor(
            (Date.now() - currentStart) / 1000
        );

    document.getElementById("mainTimer")
        .textContent =
        formatTime(seconds);

}


setInterval(updateTimer,1000);

updateTimer();


/* =========================
   COLORE
========================= */

function setColor(color) {

    let ring =
        document.getElementById("timerRing");

    let dot =
        document.getElementById("statusDot");

    let hex;

    if (color === "green") {
        hex = "#19C875";
    }

    if (color === "red") {
        hex = "#F04444";
    }

    if (color === "blue") {
        hex = "#3578E5";
    }

    ring.style.setProperty(
        "--state-color",
        hex
    );

    dot.style.background = hex;
}


/* =========================
   STATO
========================= */

function changeState(newState) {

    if (newState === state) return;

    let now = Date.now();

    sessions.push({

        state:state,

        start:currentStart,

        end:now,

        duration:
            Math.floor(
                (now-currentStart)/1000
            )

    });

    state = newState;

    currentStart = now;

    localStorage.setItem(
        "haloState",
        state
    );

    localStorage.setItem(
        "haloCurrentStart",
        currentStart
    );

    localStorage.setItem(
        "haloSessions",
        JSON.stringify(sessions)
    );

    updateStateUI();

    updateStatistics();
}


function updateStateUI() {

    document.getElementById("statusText")
        .textContent =
        state;

    document.getElementById("sessionText")
        .textContent =
        "Stato attivo: " + state;


    if (state === "Libero") {

        setColor("green");

    }

    if (state === "Occupato") {

        setColor("red");

    }

    if (state === "Focus") {

        setColor("blue");

    }

}


updateStateUI();


/* =========================
   NAVIGAZIONE
========================= */

function showPage(id,button) {

    document.querySelectorAll(".page")
        .forEach(page =>
            page.classList.remove("active")
        );

    document.getElementById(id)
        .classList.add("active");

    document.querySelectorAll(".nav-button")
        .forEach(btn =>
            btn.classList.remove("active")
        );

    button.classList.add("active");

    if (id === "stats") {

        updateStatistics();

    }

}


/* =========================
   STATISTICHE
========================= */

function getSessionSeconds() {

    let result = {

        Libero:0,
        Occupato:0,
        Focus:0

    };

    let now = Date.now();

    sessions.forEach(session => {

        result[session.state] +=
            session.duration;

    });


    result[state] +=
        Math.floor(
            (now-currentStart)/1000
        );


    return result;
}


function minutes(seconds) {

    return Math.floor(seconds/60);
}


function updateStatistics() {

    let data =
        getSessionSeconds();

    let total =
        data.Libero +
        data.Occupato +
        data.Focus;


    document.getElementById("totalTime")
        .textContent =
        minutes(total) + " min";


    document.getElementById("freeTime")
        .textContent =
        minutes(data.Libero) + " min";


    document.getElementById("busyTime")
        .textContent =
        minutes(data.Occupato) + " min";


    document.getElementById("focusTime")
        .textContent =
        minutes(data.Focus) + " min";


    if (total > 0) {

        document.getElementById("freeBar")
            .style.width =
            (data.Libero/total*100)+"%";


        document.getElementById("busyBar")
            .style.width =
            (data.Occupato/total*100)+"%";


        document.getElementById("focusBar")
            .style.width =
            (data.Focus/total*100)+"%";

    }


    updatePeriodDetails();

}


function changeStats(period,button) {

    statsPeriod = period;

    document.querySelectorAll(".tab")
        .forEach(tab =>
            tab.classList.remove("active")
        );

    button.classList.add("active");

    updatePeriodDetails();

}


function updatePeriodDetails() {

    let title;

    if (statsPeriod === "day") {

        title =
            "Oggi";

    }

    if (statsPeriod === "week") {

        title =
            "Questa settimana";

    }

    if (statsPeriod === "month") {

        title =
            "Questo mese";

    }


    document.getElementById("periodDetails")
        .innerHTML =

        "<div class='card-title'>" +
        title +
        "</div>" +

        "<div class='day-list'>" +

        "<div class='day-row'>" +
        "<span>🟢 Libero</span>" +
        "<b>" + minutes(getSessionSeconds().Libero) + " min</b>" +
        "</div>" +

        "<div class='day-row'>" +
        "<span>🔴 Occupato</span>" +
        "<b>" + minutes(getSessionSeconds().Occupato) + " min</b>" +
        "</div>" +

        "<div class='day-row'>" +
        "<span>🔵 Focus</span>" +
        "<b>" + minutes(getSessionSeconds().Focus) + " min</b>" +
        "</div>" +

        "</div>";

}


updateStatistics();


/* =========================
   STUDIO
========================= */

let studySeconds = 1500;

let studyInterval = null;


function updateStudy() {

    let m =
        Math.floor(studySeconds/60);

    let s =
        studySeconds%60;

    document.getElementById("studyTimer")
        .textContent =
        String(m).padStart(2,"0") +
        ":" +
        String(s).padStart(2,"0");

}


function startStudy() {

    if (studyInterval) return;

    studyInterval =
        setInterval(function() {

            if (studySeconds > 0) {

                studySeconds--;

                updateStudy();

            } else {

                pauseStudy();

                alert(
                    "Sessione di studio terminata!"
                );

            }

        },1000);

}


function pauseStudy() {

    clearInterval(studyInterval);

    studyInterval = null;

}


function resetStudy() {

    pauseStudy();

    studySeconds = 1500;

    updateStudy();

}


function startPomodoro() {

    resetStudy();

    startStudy();

}


updateStudy();


/* =========================
   DARK MODE
========================= */

function toggleTheme() {

    document.body.classList.toggle("dark");

    let enabled =
        document.body.classList.contains("dark");

    localStorage.setItem(
        "haloDark",
        enabled
    );

    document.getElementById("themeSwitch")
        .classList.toggle(
            "on",
            enabled
        );

}


if (
    localStorage.getItem("haloDark")
    === "true"
) {

    document.body.classList.add("dark");

    document.getElementById("themeSwitch")
        .classList.add("on");

}


/* =========================
   DISPOSITIVO
========================= */

function openDevice() {

    document.getElementById("deviceModal")
        .classList.add("show");

}


function closeDevice() {

    document.getElementById("deviceModal")
        .classList.remove("show");

}


function saveDevice() {

    let name =
        document.getElementById("deviceName")
        .value
        .trim();

    let code =
        document.getElementById("deviceCode")
        .value
        .trim();


    if (!name) {

        name = "Halo Desk";

    }


    localStorage.setItem(
        "haloDevice",
        JSON.stringify({
            name:name,
            code:code
        })
    );


    closeDevice();

    alert(
        name + " aggiunto!"
    );

}


/* =========================
   ALTRE FUNZIONI
========================= */

function openFeature(feature) {

    if (feature === "automations") {

        alert(
            "Automazioni: qui potremo creare routine automatiche."
        );

    }


    if (feature === "calendar") {

        alert(
            "Calendario: qui collegheremo il calendario."
        );

    }


    if (feature === "notifications") {

        alert(
            "Notifiche: qui configureremo le notifiche."
        );

    }


    if (feature === "custom") {

        alert(
            "Personalizzazione: qui aggiungeremo luminosità, colori ed effetti LED."
        );

    }

}

</script>

</body>
</html>
