<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Contact Us — NestWood</title>
    <link rel="preconnect" href="https://cdnjs.cloudflare.com">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css"
          integrity="sha512-DTOQO9RWCH3ppGqcWaEA1BIZOC6xxalwEsw9c2QQeAIftl+Vegovlnee1c9QX4TctnWMn13TZye+giMm8e2LwA=="
          crossorigin="anonymous" referrerpolicy="no-referrer" media="print" onload="this.media='all'">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css?v=5.4">
    <style>
        .contact-hero {
            background: linear-gradient(135deg, #8A6840 0%, #B8933A 50%, #D4AF70 100%);
            color: #fff;
            padding: 5rem 2rem 4rem;
            text-align: center;
            position: relative;
            overflow: hidden;
        }

        .contact-hero::before {
            content: '';
            position: absolute;
            inset: 0;
            background: linear-gradient(135deg, rgba(0,0,0,0.2) 0%, transparent 100%);
            pointer-events: none;
        }

        .contact-hero .section-label {
            color: #FFF8E7;
            letter-spacing: 0.12em;
            font-size: 0.85rem;
            text-transform: uppercase;
            margin-bottom: 0.75rem;
            position: relative;
            z-index: 1;
        }

        .contact-hero h1 {
            font-size: clamp(1.8rem, 4vw, 2.8rem);
            font-weight: 700;
            margin-bottom: 1rem;
            position: relative;
            z-index: 1;
            text-shadow: 0 2px 8px rgba(0,0,0,0.2);
        }

        .contact-hero p {
            color: rgba(255,255,255,0.9);
            max-width: 540px;
            margin: 0 auto;
            line-height: 1.7;
            position: relative;
            z-index: 1;
        }

        .contact-layout {
            max-width: 1100px;
            margin: 0 auto;
            padding: 4rem 2rem;
            display: grid;
            grid-template-columns: 1fr 1.5fr;
            gap: 3rem;
            align-items: start;
        }

        /* Info cards */
        .contact-info h2 { font-size: 1.5rem; font-weight: 700; color: #1a1a2e; margin-bottom: 1.2rem; }
        .contact-info p { color: #666; line-height: 1.7; margin-bottom: 1.5rem; }
        .info-item {
            display: flex;
            align-items: flex-start;
            gap: 1rem;
            margin-bottom: 1.2rem;
        }
        .info-icon {
            width: 44px; height: 44px;
            border-radius: 50%;
            background: #fef9f0;
            border: 2px solid #c8a96e;
            color: #c8a96e;
            display: flex; align-items: center; justify-content: center;
            font-size: 1rem;
            flex-shrink: 0;
        }
        .info-text strong { display: block; color: #1a1a2e; font-weight: 600; margin-bottom: 0.2rem; }
        .info-text span { color: #666; font-size: 0.93rem; }

        .social-row { display: flex; gap: 0.75rem; margin-top: 1.5rem; }
        .social-btn {
            width: 40px; height: 40px;
            border-radius: 50%;
            background: #faf7f2;
            border: 1px solid #e8ddd0;
            color: #c8a96e;
            display: flex; align-items: center; justify-content: center;
            text-decoration: none;
            transition: background 0.2s, color 0.2s;
        }
        .social-btn:hover { background: #c8a96e; color: #fff; }

        /* Form card */
        .contact-form-card {
            background: #fff;
            border-radius: 14px;
            padding: 2.5rem;
            box-shadow: 0 4px 24px rgba(0,0,0,0.08);
        }
        .contact-form-card h2 { font-size: 1.4rem; font-weight: 700; color: #1a1a2e; margin-bottom: 1.5rem; }

        .form-row { display: grid; grid-template-columns: 1fr 1fr; gap: 1rem; }
        .form-group { margin-bottom: 1.2rem; }
        .form-group label {
            display: block;
            font-size: 0.88rem;
            font-weight: 600;
            color: #444;
            margin-bottom: 0.4rem;
        }
        .form-group label .req { color: #c8a96e; }
        .form-group input,
        .form-group select,
        .form-group textarea {
            width: 100%;
            padding: 0.7rem 1rem;
            border: 1.5px solid #e0d5c8;
            border-radius: 7px;
            font-size: 0.95rem;
            color: #333;
            background: #faf7f2;
            transition: border-color 0.2s;
            box-sizing: border-box;
            font-family: inherit;
        }
        .form-group input:focus,
        .form-group select:focus,
        .form-group textarea:focus {
            outline: none;
            border-color: #c8a96e;
            background: #fff;
        }
        .form-group textarea { resize: vertical; min-height: 130px; }

        .form-group .field-error {
            color: #c0392b;
            font-size: 0.82rem;
            margin-top: 0.3rem;
            display: none;
        }
        .form-group.has-error input,
        .form-group.has-error textarea,
        .form-group.has-error select { border-color: #c0392b; }
        .form-group.has-error .field-error { display: block; }

        .alert-success {
            background: #eafaf1;
            border-left: 4px solid #27ae60;
            padding: 1rem 1.2rem;
            border-radius: 7px;
            color: #1e8449;
            margin-bottom: 1.5rem;
            display: flex;
            align-items: center;
            gap: 0.6rem;
        }
        .alert-error {
            background: #fdf0ef;
            border-left: 4px solid #c0392b;
            padding: 1rem 1.2rem;
            border-radius: 7px;
            color: #c0392b;
            margin-bottom: 1.5rem;
        }

        .btn-submit {
            width: 100%;
            padding: 0.9rem;
            background: #c8a96e;
            color: #fff;
            border: none;
            border-radius: 7px;
            font-size: 1rem;
            font-weight: 600;
            cursor: pointer;
            transition: background 0.2s;
            letter-spacing: 0.03em;
        }
        .btn-submit:hover { background: #a07840; }

        .map-placeholder {
            background: #f5efe6;
            border-radius: 12px;
            height: 200px;
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            color: #c8a96e;
            margin-top: 2rem;
            gap: 0.5rem;
        }
        .map-placeholder i { font-size: 2.5rem; }
        .map-placeholder p { font-size: 0.9rem; color: #888; margin: 0; }

        @media (max-width: 768px) {
            .contact-layout { grid-template-columns: 1fr; }
            .form-row { grid-template-columns: 1fr; }
        }
    </style>
</head>
<body class="user-layout">

<jsp:include page="/WEB-INF/includes/user-header.jsp"/>

<%-- ── Hero ─────────────────────────────────────────────────────── --%>
<section class="contact-hero">
    <p class="section-label">Get in Touch</p>
    <h1>We'd Love to Hear From You</h1>
    <p>Have a question about a product, an order, or just want to say hello? Send us a message and we'll get back to you within 24 hours.</p>
</section>

<%-- ── Main Layout ─────────────────────────────────────────────── --%>
<div class="contact-layout">

    <%-- Contact Info Column --%>
    <div class="contact-info">
        <h2>Contact Information</h2>
        <p>Visit our showroom or reach out online — we're always happy to help you find the perfect piece for your home.</p>

        <div class="info-item">
            <div class="info-icon"><i class="fas fa-map-marker-alt"></i></div>
            <div class="info-text">
                <strong>Showroom</strong>
                <span>Durbar Marg, Kathmandu 44600, Nepal</span>
            </div>
        </div>
        <div class="info-item">
            <div class="info-icon"><i class="fas fa-phone"></i></div>
            <div class="info-text">
                <strong>Phone</strong>
                <span>+977 01-4444-555</span>
            </div>
        </div>
        <div class="info-item">
            <div class="info-icon"><i class="fas fa-envelope"></i></div>
            <div class="info-text">
                <strong>Email</strong>
                <span>hello@nestwood.com.np</span>
            </div>
        </div>
        <div class="info-item">
            <div class="info-icon"><i class="fas fa-clock"></i></div>
            <div class="info-text">
                <strong>Working Hours</strong>
                <span>Sun–Fri: 10:00 AM – 7:00 PM</span>
            </div>
        </div>

        <div class="social-row">
            <a href="#" class="social-btn" title="Facebook" aria-label="Facebook"><i class="fab fa-facebook-f"></i></a>
            <a href="#" class="social-btn" title="Instagram" aria-label="Instagram"><i class="fab fa-instagram"></i></a>
            <a href="#" class="social-btn" title="Twitter" aria-label="Twitter"><i class="fab fa-twitter"></i></a>
        </div>

        <div class="map-placeholder">
            <i class="fas fa-map-marked-alt"></i>
            <p>Kathmandu, Nepal</p>
        </div>
    </div>

    <%-- Contact Form Column --%>
    <div class="contact-form-card">
        <h2>Send Us a Message</h2>

        <%-- Success / Error feedback from servlet --%>
        <c:if test="${param.sent eq 'true'}">
            <div class="alert-success">
                <i class="fas fa-check-circle"></i>
                Thank you! Your message has been received. We'll get back to you within 24 hours.
            </div>
        </c:if>
        <c:if test="${not empty requestScope.error}">
            <div class="alert-error">
                <i class="fas fa-exclamation-circle"></i> ${requestScope.error}
            </div>
        </c:if>

        <form id="contactForm" action="${pageContext.request.contextPath}/contact" method="post" novalidate>

            <div class="form-row">
                <div class="form-group" id="fg-name">
                    <label for="fullName">Full Name <span class="req">*</span></label>
                    <input type="text" id="fullName" name="fullName"
                           value="${param.fullName}" placeholder="Aarav Shrestha" maxlength="80">
                    <span class="field-error" id="err-name">Please enter your full name.</span>
                </div>
                <div class="form-group" id="fg-email">
                    <label for="email">Email Address <span class="req">*</span></label>
                    <input type="email" id="email" name="email"
                           value="${param.email}" placeholder="you@email.com" maxlength="100">
                    <span class="field-error" id="err-email">Please enter a valid email.</span>
                </div>
            </div>

            <div class="form-row">
                <div class="form-group">
                    <label for="phone">Phone (optional)</label>
                    <input type="tel" id="phone" name="phone"
                           value="${param.phone}" placeholder="+977 98xxxxxxxx" maxlength="20">
                </div>
                <div class="form-group" id="fg-subject">
                    <label for="subject">Subject <span class="req">*</span></label>
                    <select id="subject" name="subject">
                        <option value="">— Select a topic —</option>
                        <option value="product" ${param.subject eq 'product' ? 'selected' : ''}>Product Enquiry</option>
                        <option value="order"   ${param.subject eq 'order'   ? 'selected' : ''}>Order / Delivery</option>
                        <option value="return"  ${param.subject eq 'return'  ? 'selected' : ''}>Return / Refund</option>
                        <option value="custom"  ${param.subject eq 'custom'  ? 'selected' : ''}>Custom Furniture</option>
                        <option value="other"   ${param.subject eq 'other'   ? 'selected' : ''}>Other</option>
                    </select>
                    <span class="field-error" id="err-subject">Please select a subject.</span>
                </div>
            </div>

            <div class="form-group" id="fg-message">
                <label for="message">Message <span class="req">*</span></label>
                <textarea id="message" name="message"
                          placeholder="Tell us how we can help you..."
                          maxlength="1000">${param.message}</textarea>
                <span class="field-error" id="err-msg">Please enter your message (at least 10 characters).</span>
            </div>

            <button type="submit" class="btn-submit" id="submitBtn">
                <i class="fas fa-paper-plane"></i> Send Message
            </button>
        </form>
    </div>
</div>

<footer class="site-footer">
    <div class="footer-grid">
        <div>
            <div class="footer-brand-name"><i class="fas fa-tree" aria-hidden="true"></i> Nest<span>Wood</span></div>
            <p class="footer-brand-desc">Premium furniture for modern homes. Crafted with care, designed for comfort.</p>
            <div class="footer-social">
                <a href="#" aria-label="Facebook"><i class="fab fa-facebook" aria-hidden="true"></i></a>
                <a href="#" aria-label="Instagram"><i class="fab fa-instagram" aria-hidden="true"></i></a>
                <a href="#" aria-label="Twitter"><i class="fab fa-twitter" aria-hidden="true"></i></a>
                <a href="#" aria-label="Pinterest"><i class="fab fa-pinterest" aria-hidden="true"></i></a>
            </div>
        </div>
        <div class="footer-col">
            <h4>Quick Links</h4>
            <ul>
                <li><a href="${pageContext.request.contextPath}/user/dashboard">Home</a></li>
                <li><a href="${pageContext.request.contextPath}/user/browse">Browse</a></li>
                <li><a href="${pageContext.request.contextPath}/about">About Us</a></li>
                <li><a href="${pageContext.request.contextPath}/contact">Contact</a></li>
            </ul>
        </div>
        <div class="footer-col">
            <h4>Customer Service</h4>
            <ul>
                <li><a href="${pageContext.request.contextPath}/order?action=history">Track Order</a></li>
                <li><a href="${pageContext.request.contextPath}/wishlist">Wishlist</a></li>
                <li><a href="${pageContext.request.contextPath}/user/profile">My Account</a></li>
                <li><a href="${pageContext.request.contextPath}/contact">Help & Support</a></li>
            </ul>
        </div>
        <div class="footer-col">
            <h4>Contact Info</h4>
            <ul class="footer-contact">
                <li><i class="fas fa-map-marker-alt" aria-hidden="true"></i> Kathmandu, Nepal</li>
                <li><i class="fas fa-phone" aria-hidden="true"></i> +977 1-4567890</li>
                <li><a href="mailto:info@nestwood.com"><i class="fas fa-envelope" aria-hidden="true"></i> info@nestwood.com</a></li>
                <li><i class="fas fa-clock" aria-hidden="true"></i> Mon-Sat: 9AM-6PM</li>
            </ul>
        </div>
    </div>
    <div class="footer-bottom">
        <p>© 2025 NestWood · Premium Furniture E-Commerce · Nepal</p>
        <div class="footer-bottom-links">
            <a href="#">Privacy Policy</a>
            <a href="#">Terms of Service</a>
        </div>
    </div>
</footer>


<script>
    /* ── Client-side validation for contact form ── */
    (function () {
        const form = document.getElementById('contactForm');
        if (!form) return;

        function setError(groupId, show) {
            const grp = document.getElementById(groupId);
            if (!grp) return;
            grp.classList.toggle('has-error', show);
        }

        function validateEmail(v) {
            return /^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(v);
        }

        form.addEventListener('submit', function (e) {
            let valid = true;

            const name    = document.getElementById('fullName').value.trim();
            const email   = document.getElementById('email').value.trim();
            const subject = document.getElementById('subject').value;
            const message = document.getElementById('message').value.trim();

            const nameErr = !name || name.length < 2;
            const emailErr = !email || !validateEmail(email);
            const subjectErr = !subject;
            const msgErr = !message || message.length < 10;

            setError('fg-name',    nameErr);
            setError('fg-email',   emailErr);
            setError('fg-subject', subjectErr);
            setError('fg-message', msgErr);

            if (nameErr || emailErr || subjectErr || msgErr) {
                e.preventDefault();
                // Scroll to first error
                const firstError = form.querySelector('.has-error');
                if (firstError) firstError.scrollIntoView({ behavior: 'smooth', block: 'center' });
                return;
            }

            // Visual feedback on submit
            const btn = document.getElementById('submitBtn');
            btn.textContent = 'Sending…';
            btn.disabled = true;
        });

        // Clear error on input
        ['fullName','email','subject','message'].forEach(function(id) {
            const el = document.getElementById(id);
            if (el) el.addEventListener('input', function() {
                const grp = el.closest('.form-group');
                if (grp) grp.classList.remove('has-error');
            });
        });
    })();
</script>
</body>
</html>
