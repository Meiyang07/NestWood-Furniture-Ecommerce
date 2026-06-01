<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Dashboard — NestWood</title>
    <link rel="preconnect" href="https://cdnjs.cloudflare.com">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css"
          integrity="sha512-DTOQO9RWCH3ppGqcWaEA1BIZOC6xxalwEsw9c2QQeAIftl+Vegovlnee1c9QX4TctnWMn13TZye+giMm8e2LwA=="
          crossorigin="anonymous" referrerpolicy="no-referrer" media="print" onload="this.media='all'">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css">
</head>
<body class="admin-layout">

<jsp:include page="/WEB-INF/includes/admin-header.jsp"/>

<main class="admin-main">

    <%-- ── Page Header ──────────────────────────────────────── --%>
    <div class="page-header" style="margin-bottom:2rem">
        <div>
            <p class="section-label">NestWood Admin</p>
            <h1 class="page-title">Dashboard Overview</h1>
        </div>
        <div class="admin-header-actions">
            <a href="${pageContext.request.contextPath}/admin/products?action=add" class="btn btn-gold">+ Add Product</a>
        </div>
    </div>

    <%-- ── Stats Grid ────────────────────────────────────────── --%>
    <div class="stats-grid">
        <div class="stat-card">
            <div class="stat-icon-wrap stat-icon--blue"><i class="fas fa-users" aria-hidden="true"></i></div>
            <div class="stat-info">
                <h3 class="stat-number">${stats.totalUsers}</h3>
                <p class="stat-label">Total Users</p>
            </div>
            <div class="stat-trend">↑</div>
        </div>
        <div class="stat-card">
            <div class="stat-icon-wrap stat-icon--walnut"><i class="fas fa-couch" aria-hidden="true"></i></div>
            <div class="stat-info">
                <h3 class="stat-number">${stats.totalProducts}</h3>
                <p class="stat-label">Total Products</p>
            </div>
            <div class="stat-trend">↑</div>
        </div>
        <div class="stat-card">
            <div class="stat-icon-wrap stat-icon--brown"><i class="fas fa-box" aria-hidden="true"></i></div>
            <div class="stat-info">
                <h3 class="stat-number">${stats.totalOrders}</h3>
                <p class="stat-label">Total Orders</p>
            </div>
            <div class="stat-trend">↑</div>
        </div>
        <div class="stat-card stat-card--warning">
            <div class="stat-icon-wrap stat-icon--amber"><i class="fas fa-hourglass-half" aria-hidden="true"></i></div>
            <div class="stat-info">
                <h3 class="stat-number">${stats.pendingOrders}</h3>
                <p class="stat-label">Pending Orders</p>
            </div>
            <div class="stat-trend">↑</div>
        </div>
        <div class="stat-card stat-card--gold">
            <div class="stat-icon-wrap stat-icon--gold"><i class="fas fa-rupee-sign" aria-hidden="true"></i></div>
            <div class="stat-info">
                <h3 class="stat-number" style="font-size:1.3rem">
                    Rs. <fmt:formatNumber value="${stats.totalRevenue}" pattern="#,##0"/>
                </h3>
                <p class="stat-label">Total Revenue</p>
            </div>
            <div class="stat-trend">↑</div>
        </div>
        <div class="stat-card stat-card--success">
            <div class="stat-icon-wrap stat-icon--green"><i class="fas fa-check-circle" aria-hidden="true"></i></div>
            <div class="stat-info">
                <h3 class="stat-number">${stats.activeProducts}</h3>
                <p class="stat-label">Active Products</p>
            </div>
            <div class="stat-trend">↑</div>
        </div>
    </div>

    <%-- ── Analytics Carousel ─────────────────────────────────── --%>
    <div class="nw-analytics" id="nwAnalytics">

        <%-- Top bar: title + controls --%>
        <div class="nw-analytics__bar">
            <div class="nw-analytics__bar-left">
                <span class="nw-analytics__icon"><i class="fas fa-chart-line"></i></span>
                <div>
                    <h2 class="nw-analytics__heading">Analytics Overview
                        <span class="nw-analytics__badge" id="nwSlideBadge">1 / 4</span>
                    </h2>
                    <p class="nw-analytics__sub" id="nwSlideLabel">Products by Category</p>
                </div>
            </div>
            <div class="nw-analytics__controls">
                <div class="nw-analytics__dots" id="nwDots"></div>
                <button class="nw-analytics__arrow" id="nwPrev" aria-label="Previous slide">&#8592;</button>
                <button class="nw-analytics__arrow" id="nwNext" aria-label="Next slide">&#8594;</button>
            </div>
        </div>

        <%-- Slide track --%>
        <div class="nw-analytics__track-outer">
            <div class="nw-analytics__track" id="nwTrack">

                <%-- Slide 0: Products by Category (Bar) --%>
                <div class="nw-analytics__slide">
                    <div class="nw-analytics__slide-inner">
                        <div class="nw-analytics__canvas-col">
                            <canvas id="catChart" class="nw-chart-canvas"></canvas>
                        </div>
                        <div class="nw-analytics__legend-col" id="catLegend">
                            <p class="nw-legend-title">Category Breakdown</p>
                            <p class="nw-legend-hint">Total furniture products distributed across all active categories.</p>
                        </div>
                    </div>
                </div>

                <%-- Slide 1: Orders by Status (Donut) --%>
                <div class="nw-analytics__slide">
                    <div class="nw-analytics__slide-inner">
                        <div class="nw-analytics__canvas-col nw-analytics__canvas-col--donut">
                            <canvas id="statusChart" class="nw-chart-canvas nw-chart-canvas--donut"></canvas>
                        </div>
                        <div class="nw-analytics__legend-col" id="statusLegend">
                            <p class="nw-legend-title">Order Status</p>
                            <p class="nw-legend-hint">Live breakdown of all orders by their current fulfilment status.</p>
                        </div>
                    </div>
                </div>

                <%-- Slide 2: Monthly Revenue (Area) --%>
                <div class="nw-analytics__slide">
                    <div class="nw-analytics__slide-inner">
                        <div class="nw-analytics__canvas-col">
                            <canvas id="salesChart" class="nw-chart-canvas"></canvas>
                        </div>
                        <div class="nw-analytics__legend-col" id="salesLegend">
                            <p class="nw-legend-title">Revenue Trend</p>
                            <p class="nw-legend-hint">Delivered-order revenue for the last 6 months.</p>
                            <div id="salesInsight" class="nw-legend-insight"></div>
                        </div>
                    </div>
                </div>

                <%-- Slide 3: Low Stock (H-Bar) --%>
                <div class="nw-analytics__slide">
                    <div class="nw-analytics__slide-inner">
                        <div class="nw-analytics__canvas-col">
                            <canvas id="stockChart" class="nw-chart-canvas"></canvas>
                        </div>
                        <div class="nw-analytics__legend-col" id="stockLegend">
                            <p class="nw-legend-title">Stock Alert</p>
                            <p class="nw-legend-hint">Products with 5 or fewer units remaining. Restock soon.</p>
                            <div id="stockInsight" class="nw-legend-insight"></div>
                        </div>
                    </div>
                </div>

            </div><%-- /track --%>
        </div><%-- /track-outer --%>
    </div><%-- /nw-analytics --%>

    <%-- Data bridge: servlet → JS (hidden, rendered server-side) --%>
    <script id="nwChartData" type="application/json">
        {
            "cat":    { "labels": [<c:forEach var="e" items="${productsByCategory}" varStatus="s">"${e.key}"<c:if test="${!s.last}">,</c:if></c:forEach>],
                    "values": [<c:forEach var="e" items="${productsByCategory}" varStatus="s">${e.value}<c:if test="${!s.last}">,</c:if></c:forEach>] },
        "status": { "labels": [<c:forEach var="e" items="${ordersByStatus}"     varStatus="s">"${e.key}"<c:if test="${!s.last}">,</c:if></c:forEach>],
                    "values": [<c:forEach var="e" items="${ordersByStatus}"     varStatus="s">${e.value}<c:if test="${!s.last}">,</c:if></c:forEach>] },
        "sales":  { "labels": [<c:forEach var="e" items="${monthlySales}"       varStatus="s">"${e.key}"<c:if test="${!s.last}">,</c:if></c:forEach>],
                    "values": [<c:forEach var="e" items="${monthlySales}"       varStatus="s">${e.value}<c:if test="${!s.last}">,</c:if></c:forEach>] },
        "stock":  { "labels": [<c:forEach var="e" items="${lowStockProducts}"   varStatus="s">"${e.key}"<c:if test="${!s.last}">,</c:if></c:forEach>],
                    "values": [<c:forEach var="e" items="${lowStockProducts}"   varStatus="s">${e.value}<c:if test="${!s.last}">,</c:if></c:forEach>] }
    }
    </script>

    <%-- ── Quick Links ────────────────────────────────────────── --%>
    <div class="admin-quick-links" style="margin-top:1.5rem;display:flex;gap:1rem;flex-wrap:wrap;">
        <a href="${pageContext.request.contextPath}/admin/products?action=list" class="btn btn-gold">
            <i class="fas fa-couch" aria-hidden="true"></i> Manage Products
        </a>
        <a href="${pageContext.request.contextPath}/order?action=adminOrders" class="btn btn-gold">
            <i class="fas fa-box" aria-hidden="true"></i> All Orders
        </a>
        <a href="${pageContext.request.contextPath}/admin/products?action=add" class="btn btn-gold">
            <i class="fas fa-plus" aria-hidden="true"></i> Add Product
        </a>
    </div>

    <%-- ── Recent Orders Table ──────────────────────────────── --%>
    <div class="card mt-4">
        <div class="card-header">
            <h2>Recent Orders</h2>
            <a href="${pageContext.request.contextPath}/order?action=adminOrders"
               class="btn btn-sm btn-primary">View All →</a>
        </div>
        <div class="table-responsive">
            <table class="data-table">
                <thead>
                <tr>
                    <th>ID</th><th>Customer</th><th>Product</th>
                    <th>Amount</th><th>Status</th><th>Date</th>
                </tr>
                </thead>
                <tbody>
                <c:forEach var="o" items="${recentOrders}">
                    <tr>
                        <td class="order-id-cell">${o.id}</td>
                        <td>${o.userName}</td>
                        <td>${o.productName}</td>
                        <td class="price-cell">Rs. <fmt:formatNumber value="${o.totalPrice}" pattern="#,##0.00"/></td>
                        <td><span class="badge badge-${o.status}">${o.status}</span></td>
                        <td class="text-muted" style="font-size:0.82rem">${o.createdAt}</td>
                    </tr>
                </c:forEach>
                <c:if test="${empty recentOrders}">
                    <tr>
                        <td colspan="6" class="text-center" style="padding:2.5rem;color:var(--text-muted)">
                            No orders yet.
                        </td>
                    </tr>
                </c:if>
                </tbody>
            </table>
        </div>
    </div>

</main>

<script src="${pageContext.request.contextPath}/assets/js/script.js"></script>
<script>
    /* ═══════════════════════════════════════════════════════════════
       NestWood Admin — Premium Analytics Carousel  (Phase 1)
       Vanilla JS + Canvas only. No external libs.
    ═══════════════════════════════════════════════════════════════ */
    (function () {
        'use strict';

        /* ── 1. Parse server data ── */
        var raw = {};
        try { raw = JSON.parse(document.getElementById('nwChartData').textContent); } catch(e) {}
        var D = {
            cat:    raw.cat    || { labels:[], values:[] },
            status: raw.status || { labels:[], values:[] },
            sales:  raw.sales  || { labels:[], values:[] },
            stock:  raw.stock  || { labels:[], values:[] }
        };

        /* ── 2. Theme tokens ── */
        var GOLD    = '#c8a96e';
        var GOLD2   = '#e0bc80';
        var WALNUT  = '#7a5c3a';
        var BORDER  = '#000000';  // Changed to black for grid lines
        var TEXT    = '#000000';  // Changed to black
        var MUTED   = '#000000';  // Changed to black
        var BG      = '#fdf9f5';
        var PIE     = ['#c8a96e','#4caf50','#e53935','#2196f3','#ff9800','#9c27b0','#00bcd4','#795548'];
        var STATUS_COL = { pending:'#ff9800', confirmed:'#2196f3', shipped:'#9c27b0',
            delivered:'#4caf50', cancelled:'#e53935' };

        /* ── 2.1 Animation Configuration ── */
        var ANIMATION_CONFIG = {
            barChart: {
                duration: 1000,        // milliseconds
                easing: 'elastic',     // 'elastic' | 'cubic' | 'exponential'
                overshoot: 1.2,        // elastic overshoot factor
                fps: 60
            },
            donutChart: {
                duration: 1200,
                easing: 'cubic',
                staggerDelay: 50,      // ms between segment animations
                fps: 60
            },
            lineChart: {
                duration: 1500,
                easing: 'cubic',
                fps: 60
            },
            hbarChart: {
                duration: 1000,
                easing: 'cubic',
                fps: 60
            },
            pulse: {
                duration: 1500,
                minScale: 1.0,
                maxScale: 1.15,
                easing: 'sine'
            }
        };

        /* ── 3. Tooltip singleton ── */
        var TIP = document.createElement('div');
        TIP.className = 'nw-tooltip';
        document.body.appendChild(TIP);

        function showTip(e, html) {
            TIP.innerHTML = html;
            TIP.classList.add('nw-tooltip--visible');
            moveTip(e);
        }
        function moveTip(e) {
            var x = e.clientX + 14, y = e.clientY - 36;
            if (x + 160 > window.innerWidth) x = e.clientX - 170;
            TIP.style.left = x + 'px';
            TIP.style.top  = y + 'px';
        }
        function hideTip() { TIP.classList.remove('nw-tooltip--visible'); }

        /* ── 4. Slide metadata ── */
        var SLIDES = [
            { label:'Products by Category', draw:drawBar,    id:'catChart'    },
            { label:'Orders by Status',     draw:drawDonut,  id:'statusChart' },
            { label:'Revenue Trend',        draw:drawStock,  id:'salesChart'  },
            { label:'Low Stock Alert',      draw:drawHBar,   id:'stockChart'  }
        ];
        var TOTAL = SLIDES.length, cur = 0, timer = null;
        var painted = [false, false, false, false];

        /* hit-test data per slide (for hover tooltips) */
        var hitData = [[], [], [], []];

        /* ── 5. DOM refs ── */
        var track      = document.getElementById('nwTrack');
        var dotsWrap   = document.getElementById('nwDots');
        var slideLabel = document.getElementById('nwSlideLabel');
        var slideBadge = document.getElementById('nwSlideBadge');
        var wrap       = document.getElementById('nwAnalytics');

        /* ── 6. Build pill dots ── */
        var dots = [];
        for (var d = 0; d < TOTAL; d++) {
            (function(i) {
                var btn = document.createElement('button');
                btn.className = 'nw-analytics__dot';
                btn.setAttribute('aria-label', 'Slide ' + (i+1));
                btn.addEventListener('click', function () { goTo(i); startTimer(); });
                dotsWrap.appendChild(btn);
                dots.push(btn);
            })(d);
        }
        function setActiveDot(i) {
            dots.forEach(function(d, idx) {
                d.classList.toggle('nw-analytics__dot--on', idx === i);
            });
        }

        /* ── 7. Navigation ── */
        function goTo(i) {
            cur = ((i % TOTAL) + TOTAL) % TOTAL;
            track.style.transform = 'translateX(-' + (cur * 100) + '%)';
            setActiveDot(cur);
            slideLabel.textContent = SLIDES[cur].label;
            if (slideBadge) slideBadge.textContent = (cur+1) + ' / ' + TOTAL;
            hideTip();
            if (!painted[cur]) {
                setTimeout(function () {
                    sizeCanvas(cur);
                    SLIDES[cur].draw();
                    painted[cur] = true;
                }, 360);
            }
        }
        function startTimer() {
            clearInterval(timer);
            timer = setInterval(function () { goTo(cur + 1); }, 5000);
        }

        document.getElementById('nwPrev').addEventListener('click', function () { goTo(cur - 1); startTimer(); });
        document.getElementById('nwNext').addEventListener('click', function () { goTo(cur + 1); startTimer(); });
        wrap.addEventListener('mouseenter', function () { clearInterval(timer); });
        wrap.addEventListener('mouseleave', function () { hideTip(); startTimer(); });

        /* ── 8. Canvas sizing ── */
        function sizeCanvas(i) {
            var c = document.getElementById(SLIDES[i].id);
            if (!c) return;
            var col = c.parentElement;
            var w = col.clientWidth  || 560;
            var h = col.clientHeight || 380;
            if (i === 1) {
                var sq = Math.min(w, h, 340);
                c.width = sq; c.height = sq;
            } else {
                c.width = w; c.height = h;
            }
        }

        /* ── 9. Canvas mouse → tooltip routing ── */
        function bindHover(slideIdx) {
            var c = document.getElementById(SLIDES[slideIdx].id);
            if (!c) return;
            c.addEventListener('mousemove', function(e) {
                var rect = c.getBoundingClientRect();
                var mx = e.clientX - rect.left, my = e.clientY - rect.top;
                var hit = null;
                hitData[slideIdx].forEach(function(h) {
                    if (slideIdx === 1) { /* donut: angle test */
                        var dx = mx - h.cx, dy = my - h.cy;
                        var dist = Math.sqrt(dx*dx + dy*dy);
                        if (dist > h.ir && dist < h.r) {
                            var ang = Math.atan2(dy, dx);
                            if (ang < 0) ang += 2*Math.PI;
                            var a0 = h.a0 < 0 ? h.a0 + 2*Math.PI : h.a0;
                            var a1 = h.a1 < 0 ? h.a1 + 2*Math.PI : h.a1;
                            if (a0 > a1) { if (ang >= a0 || ang <= a1) hit = h; }
                            else         { if (ang >= a0 && ang <= a1) hit = h; }
                        }
                    } else if (slideIdx === 2) { /* stock: x-band */
                        if (mx >= h.x - h.band && mx < h.x + h.band) hit = h;
                    } else { /* bar / hbar: rect */
                        if (mx >= h.x && mx < h.x+h.w && my >= h.y && my < h.y+h.h) hit = h;
                    }
                });
                if (hit) { showTip(e, hit.tip); c.style.cursor = 'crosshair'; }
                else      { hideTip(); c.style.cursor = 'default'; }
            });
            c.addEventListener('mouseleave', hideTip);
        }

        /* ── helpers ── */
        function rRect(ctx, x, y, w, h, r) {
            if (h <= 0) h = 1;
            r = Math.min(Math.abs(r), Math.abs(h)/2, Math.abs(w)/2);
            ctx.beginPath();
            ctx.moveTo(x+r,y); ctx.lineTo(x+w-r,y); ctx.quadraticCurveTo(x+w,y,x+w,y+r);
            ctx.lineTo(x+w,y+h-r); ctx.quadraticCurveTo(x+w,y+h,x+w-r,y+h);
            ctx.lineTo(x+r,y+h); ctx.quadraticCurveTo(x,y+h,x,y+h-r);
            ctx.lineTo(x,y+r); ctx.quadraticCurveTo(x,y,x+r,y);
            ctx.closePath();
        }
        function niceNum(v) {
            if (v >= 1000000) return (v/1000000).toFixed(1)+'M';
            if (v >= 1000)    return (v/1000).toFixed(1)+'k';
            return String(v);
        }
        function emptyState(col, msg) {
            var el = col.querySelector('.nw-empty-state');
            if (el) return;
            var div = document.createElement('div');
            div.className = 'nw-empty-state';
            div.innerHTML = '<div class="nw-empty-state__icon"><i class="fas fa-chart-bar"></i></div>'
                + '<div class="nw-empty-state__text">' + msg + '</div>';
            col.appendChild(div);
        }
        function clearEmpty(col) {
            var el = col.querySelector('.nw-empty-state');
            if (el) el.parentNode.removeChild(el);
        }

        /* ════════════════════════════════════════════════════
           CHART 1 — Animated Bar: products by category
        ════════════════════════════════════════════════════ */
        function drawBar() {
            var c = document.getElementById('catChart'); if (!c) return;
            var ctx = c.getContext('2d');
            var W = c.width, H = c.height;
            var P = { t:36, r:20, b:76, l:50 };
            var cW = W-P.l-P.r, cH = H-P.t-P.b;
            var lbs = D.cat.labels, vs = D.cat.values;
            var col = c.parentElement;
            clearEmpty(col);
            if (!lbs.length) { emptyState(col, 'No category data yet'); return; }

            var n   = lbs.length;
            var max = Math.max.apply(null, vs.concat([1]));
            var gap = cW / n;
            var bW  = Math.max(16, Math.min(gap * 0.6, 68));
            var topIdx = vs.indexOf(Math.max.apply(null, vs));

            hitData[0] = [];

            /* animate bars */
            var progress = 0;
            function frame() {
                progress = Math.min(progress + 0.06, 1);
                var ease = 1 - Math.pow(1 - progress, 3);
                ctx.clearRect(0, 0, W, H);

                /* subtle grid */
                for (var g = 1; g <= 4; g++) {
                    var gy = P.t + cH - (g/4)*cH;
                    ctx.strokeStyle = BORDER; ctx.lineWidth = 1;
                    ctx.setLineDash([4,4]);
                    ctx.beginPath(); ctx.moveTo(P.l, gy); ctx.lineTo(P.l+cW, gy); ctx.stroke();
                    ctx.setLineDash([]);
                    ctx.fillStyle = MUTED; ctx.font = '10px system-ui,sans-serif'; ctx.textAlign = 'right';
                    ctx.fillText(niceNum(Math.round(max*g/4)), P.l-8, gy+4);
                }
                /* baseline */
                ctx.strokeStyle = BORDER; ctx.lineWidth = 1.5;
                ctx.beginPath(); ctx.moveTo(P.l, P.t+cH); ctx.lineTo(P.l+cW, P.t+cH); ctx.stroke();

                lbs.forEach(function(lbl, i) {
                    var fullH = Math.max(4, (vs[i]/max)*cH);
                    var bH    = fullH * ease;
                    var x     = P.l + i*gap + (gap-bW)/2;
                    var y     = P.t + cH - bH;
                    var isTop = (i === topIdx);

                    /* bar with different color for each bar from PIE palette */
                    var barColor = PIE[i % PIE.length];
                    ctx.fillStyle = barColor;
                    rRect(ctx, x, y, bW, bH, 7); ctx.fill();

                    /* glow on top bar */
                    if (isTop) {
                        ctx.shadowColor = barColor.replace(')', ', 0.5)').replace('rgb', 'rgba');
                        ctx.shadowBlur  = 12;
                        rRect(ctx, x, y, bW, bH, 7); ctx.fill();
                        ctx.shadowBlur  = 0;
                    }

                    /* value label */
                    if (progress === 1) {
                        ctx.fillStyle = TEXT;
                        ctx.font = 'bold 11px system-ui,sans-serif'; ctx.textAlign = 'center';
                        ctx.fillText(vs[i], x+bW/2, y-8);
                    }

                    /* x-axis label straight (horizontal) */
                    ctx.fillStyle = TEXT; ctx.font = '10.5px system-ui,sans-serif'; ctx.textAlign = 'center';
                    ctx.fillText(lbl, x+bW/2, P.t+cH+20);

                    /* hit zone (full height for hover) */
                    hitData[0][i] = {
                        x:x, y:P.t, w:bW, h:cH,
                        tip: '<span class="nw-tooltip__label">' + lbl + '</span>' + vs[i] + ' products'
                            + (isTop ? ' &nbsp;<i class="fas fa-star"></i> Top' : '')
                    };
                });

                if (progress < 1) requestAnimationFrame(frame);
                else bindHover(0);
            }
            requestAnimationFrame(frame);

            /* legend */
            var leg = document.getElementById('catLegend');
            if (!leg) return;
            var topLabel = lbs[topIdx] || '—';
            var rows = lbs.map(function(l,i){
                var pct = Math.round((vs[i]/Math.max.apply(null,vs.concat([1])))*100);
                return '<div class="nw-leg-row">'
                    + '<span class="nw-leg-dot" style="background:'+PIE[i%PIE.length]+'"></span>'
                    + '<span class="nw-leg-name">'+l+'</span>'
                    + '<span class="nw-leg-val">'+vs[i]+'</span>'
                    + '<div class="nw-leg-bar-track" style="width:100%">'
                    + '<div class="nw-leg-bar-fill" style="width:'+pct+'%;background:'+PIE[i%PIE.length]+'"></div>'
                    + '</div></div>';
            }).join('');
            leg.innerHTML = '<p class="nw-legend-title">Category Breakdown</p>'
                + '<p class="nw-legend-hint">Products per active category.</p>'
                + '<div class="nw-insight-pill nw-insight-pill--info"><i class="fas fa-star"></i> Top: ' + topLabel + '</div>'
                + rows;
        }

        /* ════════════════════════════════════════════════════
           CHART 2 — Animated Donut: orders by status
        ════════════════════════════════════════════════════ */
        function drawDonut() {
            var c = document.getElementById('statusChart'); if (!c) return;
            var ctx = c.getContext('2d');
            var W = c.width, H = c.height;
            var cx = W/2, cy = H/2;
            var r  = Math.min(W,H) * 0.41;
            var ir = r * 0.70;  // Increased from 0.56 to 0.70 to make donut thinner
            var lbs = D.status.labels, vs = D.status.values;
            var total = vs.reduce(function(a,b){return a+b;},0) || 1;
            var col = c.parentElement;
            clearEmpty(col);
            if (!lbs.length) { emptyState(col, 'No order data yet'); return; }

            hitData[1] = [];
            var slices = [];
            var angle = -Math.PI/2;
            lbs.forEach(function(l,i) {
                var a0 = angle;
                var sw = (vs[i]/total)*2*Math.PI;
                var a1 = a0 + sw;
                slices.push({ a0:a0, a1:a1 });
                hitData[1].push({ cx:cx, cy:cy, r:r, ir:ir, a0:a0, a1:a1,
                    tip:'<span class="nw-tooltip__label" style="text-transform:capitalize">'+l+'</span>'
                        + vs[i] + ' orders &nbsp;(' + Math.round((vs[i]/total)*100) + '%)' });
                angle = a1;
            });

            var progress = 0;
            function frame() {
                progress = Math.min(progress + 0.05, 1);
                var ease  = 1 - Math.pow(1-progress, 3);
                ctx.clearRect(0, 0, W, H);

                slices.forEach(function(sl, i) {
                    var sw = (sl.a1 - sl.a0) * ease;
                    var color = STATUS_COL[lbs[i].toLowerCase()] || PIE[i%PIE.length];
                    ctx.beginPath(); ctx.moveTo(cx, cy);
                    ctx.arc(cx, cy, r, sl.a0, sl.a0+sw);
                    ctx.closePath();
                    ctx.fillStyle = color; ctx.fill();
                    ctx.strokeStyle = '#fff'; ctx.lineWidth = 2.5; ctx.stroke();
                });

                /* donut hole */
                ctx.beginPath(); ctx.arc(cx, cy, ir, 0, 2*Math.PI);
                var hgr = ctx.createRadialGradient(cx,cy,ir*0.3,cx,cy,ir);
                hgr.addColorStop(0,'#fffdf9'); hgr.addColorStop(1,'#fdf5ea');
                ctx.fillStyle = hgr; ctx.fill();

                /* centre labels */
                ctx.fillStyle = WALNUT; ctx.font = 'bold 24px system-ui,sans-serif'; ctx.textAlign = 'center';
                ctx.fillText(total, cx, cy+8);
                ctx.fillStyle = MUTED; ctx.font = '11px system-ui,sans-serif';
                ctx.fillText('total orders', cx, cy+25);

                if (progress < 1) requestAnimationFrame(frame);
                else bindHover(1);
            }
            requestAnimationFrame(frame);

            /* legend */
            var leg = document.getElementById('statusLegend');
            if (!leg) return;
            var maxStatus = lbs[vs.indexOf(Math.max.apply(null,vs))];
            var rows = lbs.map(function(l,i){
                var color = STATUS_COL[l.toLowerCase()] || PIE[i%PIE.length];
                var pct   = Math.round((vs[i]/total)*100);
                return '<div class="nw-leg-row">'
                    + '<span class="nw-leg-dot" style="background:'+color+'"></span>'
                    + '<span class="nw-leg-name" style="text-transform:capitalize">'+l+'</span>'
                    + '<span class="nw-leg-val">'+vs[i]+'<span class="nw-leg-pct">'+pct+'%</span></span>'
                    + '</div>';
            }).join('');
            leg.innerHTML = '<p class="nw-legend-title">Order Status</p>'
                + '<p class="nw-legend-hint">Live fulfilment breakdown — all time.</p>'
                + '<div class="nw-insight-pill nw-insight-pill--info"><i class="fas fa-box"></i> Most: ' + (maxStatus||'—') + '</div>'
                + rows;
        }

        /* ════════════════════════════════════════════════════
           CHART 3 — Stock-style Line + Gradient Area: revenue
        ════════════════════════════════════════════════════ */
        function drawStock() {
            var c = document.getElementById('salesChart'); if (!c) return;
            var ctx = c.getContext('2d');
            var W = c.width, H = c.height;
            var P = { t:36, r:28, b:52, l:72 };
            var cW = W-P.l-P.r, cH = H-P.t-P.b;
            var lbs = D.sales.labels, vs = D.sales.values;
            var col = c.parentElement;
            clearEmpty(col);

            /* ── empty/insufficient state ── */
            if (!lbs.length || lbs.length < 2) {
                ctx.clearRect(0,0,W,H);
                /* draw attractive placeholder grid */
                ctx.strokeStyle = BORDER; ctx.lineWidth = 1; ctx.setLineDash([4,4]);
                for (var g=0;g<=4;g++){
                    var gy=P.t+cH-(g/4)*cH;
                    ctx.beginPath(); ctx.moveTo(P.l,gy); ctx.lineTo(P.l+cW,gy); ctx.stroke();
                }
                ctx.setLineDash([]);
                /* faint demo curve */
                var demo = [0.3,0.5,0.4,0.7,0.6,0.85];
                ctx.beginPath(); ctx.strokeStyle = 'rgba(200,169,110,0.25)'; ctx.lineWidth = 2.5;
                demo.forEach(function(v,i){
                    var x=P.l+(i/(demo.length-1))*cW, y=P.t+cH-v*cH;
                    i===0 ? ctx.moveTo(x,y) : ctx.lineTo(x,y);
                });
                ctx.stroke();
                /* message */
                ctx.fillStyle = MUTED; ctx.font = 'bold 13px system-ui,sans-serif'; ctx.textAlign = 'center';
                ctx.fillText('Revenue data will appear here', W/2, H/2 - 10);
                ctx.font = '11px system-ui,sans-serif';
                ctx.fillText('Complete more orders to populate this chart', W/2, H/2 + 10);
                return;
            }

            var n   = lbs.length;
            var max = Math.max.apply(null, vs.concat([1]));
            var min = Math.min.apply(null, vs);
            var range = max - min || 1;

            /* compute points using Catmull-Rom tension for smooth curve */
            var pts = lbs.map(function(_,i){
                return { x: P.l + (i/(n-1))*cW, y: P.t + cH - ((vs[i]-min)/range)*cH*0.82 - cH*0.08 };
            });

            hitData[2] = pts.map(function(p,i){
                var band = n>1 ? cW/(n-1)/2 : cW/2;
                return { x:p.x, y:p.y, band:band,
                    tip:'<span class="nw-tooltip__label">'+lbs[i]+'</span>Rs. '+niceNum(vs[i]) };
            });

            /* animate progress */
            var progress = 0;
            function frame() {
                progress = Math.min(progress + 0.045, 1);
                ctx.clearRect(0,0,W,H);

                /* ── Y-axis grid lines ── */
                ctx.setLineDash([4,5]);
                for (var g=0;g<=4;g++) {
                    var gy = P.t+cH-(g/4)*cH;
                    ctx.strokeStyle = BORDER; ctx.lineWidth = 1;
                    ctx.beginPath(); ctx.moveTo(P.l,gy); ctx.lineTo(P.l+cW,gy); ctx.stroke();
                    ctx.fillStyle = MUTED; ctx.font='10px system-ui,sans-serif'; ctx.textAlign='right';
                    ctx.fillText('Rs.'+niceNum(Math.round(min+(range*g/4))), P.l-8, gy+4);
                }
                ctx.setLineDash([]);

                /* baseline */
                ctx.strokeStyle=BORDER; ctx.lineWidth=1.5;
                ctx.beginPath(); ctx.moveTo(P.l,P.t+cH); ctx.lineTo(P.l+cW,P.t+cH); ctx.stroke();

                /* clip to progress */
                var clipX = P.l + cW * progress;
                ctx.save();
                ctx.beginPath();
                ctx.rect(P.l, 0, cW * progress, H);
                ctx.clip();

                /* ── Gradient area fill ── */
                ctx.beginPath();
                ctx.moveTo(pts[0].x, P.t+cH);
                /* smooth bezier through points */
                for (var i=0;i<pts.length-1;i++) {
                    var cp1x = pts[i].x   + (pts[i+1].x-pts[i].x)*0.45;
                    var cp1y = pts[i].y;
                    var cp2x = pts[i+1].x - (pts[i+1].x-pts[i].x)*0.45;
                    var cp2y = pts[i+1].y;
                    if (i===0) ctx.lineTo(pts[i].x, pts[i].y);
                    ctx.bezierCurveTo(cp1x,cp1y,cp2x,cp2y,pts[i+1].x,pts[i+1].y);
                }
                ctx.lineTo(pts[n-1].x, P.t+cH);
                ctx.closePath();
                var areaGr = ctx.createLinearGradient(0,P.t,0,P.t+cH);
                areaGr.addColorStop(0,'rgba(200,169,110,0.28)');
                areaGr.addColorStop(0.6,'rgba(200,169,110,0.08)');
                areaGr.addColorStop(1,'rgba(200,169,110,0.01)');
                ctx.fillStyle = areaGr; ctx.fill();

                /* ── Smooth line ── */
                ctx.beginPath(); ctx.strokeStyle=GOLD; ctx.lineWidth=2.8; ctx.lineJoin='round';
                for (var j=0;j<pts.length-1;j++) {
                    var c1x=pts[j].x+(pts[j+1].x-pts[j].x)*0.45, c1y=pts[j].y;
                    var c2x=pts[j+1].x-(pts[j+1].x-pts[j].x)*0.45, c2y=pts[j+1].y;
                    if (j===0) ctx.moveTo(pts[j].x,pts[j].y);
                    ctx.bezierCurveTo(c1x,c1y,c2x,c2y,pts[j+1].x,pts[j+1].y);
                }
                ctx.stroke();

                /* ── Line glow ── */
                ctx.beginPath(); ctx.strokeStyle='rgba(200,169,110,0.18)'; ctx.lineWidth=8;
                for (var k=0;k<pts.length-1;k++) {
                    var d1x=pts[k].x+(pts[k+1].x-pts[k].x)*0.45, d1y=pts[k].y;
                    var d2x=pts[k+1].x-(pts[k+1].x-pts[k].x)*0.45, d2y=pts[k+1].y;
                    if (k===0) ctx.moveTo(pts[k].x,pts[k].y);
                    ctx.bezierCurveTo(d1x,d1y,d2x,d2y,pts[k+1].x,pts[k+1].y);
                }
                ctx.stroke();

                ctx.restore();

                /* ── Data points ── */
                pts.forEach(function(p,i) {
                    if (p.x > clipX + 4) return;
                    /* outer ring */
                    ctx.beginPath(); ctx.arc(p.x,p.y,8,0,2*Math.PI);
                    ctx.fillStyle='rgba(200,169,110,0.18)'; ctx.fill();
                    /* white fill */
                    ctx.beginPath(); ctx.arc(p.x,p.y,5,0,2*Math.PI);
                    ctx.fillStyle='#fff'; ctx.fill();
                    ctx.strokeStyle=GOLD; ctx.lineWidth=2.2; ctx.stroke();
                    /* inner dot */
                    ctx.beginPath(); ctx.arc(p.x,p.y,2.5,0,2*Math.PI);
                    ctx.fillStyle=GOLD; ctx.fill();

                    /* x-axis label */
                    ctx.fillStyle=TEXT; ctx.font='10.5px system-ui,sans-serif'; ctx.textAlign='center';
                    ctx.fillText(lbs[i], p.x, P.t+cH+17);
                });

                if (progress < 1) requestAnimationFrame(frame);
                else bindHover(2);
            }
            requestAnimationFrame(frame);

            /* ── Legend col ── */
            var leg = document.getElementById('salesLegend');
            if (!leg) return;
            var last=vs[vs.length-1], prev=vs[vs.length-2];
            var diff=last-prev, sign=diff>=0?'▲':'▼';
            var pillCls = diff>=0 ? 'nw-insight-pill--up' : 'nw-insight-pill--down';
            var highIdx = vs.indexOf(Math.max.apply(null,vs));
            var totalRev = vs.reduce(function(a,b){return a+b;},0);
            leg.innerHTML = '<p class="nw-legend-title">Revenue Trend</p>'
                + '<p class="nw-legend-hint">Monthly revenue from delivered orders — last '+n+' months.</p>'
                + '<div class="nw-insight-pill '+pillCls+'">'+sign+' Rs.'+niceNum(Math.abs(diff))+' vs prev month</div>'
                + '<div class="nw-insight-pill nw-insight-pill--info" style="margin-top:4px"><i class="fas fa-trophy"></i> Peak: '+(lbs[highIdx]||'—')+' (Rs.'+niceNum(vs[highIdx])+')</div>'
                + '<div class="nw-insight-pill nw-insight-pill--info" style="margin-top:4px">Σ Total: Rs.'+niceNum(totalRev)+'</div>'
                + '<div id="salesInsight" style="margin-top:8px"></div>';
        }

        /* ════════════════════════════════════════════════════
           CHART 4 — Animated H-Bar: low stock
        ════════════════════════════════════════════════════ */
        function drawHBar() {
            var c = document.getElementById('stockChart'); if (!c) return;
            var ctx = c.getContext('2d');
            var W = c.width, H = c.height;
            ctx.clearRect(0,0,W,H);
            var lbs = D.stock.labels, vs = D.stock.values;
            var col = c.parentElement;
            clearEmpty(col);

            if (!lbs.length) {
                ctx.fillStyle = '#4caf50';
                ctx.font = 'bold 14px system-ui,sans-serif'; ctx.textAlign='center';
                ctx.fillText('✓ All products are well-stocked!', W/2, H/2-8);
                ctx.fillStyle = MUTED; ctx.font='11px system-ui,sans-serif';
                ctx.fillText('No restocking needed right now', W/2, H/2+12);
                var leg2 = document.getElementById('stockLegend');
                if (leg2) leg2.innerHTML += '<div class="nw-insight-pill nw-insight-pill--up" style="margin-top:8px">✓ Stock healthy</div>';
                return;
            }

            var n      = lbs.length;
            var PAD_L  = Math.min(W*0.38, 200);
            var PAD_R  = 60, PAD_T = 20, PAD_B = 20;
            var chartW = W - PAD_L - PAD_R;
            var rowH   = Math.min(44, (H-PAD_T-PAD_B)/n);
            var max    = Math.max.apply(null, vs.concat([5]));

            hitData[3] = [];
            var progress = 0;
            function frame() {
                progress = Math.min(progress + 0.06, 1);
                var ease = 1 - Math.pow(1-progress, 3);
                ctx.clearRect(0,0,W,H);

                lbs.forEach(function(name,i) {
                    var v    = vs[i];
                    var y    = PAD_T + i*rowH;
                    var fullW= Math.max(0,(v/max)*chartW);
                    var bW   = fullW * ease;
                    var clr  = v===0 ? '#e53935' : v<=2 ? '#ff9800' : GOLD;
                    var mid  = y + rowH*0.65;

                    /* product name */
                    ctx.fillStyle=TEXT; ctx.font='11.5px system-ui,sans-serif'; ctx.textAlign='right';
                    var short = name.length>22 ? name.substring(0,20)+'…' : name;
                    ctx.fillText(short, PAD_L-10, mid);

                    /* track */
                    rRect(ctx, PAD_L, y+10, chartW, rowH-20, 6);
                    ctx.fillStyle='#f0ebe4'; ctx.fill();

                    /* filled bar with gradient - red for critical, orange for warning, green for normal */
                    if (bW > 0) {
                        var bgr = ctx.createLinearGradient(PAD_L,0,PAD_L+bW,0);
                        if (v===0)  { bgr.addColorStop(0,'#ef9a9a'); bgr.addColorStop(1,'#e53935'); }
                        else if(v<=2){bgr.addColorStop(0,'#ffcc80'); bgr.addColorStop(1,'#ff9800'); }
                        else        { bgr.addColorStop(0,'#6EE7B7'); bgr.addColorStop(1,'#10B981'); }
                        rRect(ctx, PAD_L, y+10, bW, rowH-20, 6);
                        ctx.fillStyle=bgr; ctx.fill();
                    }

                    /* count label */
                    if (progress > 0.5) {
                        ctx.fillStyle = v===0 ? '#e53935' : WALNUT;
                        ctx.font='bold 11px system-ui,sans-serif'; ctx.textAlign='left';
                        ctx.fillText(v+' left', PAD_L+bW+8, mid);
                    }

                    hitData[3][i] = { x:PAD_L, y:y+8, w:chartW, h:rowH-16,
                        tip:'<span class="nw-tooltip__label">'+name+'</span>'
                            + v + ' units remaining'
                            + (v===0 ? ' — <i class="fas fa-exclamation-triangle" style="color:#EF4444;"></i> OUT OF STOCK' : v<=2 ? ' — <i class="fas fa-exclamation-triangle" style="color:#EF4444;"></i> Critical' : '') };
                });

                if (progress < 1) requestAnimationFrame(frame);
                else bindHover(3);
            }
            requestAnimationFrame(frame);

            /* legend */
            var leg = document.getElementById('stockLegend');
            if (!leg) return;
            var zero = vs.filter(function(v){return v===0;}).length;
            var crit = vs.filter(function(v){return v>0&&v<=2;}).length;
            var pillHtml = zero
                ? '<div class="nw-insight-pill nw-insight-pill--down"><i class="fas fa-exclamation-triangle" style="color:#EF4444;"></i> '+zero+' out of stock</div>'
                : crit
                    ? '<div class="nw-insight-pill nw-insight-pill--warn"><i class="fas fa-exclamation-triangle" style="color:#EF4444;"></i> '+crit+' critical (≤2)</div>'
                    : '<div class="nw-insight-pill nw-insight-pill--warn">'+n+' items need restock</div>';
            var rows = lbs.map(function(l,i){
                var v=vs[i], clr=v===0?'#e53935':v<=2?'#ff9800':GOLD;
                return '<div class="nw-leg-row">'
                    + '<span class="nw-leg-dot" style="background:'+clr+'"></span>'
                    + '<span class="nw-leg-name">'+l+'</span>'
                    + '<span class="nw-leg-val" style="color:'+clr+'">'+v+'</span>'
                    + '</div>';
            }).join('');
            leg.innerHTML = '<p class="nw-legend-title">Stock Alert</p>'
                + '<p class="nw-legend-hint">Products with ≤5 units. Restock soon.</p>'
                + pillHtml + rows;
        }

        /* ── resize handler ── */
        window.addEventListener('resize', function () {
            painted[cur] = false;
            hitData[cur] = [];
            sizeCanvas(cur);
            SLIDES[cur].draw();
            painted[cur] = true;
        });

        /* ── Boot ── */
        goTo(0);
        startTimer();

    })();
</script>
</body>
</html>
