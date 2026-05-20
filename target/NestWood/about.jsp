<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>About Us — NestWood</title>
    <link rel="preconnect" href="https://cdnjs.cloudflare.com">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css"
          integrity="sha512-DTOQO9RWCH3ppGqcWaEA1BIZOC6xxalwEsw9c2QQeAIftl+Vegovlnee1c9QX4TctnWMn13TZye+giMm8e2LwA=="
          crossorigin="anonymous" referrerpolicy="no-referrer" media="print" onload="this.media='all'">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css?v=5.4">
    <style>
        /* ── About-page specific styles ── */
        .about-hero {
            background: linear-gradient(135deg, #8A6840 0%, #B8933A 50%, #D4AF70 100%);
            color: #fff;
            padding: 5rem 2rem 4rem;
            text-align: center;
            position: relative;
            overflow: hidden;
        }
        
        .about-hero::before {
            content: '';
            position: absolute;
            inset: 0;
            background: linear-gradient(135deg, rgba(0,0,0,0.2) 0%, transparent 100%);
            pointer-events: none;
        }
        
        .about-hero .section-label {
            color: #FFF8E7;
            letter-spacing: 0.12em;
            font-size: 0.85rem;
            text-transform: uppercase;
            margin-bottom: 0.75rem;
            position: relative;
            z-index: 1;
        }
        
        .about-hero h1 {
            font-size: clamp(2rem, 5vw, 3.2rem);
            font-weight: 700;
            margin-bottom: 1.2rem;
            position: relative;
            z-index: 1;
            text-shadow: 0 2px 8px rgba(0,0,0,0.2);
        }
        
        .about-hero p {
            max-width: 600px;
            margin: 0 auto;
            color: rgba(255,255,255,0.9);
            font-size: 1.05rem;
            line-height: 1.7;
            position: relative;
            z-index: 1;
        }

        .about-section {
            max-width: 1100px;
            margin: 0 auto;
            padding: 4rem 2rem;
        }
        .about-grid {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 3rem;
            align-items: center;
        }
        .about-grid.reverse { direction: rtl; }
        .about-grid.reverse > * { direction: ltr; }

        .about-img-block {
            background: #f5efe6;
            border-radius: 12px;
            min-height: 280px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 6rem;
            background: linear-gradient(135deg, #8A6840 0%, #B8933A 50%, #D4AF70 100%);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
        }
        .about-text h2 {
            font-size: 1.9rem;
            font-weight: 700;
            color: #1a1a2e;
            margin-bottom: 1rem;
        }
        .about-text h2 span { color: #c8a96e; }
        .about-text p {
            color: #555;
            line-height: 1.8;
            margin-bottom: 1rem;
        }

        .values-section {
            background: #faf7f2;
            padding: 4rem 2rem;
        }
        .values-inner {
            max-width: 1100px;
            margin: 0 auto;
        }
        .values-inner h2 {
            text-align: center;
            font-size: 2rem;
            font-weight: 700;
            color: #1a1a2e;
            margin-bottom: 0.5rem;
        }
        .values-inner .sub {
            text-align: center;
            color: #888;
            margin-bottom: 3rem;
        }
        .values-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(220px, 1fr));
            gap: 1.5rem;
        }
        .value-card {
            background: #fff;
            border-radius: 12px;
            padding: 2rem 1.5rem;
            text-align: center;
            box-shadow: 0 2px 12px rgba(0,0,0,0.06);
            border: 2px solid #e8dcc8;
            border-top: 4px solid #c8a96e;
        }
        .value-card .icon {
            font-size: 2.2rem;
            margin-bottom: 1rem;
            background: linear-gradient(135deg, #8A6840 0%, #B8933A 50%, #D4AF70 100%);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
        }
        .value-card h3 {
            font-size: 1.1rem;
            font-weight: 600;
            color: #1a1a2e;
            margin-bottom: 0.5rem;
        }
        .value-card p { color: #666; font-size: 0.93rem; line-height: 1.6; }

        .team-section {
            max-width: 1200px;
            margin: 0 auto;
            padding: 4rem 2rem;
            text-align: center;
        }
        .team-section h2 {
            font-size: 2rem;
            font-weight: 700;
            color: #1a1a2e;
            margin-bottom: 0.5rem;
        }
        .team-section .sub { color: #888; margin-bottom: 3rem; }
        
        /* Team Grid */
        .team-grid {
            display: grid;
            grid-template-columns: repeat(5, 1fr);
            gap: 3rem;
            max-width: 1600px;
            margin: 0 auto;
        }
        
        .team-card {
            background: #fff;
            border-radius: 16px;
            padding: 0;
            transition: transform 0.3s ease, box-shadow 0.3s ease;
            box-shadow: 0 4px 16px rgba(0,0,0,0.1);
            overflow: hidden;
        }
        
        .team-card:hover {
            transform: translateY(-10px);
            box-shadow: 0 16px 32px rgba(0,0,0,0.18);
        }
        
        .team-avatar {
            width: 100%;
            height: 280px;
            background: linear-gradient(135deg, #c8a96e, #a07840);
            display: flex;
            align-items: center;
            justify-content: center;
            position: relative;
            overflow: hidden;
        }
        
        .team-avatar img {
            width: 100%;
            height: 100%;
            object-fit: cover;
        }
        
        .team-info {
            padding: 2rem 1.5rem;
            text-align: center;
        }
        
        .team-card h4 { 
            font-weight: 600; 
            color: #1a1a2e; 
            margin-bottom: 0.5rem;
            font-size: 1.2rem;
        }
        
        .team-card .role { 
            color: #c8a96e; 
            font-size: 0.95rem;
            font-weight: 600;
            display: block;
            margin-bottom: 1rem;
        }
        
        .team-card .description {
            color: #666;
            font-size: 0.92rem;
            line-height: 1.6;
        }
        
        @media (max-width: 1024px) {
            .team-grid {
                grid-template-columns: repeat(3, 1fr);
            }
        }
        
        @media (max-width: 768px) {
            .team-grid {
                grid-template-columns: repeat(2, 1fr);
            }
        }
        
        @media (max-width: 480px) {
            .team-grid {
                grid-template-columns: 1fr;
            }
        }

        .cta-banner {
            background: linear-gradient(135deg, #c8a96e, #a07840);
            color: #fff;
            text-align: center;
            padding: 3.5rem 2rem;
        }
        .cta-banner h2 { font-size: 1.9rem; margin-bottom: 0.75rem; }
        .cta-banner p { margin-bottom: 1.5rem; opacity: 0.9; }
        .btn-white {
            background: #fff;
            color: #a07840;
            font-weight: 700;
            padding: 0.8rem 2rem;
            border-radius: 6px;
            text-decoration: none;
            display: inline-block;
            margin: 0.3rem;
            transition: opacity 0.2s;
        }
        .btn-white:hover { opacity: 0.9; }
        .btn-outline-white {
            border: 2px solid #fff;
            color: #fff;
            font-weight: 600;
            padding: 0.8rem 2rem;
            border-radius: 6px;
            text-decoration: none;
            display: inline-block;
            margin: 0.3rem;
            transition: background 0.2s;
        }
        .btn-outline-white:hover { background: rgba(255,255,255,0.15); }

        @media (max-width: 700px) {
            .about-grid { grid-template-columns: 1fr; }
            .about-grid.reverse { direction: ltr; }
        }
    </style>
</head>
<body class="user-layout">

<jsp:include page="/WEB-INF/includes/user-header.jsp"/>

<%-- ── Hero ──────────────────────────────────────────────────────── --%>
<section class="about-hero">
    <p class="section-label">Our Story</p>
    <h1>Crafting Spaces That Feel Like Home</h1>
    <p>NestWood was born from a simple belief — that beautiful, quality furniture should be accessible to every Nepali home. We blend traditional craftsmanship with modern design.</p>
</section>

<%-- ── Story Section ───────────────────────────────────────────── --%>
<section class="about-section">
    <div class="about-grid">
        <div class="about-img-block"><i class="fas fa-tree"></i></div>
        <div class="about-text">
            <h2>Who We <span>Are</span></h2>
            <p>Founded in 2020 in Kathmandu, NestWood started as a small workshop with a big dream — to bring world-class furniture craftsmanship to Nepal. What began as a family workshop has grown into one of the region's most trusted online furniture stores.</p>
            <p>Every piece in our collection is handpicked or handcrafted by skilled artisans who take pride in their work. From solid sheesham wood beds to elegant dining sets, each item tells a story of dedication and care.</p>
        </div>
    </div>
</section>

<%-- ── Values ───────────────────────────────────────────────────── --%>
<section class="values-section">
    <div class="values-inner">
        <h2>What Drives Us</h2>
        <p class="sub">Our core values shape every decision we make.</p>
        <div class="values-grid">
            <div class="value-card">
                <div class="icon"><i class="fas fa-trophy"></i></div>
                <h3>Quality First</h3>
                <p>We source only premium materials. Every joint, finish, and fabric is inspected before it reaches your home.</p>
            </div>
            <div class="value-card">
                <div class="icon"><i class="fas fa-handshake"></i></div>
                <h3>Honest Pricing</h3>
                <p>No hidden charges. No middlemen. We work directly with craftsmen to offer fair prices to our customers.</p>
            </div>
            <div class="value-card">
                <div class="icon"><i class="fas fa-leaf"></i></div>
                <h3>Sustainability</h3>
                <p>We source wood responsibly, support local artisans, and use eco-friendly finishes wherever possible.</p>
            </div>
            <div class="value-card">
                <div class="icon"><i class="fas fa-comments"></i></div>
                <h3>Customer First</h3>
                <p>Your satisfaction is our measure of success. We stand behind every product we sell with after-sale support.</p>
            </div>
        </div>
    </div>
</section>

<%-- ── Mission ──────────────────────────────────────────────────── --%>
<section class="about-section">
    <div class="about-grid reverse">
        <div class="about-img-block"><i class="fas fa-couch"></i></div>
        <div class="about-text">
            <h2>Our <span>Mission</span></h2>
            <p>To make every Nepali household a place of comfort, beauty, and pride — through furniture that lasts generations and service that earns lifelong trust.</p>
            <p>We believe your home is your sanctuary. NestWood exists to help you build it, one thoughtfully crafted piece at a time.</p>
            <a href="${pageContext.request.contextPath}/browse" class="btn btn-primary" style="margin-top:1rem">Explore Our Collection</a>
        </div>
    </div>
</section>

<%-- ── Team ────────────────────────────────────────────────────── --%>
<section class="team-section">
    <h2>Meet the Team</h2>
    <p class="sub">The people behind your perfect living space.</p>
    
    <div class="team-grid">
        <div class="team-card">
            <div class="team-avatar">
                <img src="${pageContext.request.contextPath}/assets/images/team/mayank.jpg?v=2" 
                     alt="Mayank Gurung"
                     onerror="this.src='https://ui-avatars.com/api/?name=Mayank+Gurung&size=400&background=c8a96e&color=fff&bold=true'">
            </div>
            <div class="team-info">
                <h4>Mayank Gurung</h4>
                <span class="role">Founder & CEO</span>
                <p class="description">Visionary leader with 10+ years in furniture design and e-commerce.</p>
            </div>
        </div>
        <div class="team-card">
            <div class="team-avatar">
                <img src="${pageContext.request.contextPath}/assets/images/team/krish.jpg?v=2" 
                     alt="Krish Shahi"
                     onerror="this.src='https://ui-avatars.com/api/?name=Krish+Shahi&size=400&background=a07840&color=fff&bold=true'">
            </div>
            <div class="team-info">
                <h4>Krish Shahi</h4>
                <span class="role">Head of Design</span>
                <p class="description">Award-winning designer blending modern aesthetics with traditional craftsmanship.</p>
            </div>
        </div>
        <div class="team-card">
            <div class="team-avatar">
                <img src="${pageContext.request.contextPath}/assets/images/team/abinash.jpg?v=2" 
                     alt="Abinash Lamgade"
                     onerror="this.src='https://ui-avatars.com/api/?name=Abinash+Lamgade&size=400&background=8A6840&color=fff&bold=true'">
            </div>
            <div class="team-info">
                <h4>Abinash Lamgade</h4>
                <span class="role">Master Craftsman</span>
                <p class="description">Third-generation woodworker ensuring every piece meets our quality standards.</p>
            </div>
        </div>
        <div class="team-card">
            <div class="team-avatar">
                <img src="${pageContext.request.contextPath}/assets/images/team/sarthak.jpg?v=2" 
                     alt="Sarthak Ghimire"
                     onerror="this.src='https://ui-avatars.com/api/?name=Sarthak+Ghimire&size=400&background=B8933A&color=fff&bold=true'">
            </div>
            <div class="team-info">
                <h4>Sarthak Ghimire</h4>
                <span class="role">Marketing Head</span>
                <p class="description">Strategic marketer connecting our brand with customers across Nepal.</p>
            </div>
        </div>
        <div class="team-card">
            <div class="team-avatar">
                <img src="${pageContext.request.contextPath}/assets/images/team/madan.jpg?v=2" 
                     alt="Madan Sapkota"
                     onerror="this.src='https://ui-avatars.com/api/?name=Madan+Sapkota&size=400&background=D4AF70&color=fff&bold=true'">
            </div>
            <div class="team-info">
                <h4>Madan Sapkota</h4>
                <span class="role">Tech Lead</span>
                <p class="description">Tech innovator building seamless digital experiences for our customers.</p>
            </div>
        </div>
    </div>
</section>

<%-- ── CTA Banner ───────────────────────────────────────────────── --%>
<section class="cta-banner">
    <h2>Ready to Transform Your Home?</h2>
    <p>Browse our full collection and find furniture that speaks to you.</p>
    <a href="${pageContext.request.contextPath}/browse" class="btn-white">Shop Now</a>
    <a href="${pageContext.request.contextPath}/contact" class="btn-outline-white">Get in Touch</a>
</section>

<script src="${pageContext.request.contextPath}/assets/js/script.js"></script>
</body>
</html>
