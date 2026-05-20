<%@ page contentType="text/html;charset=UTF-8" isErrorPage="true" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>500 — Server Error | NestWood</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }
        body {
            font-family: 'DM Sans', 'Segoe UI', system-ui, sans-serif;
            background: linear-gradient(135deg, #F5F1E8 0%, #EDE8DF 100%);
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 2rem;
        }
        .error-wrapper {
            text-align: center;
            max-width: 600px;
            width: 100%;
        }
        .error-icon-box {
            background: white;
            border-radius: 24px;
            padding: 3rem 2rem;
            box-shadow: 0 16px 48px rgba(60,40,20,0.12);
            margin-bottom: 2rem;
            border: 1px solid #E4DDD4;
        }
        .error-code {
            font-size: 6rem;
            font-weight: 700;
            color: #C04040;
            line-height: 1;
            margin-bottom: 1.5rem;
        }
        .error-icon {
            font-size: 4rem;
            color: #C04040;
            opacity: 0.7;
        }
        .error-title {
            font-size: 2rem;
            font-weight: 700;
            color: #333;
            margin-bottom: 1rem;
        }
        .error-message {
            color: #8C7B6E;
            font-size: 1rem;
            line-height: 1.7;
            margin-bottom: 2rem;
        }
        .error-buttons {
            display: flex;
            gap: 1rem;
            justify-content: center;
            flex-wrap: wrap;
        }
        .btn {
            display: inline-flex;
            align-items: center;
            gap: 8px;
            padding: 12px 24px;
            border-radius: 8px;
            font-size: 0.9rem;
            font-weight: 600;
            text-decoration: none;
            transition: all 0.3s ease;
            border: 2px solid transparent;
        }
        .btn-primary {
            background: #D4AF37;
            color: white;
            box-shadow: 0 4px 12px rgba(212,175,55,0.3);
        }
        .btn-primary:hover {
            background: #B8933A;
            transform: translateY(-2px);
            box-shadow: 0 6px 16px rgba(212,175,55,0.4);
        }
        .btn-secondary {
            background: white;
            color: #333;
            border-color: #E4DDD4;
        }
        .btn-secondary:hover {
            border-color: #D4AF37;
            color: #D4AF37;
        }
        .error-footer {
            margin-top: 2rem;
            font-size: 0.85rem;
            color: #B8A898;
        }
        .brand {
            display: inline-flex;
            align-items: center;
            gap: 8px;
            font-size: 1.2rem;
            font-weight: 700;
            color: #333;
            text-decoration: none;
            margin-bottom: 2rem;
        }
        .brand i {
            color: #D4AF37;
        }
    </style>
</head>
<body>
    <div class="error-wrapper">
        <a href="${pageContext.request.contextPath}/" class="brand">
            <i class="fas fa-tree"></i> NestWood
        </a>
        
        <div class="error-icon-box">
            <div class="error-code">500</div>
            <div class="error-icon">
                <i class="fas fa-exclamation-triangle"></i>
            </div>
        </div>
        
        <h1 class="error-title">Internal Server Error</h1>
        <p class="error-message">
            Something went wrong on our end. Our team has been notified
            and is working to fix the issue. Please try again in a moment.
        </p>
        
        <div class="error-buttons">
            <a href="${pageContext.request.contextPath}/" class="btn btn-primary">
                <i class="fas fa-home"></i> Back to Home
            </a>
            <a href="javascript:history.back()" class="btn btn-secondary">
                <i class="fas fa-arrow-left"></i> Go Back
            </a>
        </div>
        
        <div class="error-footer">
            Error reference: 500 Internal Server Error
        </div>
    </div>
</body>
</html>
