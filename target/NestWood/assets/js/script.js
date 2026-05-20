/* ================================================================
   NestWood — Main JavaScript
   Hero slider · Mobile nav · Image fallback · Admin chart
   No jQuery. No external libraries.
   ================================================================ */

/* ── Hero / Featured Slider ────────────────────────────────────── */
function initSliders() {
    var sections = document.querySelectorAll('.slider-section');
    if (!sections.length) return;

    sections.forEach(function (section) {
        var track  = section.querySelector('.slider-track');
        var dots   = section.querySelectorAll('.slider-dot');
        var slides = section.querySelectorAll('.slide');
        if (!track || !slides.length) return;

        var current = 0;
        var timer   = null;
        var DELAY   = 5000;
        var TOTAL   = slides.length;

        function goTo(idx) {
            if (idx < 0)      idx = TOTAL - 1;
            if (idx >= TOTAL) idx = 0;
            current = idx;
            track.style.transform = 'translateX(-' + (100 * current) + '%)';
            dots.forEach(function (d, i) {
                d.classList.toggle('active', i === current);
            });
        }

        function autoPlay() {
            timer = setInterval(function () { goTo(current + 1); }, DELAY);
        }
        function pause()  { clearInterval(timer); }
        function resume() { pause(); autoPlay(); }

        dots.forEach(function (dot, i) {
            dot.addEventListener('click', function () { goTo(i); resume(); });
        });

        var prevBtn = section.querySelector('.slider-arrow.prev');
        var nextBtn = section.querySelector('.slider-arrow.next');
        if (prevBtn) prevBtn.addEventListener('click', function () { goTo(current - 1); resume(); });
        if (nextBtn) nextBtn.addEventListener('click', function () { goTo(current + 1); resume(); });

        /* Touch swipe */
        var touchX = 0;
        track.addEventListener('touchstart', function (e) {
            touchX = e.touches[0].clientX; pause();
        }, { passive: true });
        track.addEventListener('touchend', function (e) {
            var diff = touchX - e.changedTouches[0].clientX;
            if (Math.abs(diff) > 48) goTo(diff > 0 ? current + 1 : current - 1);
            resume();
        }, { passive: true });

        section.addEventListener('mouseenter', pause);
        section.addEventListener('mouseleave', resume);

        goTo(0);
        autoPlay();
    });
}

/* ── Mobile Nav Toggle ─────────────────────────────────────────── */
function initNav() {
    var toggle = document.querySelector('.nav-toggle');
    var links  = document.querySelector('.nav-links');
    if (!toggle || !links) return;
    toggle.addEventListener('click', function () {
        links.classList.toggle('open');
        toggle.setAttribute('aria-expanded', links.classList.contains('open'));
    });
    links.querySelectorAll('a').forEach(function (a) {
        a.addEventListener('click', function () { links.classList.remove('open'); });
    });
    /* Close on outside click */
    document.addEventListener('click', function (e) {
        if (!toggle.contains(e.target) && !links.contains(e.target)) {
            links.classList.remove('open');
        }
    });
}

/* ── Product Image Fallback ────────────────────────────────────── */
function initImageFallback() {
    document.querySelectorAll('img.product-img').forEach(function (img) {
        img.addEventListener('error', function () {
            this.style.display = 'none';
            var wrap = this.closest('.product-img-wrap') || this.parentElement;
            if (wrap && !wrap.querySelector('.product-img-placeholder')) {
                var ph = document.createElement('div');
                ph.className = 'product-img-placeholder';
                ph.textContent = '🛋️';
                wrap.appendChild(ph);
            }
        });
    });
    document.querySelectorAll('img.table-thumb').forEach(function (img) {
        img.addEventListener('error', function () {
            this.style.display = 'none';
        });
    });
}

/* ── Admin Revenue Chart (SVG) ─────────────────────────────────── */
function initAdminChart() {
    var wrap = document.querySelector('.chart-svg-wrap');
    if (!wrap) return;

    /* Fake 6-month data — replace with real data attributes if needed */
    var dataAttr = wrap.getAttribute('data-values');
    var values   = dataAttr ? JSON.parse(dataAttr) : [420,680,510,790,850,920];
    var labels   = wrap.getAttribute('data-labels')
        ? JSON.parse(wrap.getAttribute('data-labels'))
        : ['Jan','Feb','Mar','Apr','May','Jun'];

    var W = wrap.clientWidth || 500;
    var H = wrap.clientHeight || 180;
    var padL = 48, padR = 20, padT = 20, padB = 36;
    var chartW = W - padL - padR;
    var chartH = H - padT - padB;

    var maxV = Math.max.apply(null, values) * 1.1;
    var minV = 0;

    function xPos(i) { return padL + (i / (values.length - 1)) * chartW; }
    function yPos(v) { return padT + chartH - ((v - minV) / (maxV - minV)) * chartH; }

    /* Build path */
    var path = '';
    var areaPath = '';
    values.forEach(function(v, i) {
        var x = xPos(i);
        var y = yPos(v);
        if (i === 0) {
            path     += 'M ' + x + ' ' + y;
            areaPath += 'M ' + x + ' ' + (padT + chartH) + ' L ' + x + ' ' + y;
        } else {
            /* Smooth bezier */
            var px = xPos(i - 1);
            var py = yPos(values[i - 1]);
            var cpx = (px + x) / 2;
            path     += ' C ' + cpx + ' ' + py + ', ' + cpx + ' ' + y + ', ' + x + ' ' + y;
            areaPath += ' C ' + cpx + ' ' + py + ', ' + cpx + ' ' + y + ', ' + x + ' ' + y;
        }
    });
    areaPath += ' L ' + xPos(values.length - 1) + ' ' + (padT + chartH) + ' Z';

    /* Y-axis guide lines */
    var guides = '';
    var ticks  = 4;
    for (var t = 0; t <= ticks; t++) {
        var yv = minV + (maxV - minV) * (t / ticks);
        var gy = yPos(yv);
        guides += '<line x1="' + padL + '" y1="' + gy + '" x2="' + (W - padR) + '" y2="' + gy + '" stroke="#E4DDD4" stroke-width="1"/>';
        var label = yv >= 1000 ? Math.round(yv / 1000) + 'K' : Math.round(yv);
        guides += '<text x="' + (padL - 6) + '" y="' + (gy + 4) + '" fill="#8C7B6E" font-size="10" text-anchor="end">' + label + '</text>';
    }

    /* X-axis labels */
    var xlabels = '';
    labels.forEach(function(lbl, i) {
        xlabels += '<text x="' + xPos(i) + '" y="' + (H - 6) + '" fill="#8C7B6E" font-size="10" text-anchor="middle">' + lbl + '</text>';
    });

    /* Dots on data points */
    var dotsSvg = '';
    values.forEach(function(v, i) {
        dotsSvg += '<circle cx="' + xPos(i) + '" cy="' + yPos(v) + '" r="4" fill="#B8933A" stroke="#fff" stroke-width="2"/>';
    });

    var svgId = 'nw-chart-grad-' + Math.random().toString(36).slice(2, 7);
    var svg = '<svg width="100%" height="100%" viewBox="0 0 ' + W + ' ' + H + '" xmlns="http://www.w3.org/2000/svg">'
        + '<defs>'
        + '<linearGradient id="' + svgId + '" x1="0" y1="0" x2="0" y2="1">'
        + '<stop offset="0%" stop-color="#B8933A" stop-opacity="0.25"/>'
        + '<stop offset="100%" stop-color="#B8933A" stop-opacity="0.02"/>'
        + '</linearGradient>'
        + '</defs>'
        + guides
        + '<path d="' + areaPath + '" fill="url(#' + svgId + ')"/>'
        + '<path d="' + path + '" fill="none" stroke="#B8933A" stroke-width="2.5" stroke-linejoin="round" stroke-linecap="round"/>'
        + dotsSvg
        + xlabels
        + '</svg>';

    wrap.innerHTML = svg;
}

/* ── Checkout: quantity selector ───────────────────────────────── */
function initQuantity() {
    document.querySelectorAll('.qty-minus, .qty-plus').forEach(function (btn) {
        btn.addEventListener('click', function () {
            var input = this.closest('.qty-wrap').querySelector('input[name="quantity"]');
            if (!input) return;
            var val = parseInt(input.value) || 1;
            var max = parseInt(input.max) || 999;
            if (this.classList.contains('qty-minus')) val = Math.max(1, val - 1);
            else val = Math.min(max, val + 1);
            input.value = val;
            /* Update subtotal display if present */
            var priceEl = document.querySelector('.js-unit-price');
            var subEl   = document.querySelector('.js-subtotal');
            if (priceEl && subEl) {
                var unit = parseFloat(priceEl.getAttribute('data-price')) || 0;
                subEl.textContent = 'Rs. ' + (unit * val).toLocaleString();
            }
        });
    });
}

/* ── Status badge highlight ────────────────────────────────────── */
function initStatusSelect() {
    document.querySelectorAll('select.status-select').forEach(function (sel) {
        function updateColor() {
            sel.setAttribute('data-status', sel.value.toLowerCase());
        }
        sel.addEventListener('change', updateColor);
        updateColor();
    });
}

/* ── Avatar preview on register / profile ──────────────────────── */
function initAvatarPreview() {
    var fileInput = document.querySelector('input[name="profilePic"], input[name="photo"]');
    var circle    = document.querySelector('.avatar-upload-circle');
    if (!fileInput || !circle) return;
    fileInput.addEventListener('change', function () {
        var file = this.files[0];
        if (!file) return;
        var reader = new FileReader();
        reader.onload = function (e) {
            circle.style.backgroundImage = 'url(' + e.target.result + ')';
            circle.style.backgroundSize  = 'cover';
            circle.textContent = '';
        };
        reader.readAsDataURL(file);
    });
    circle.addEventListener('click', function () { fileInput.click(); });
}

/* ── Smooth scroll for anchor links ───────────────────────────── */
function initSmoothScroll() {
    document.querySelectorAll('a[href^="#"]').forEach(function (a) {
        a.addEventListener('click', function (e) {
            var target = document.querySelector(this.getAttribute('href'));
            if (target) {
                e.preventDefault();
                target.scrollIntoView({ behavior: 'smooth', block: 'start' });
            }
        });
    });
}

/* ── Alert auto-dismiss ────────────────────────────────────────── */
function initAlerts() {
    document.querySelectorAll('.alert[data-auto-dismiss]').forEach(function (el) {
        var delay = parseInt(el.getAttribute('data-auto-dismiss')) || 5000;
        setTimeout(function () {
            el.style.transition = 'opacity 0.5s ease, max-height 0.5s ease';
            el.style.opacity    = '0';
            el.style.maxHeight  = '0';
            el.style.overflow   = 'hidden';
            setTimeout(function () { el.remove(); }, 500);
        }, delay);
    });
}

/* ── Init all ──────────────────────────────────────────────────── */
document.addEventListener('DOMContentLoaded', function () {
    initSliders();
    initNav();
    initImageFallback();
    initAdminChart();
    initQuantity();
    initStatusSelect();
    initAvatarPreview();
    initSmoothScroll();
    initAlerts();
});


/* ── Mobile Navigation Toggle ──────────────────────────────────── */
function initMobileNav() {
    var toggle = document.querySelector('.nav-toggle');
    var navLinks = document.querySelector('.nav-links');
    
    if (!toggle || !navLinks) return;
    
    toggle.addEventListener('click', function() {
        navLinks.classList.toggle('active');
        toggle.setAttribute('aria-expanded', navLinks.classList.contains('active'));
    });
    
    // Close menu when clicking outside
    document.addEventListener('click', function(e) {
        if (!toggle.contains(e.target) && !navLinks.contains(e.target)) {
            navLinks.classList.remove('active');
            toggle.setAttribute('aria-expanded', 'false');
        }
    });
    
    // Close menu when clicking a link
    var links = navLinks.querySelectorAll('a');
    links.forEach(function(link) {
        link.addEventListener('click', function() {
            navLinks.classList.remove('active');
            toggle.setAttribute('aria-expanded', 'false');
        });
    });
}

/* Initialize mobile nav on page load */
if (document.readyState === 'loading') {
    document.addEventListener('DOMContentLoaded', initMobileNav);
} else {
    initMobileNav();
}
