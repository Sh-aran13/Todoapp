<%@ page contentType="text/html;charset=UTF-8" %>
<!doctype html>
<html>
<head>
    <title>Confirm Logout</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/assets/styles.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <style>
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: radial-gradient(ellipse at bottom, #0d1b2a 0%, #000 100%);
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 100vh;
            margin: 0;
            overflow: hidden;
            position: relative;
        }

        /* Animated Gradient Waves */
        body::before {
            content: "";
            position: absolute;
            top: -50%;
            left: -50%;
            width: 200%;
            height: 200%;
            background: conic-gradient(
                from 180deg,
                rgba(255, 0, 150, 0.2),
                rgba(0, 200, 255, 0.2),
                rgba(0, 255, 200, 0.2),
                rgba(255, 0, 150, 0.2)
            );
            animation: rotateGradient 20s linear infinite;
            filter: blur(120px);
            z-index: 1;
        }

        @keyframes rotateGradient {
            0% { transform: rotate(0deg); }
            100% { transform: rotate(360deg); }
        }

        /* Floating Stars */
        .stars {
            position: absolute;
            width: 2px;
            height: 2px;
            background: white;
            border-radius: 50%;
            box-shadow: 
                50px 100px white,
                200px 300px #9be7ff,
                400px 150px #ffd6ff,
                600px 500px #80ffea,
                800px 200px #f7b2ff,
                1000px 400px #ff9cee;
            animation: twinkle 5s infinite alternate;
            z-index: 2;
        }

        @keyframes twinkle {
            0% { opacity: 0.3; transform: scale(1); }
            100% { opacity: 1; transform: scale(1.3); }
        }

        .confirmation-card {
            background: rgba(255, 255, 255, 0.05);
            padding: 2.5rem;
            border-radius: 20px;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.6);
            backdrop-filter: blur(15px);
            border: 1px solid rgba(255, 255, 255, 0.2);
            text-align: center;
            width: 90%;
            max-width: 420px;
            z-index: 10;
            color: white;
            animation: fadeIn 1.5s ease-in-out;
        }

        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(30px); }
            to { opacity: 1; transform: translateY(0); }
        }

        .confirmation-card h2 {
            margin-top: 0;
            font-size: 1.8rem;
            color: #fff;
            text-shadow: 0 0 15px rgba(0, 200, 255, 0.8);
        }
        .confirmation-card p {
            color: #ddd;
            margin-bottom: 2rem;
            font-size: 1rem;
        }
        .button-group {
            display: flex;
            justify-content: center;
            gap: 20px;
        }
        .button-group a {
            padding: 12px 25px;
            border-radius: 50px;
            text-decoration: none;
            font-weight: bold;
            border: none;
            cursor: pointer;
            transition: all 0.3s ease;
        }
        .button-group .confirm-btn {
            background: linear-gradient(45deg, #ff4e50, #f9d423);
            color: white;
            box-shadow: 0 4px 12px rgba(249, 212, 35, 0.4);
        }
        .button-group .confirm-btn:hover {
            transform: translateY(-3px) scale(1.05);
            box-shadow: 0 6px 20px rgba(249, 212, 35, 0.6);
        }
        .button-group .cancel-btn {
            background: linear-gradient(45deg, #43cea2, #185a9d);
            color: white;
            box-shadow: 0 4px 12px rgba(67, 206, 162, 0.4);
        }
        .button-group .cancel-btn:hover {
            transform: translateY(-3px) scale(1.05);
            box-shadow: 0 6px 20px rgba(67, 206, 162, 0.6);
        }
    </style>
</head>
<body>
    <!-- Floating stars layer -->
    <div class="stars"></div>

    <div class="confirmation-card">
        <h2>Confirm Logout</h2>
        <p>Are you sure you want to log out?</p>
        <div class="button-group">
            <a href="<%= request.getContextPath() %>/logout?confirm=true" class="confirm-btn"><i class="fas fa-sign-out-alt"></i> Yes, Logout</a>
            <a href="javascript:history.back()" class="cancel-btn"><i class="fas fa-arrow-left"></i> No, Go Back</a>
        </div>
    </div>
</body>
</html>
