<%@ page contentType="text/html;charset=UTF-8" %>
<!doctype html>
<html>
<head>
  <title>Login</title>
  <link rel="stylesheet" href="../assets/styles.css">
  <style>
    body {
      margin: 0;
      font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
      height: 100vh;
      display: flex;
      align-items: center;
      justify-content: center;
      overflow: hidden;

      /* New Animated Background */
      background: radial-gradient(circle at 50% 50%, #667eea, #764ba2, #9452b4, #b062c3);
      background-size: 200% 200%;
      animation: pulse-gradient 20s ease-in-out infinite alternate;
    }

    /* Keyframe animation for the new pulsing radial gradient */
    @keyframes pulse-gradient {
      0% {
        background-position: 0% 0%;
      }
      100% {
        background-position: 100% 100%;
      }
    }

    .flip-container {
      perspective: 1000px;
      width: 350px;
      height: 500px;
    }
    
    .flipper {
      position: relative;
      width: 100%;
      height: 100%;
      transition: transform 1s cubic-bezier(0.68, -0.55, 0.27, 1.55);
      transform-style: preserve-3d;
    }
    
    .flip-container.flipped .flipper {
      transform: rotateY(180deg);
      animation: flip-in 0.8s ease-out;
    }
    
    .front, .back {
      position: absolute;
      top: 0;
      left: 0;
      width: 100%;
      height: 100%;
      backface-visibility: hidden;
      display: flex;
      align-items: center;
      justify-content: center;
    }
    
    .back {
      transform: rotateY(180deg);
    }
    
    @keyframes flip-in {
      0% { transform: rotateY(0deg) scale(0.9); }
      50% { transform: rotateY(90deg) scale(1.1); }
      100% { transform: rotateY(180deg) scale(1); }
    }
    
    .card {
      background: #fff;
      border-radius: 20px;
      box-shadow: 0 8px 25px rgba(0, 0, 0, 0.2);
      padding: 40px;
      width: 350px;
      animation: slideFadeIn 1s ease forwards;
      opacity: 0;
    }

    @keyframes slideFadeIn {
      from {
        opacity: 0;
        transform: translateY(50px);
      }
      to {
        opacity: 1;
        transform: translateY(0);
      }
    }

    .header {
      text-align: center;
      margin-bottom: 20px;
    }

    .header h2 {
      margin: 0;
      font-size: 24px;
      color: #333;
      animation: fadeIn 1.2s ease-in-out;
    }

    .header a {
      display: block;
      margin-top: 5px;
      font-size: 14px;
      text-decoration: none;
      color: #667eea;
      transition: color 0.3s ease;
    }

    .header a:hover {
      color: #764ba2;
    }

    form {
      display: flex;
      flex-direction: column;
    }

    label {
      margin-top: 10px;
      margin-bottom: 5px;
      font-size: 14px;
      color: #444;
    }

    input {
      padding: 10px;
      border-radius: 10px;
      border: 1px solid #ccc;
      outline: none;
      transition: all 0.3s ease;
    }

    input:focus {
      border-color: #667eea;
      box-shadow: 0 0 8px rgba(102, 126, 234, 0.6);
      transform: scale(1.02);
    }

    button {
      margin-top: 20px;
      padding: 12px;
      background: linear-gradient(135deg, #667eea, #764ba2);
      border: none;
      border-radius: 10px;
      color: #fff;
      font-size: 16px;
      cursor: pointer;
      position: relative;
      overflow: hidden;
      transition: transform 0.2s ease;
    }

    button:hover {
      transform: scale(1.05);
    }

    button::after {
      content: "";
      position: absolute;
      width: 200%;
      height: 200%;
      background: rgba(255, 255, 255, 0.2);
      top: -50%;
      left: -50%;
      transform: scale(0);
      border-radius: 50%;
      transition: transform 0.5s ease;
    }

    button:active::after {
      transform: scale(1);
      transition: transform 0s;
    }

    p {
      margin-top: 15px;
      text-align: center;
      animation: fadeIn 1s ease;
    }

    @keyframes fadeIn {
      from { opacity: 0; }
      to { opacity: 1; }
    }
  </style>
</head>
<body>
<div class="flip-container" id="flip-card">
  <div class="flipper">
    
    <div class="front">
      <div class="card">
        <div class="header">
          <h2>Welcome back</h2>
          <a href="jsp/login.jsp" onclick="flipCard(); return false;">Need an account?</a>
        </div>
        <form action="<%=request.getContextPath()%>/login" method="post">
          <label>Email</label>
          <input type="email" name="email" required>
          <label>Password</label>
          <input type="password" name="password" required>
          <button type="submit">Login</button>
        </form>
        <p style="color:#ff4c4c">
          <%= (request.getAttribute("error")==null?"":request.getAttribute("error")) %>
        </p>
        <p style="color:#28c76f">
          <%= (request.getAttribute("msg")==null?"":request.getAttribute("msg")) %>
        </p>
      </div>
    </div>
    
    <div class="back">
      <div class="card">
        <div class="header">
          <h2>Create an account</h2>
          <a href="jsp/register.jsp" onclick="flipCard(); return false;">Already have an account?</a>
        </div>
        <form action="<%=request.getContextPath()%>/register" method="post">
          <label>Name</label>
          <input type="text" name="name" required>
          <label>Email</label>
          <input type="email" name="email" required>
          <label>Password</label>
          <input type="password" name="password" required>
          <button type="submit">Register</button>
        </form>
      </div>
    </div>
    
  </div>
</div>

<script>
function flipCard() {
  const card = document.getElementById('flip-card');
  card.classList.toggle('flipped');
}
</script>

</body>
</html>