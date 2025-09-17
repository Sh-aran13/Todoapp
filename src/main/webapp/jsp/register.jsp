<%@ page contentType="text/html;charset=UTF-8" %>
<!doctype html>
<html>
<head>
  <title>Register</title>
  <link rel="stylesheet" href="../assets/styles.css">
  <style>
    /* Unique Background Animation */
    body {
      margin: 0;
      font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
      height: 100vh;
      display: flex;
      align-items: center;
      justify-content: center;
      overflow: hidden;
      background: linear-gradient(270deg, #ff7e5f, #feb47b, #c2e9fb, #a1c4fd);
      background-size: 800% 800%;
      animation: GradientAnimation 25s ease infinite;
    }

    @keyframes GradientAnimation {
      0% { background-position: 0% 50%; }
      50% { background-position: 100% 50%; }
      100% { background-position: 0% 50%; }
    }

    /* Floating Icons Animation */
    .icon-container {
      position: absolute;
      top: 0;
      left: 0;
      width: 100%;
      height: 100%;
      pointer-events: none;
      z-index: 0;
    }
    .icon-container .icon {
      position: absolute;
      display: block;
      list-style: none;
      width: 20px;
      height: 20px;
      background: rgba(255, 255, 255, 0.2);
      animation: AnimateIcons 25s linear infinite;
      bottom: -150px;
    }
    .icon-container .icon:nth-child(1) { left: 25%; width: 80px; height: 80px; animation-delay: 0s; }
    .icon-container .icon:nth-child(2) { left: 10%; width: 20px; height: 20px; animation-delay: 2s; animation-duration: 12s; }
    .icon-container .icon:nth-child(3) { left: 70%; width: 20px; height: 20px; animation-delay: 4s; }
    .icon-container .icon:nth-child(4) { left: 40%; width: 60px; height: 60px; animation-delay: 0s; animation-duration: 18s; }
    .icon-container .icon:nth-child(5) { left: 65%; width: 20px; height: 20px; animation-delay: 0s; }
    .icon-container .icon:nth-child(6) { left: 75%; width: 110px; height: 110px; animation-delay: 3s; }
    .icon-container .icon:nth-child(7) { left: 35%; width: 150px; height: 150px; animation-delay: 7s; }
    .icon-container .icon:nth-child(8) { left: 50%; width: 25px; height: 25px; animation-delay: 15s; animation-duration: 45s; }
    .icon-container .icon:nth-child(9) { left: 20%; width: 15px; height: 15px; animation-delay: 2s; animation-duration: 35s; }
    .icon-container .icon:nth-child(10) { left: 85%; width: 150px; height: 150px; animation-delay: 0s; animation-duration: 11s; }

    @keyframes AnimateIcons {
      0% { transform: translateY(0) rotate(0deg); opacity: 1; border-radius: 0; }
      100% { transform: translateY(-1000px) rotate(720deg); opacity: 0; border-radius: 50%; }
    }

    .container {
      position: relative;
      z-index: 1; /* Ensure content is above background */
      display: flex;
      align-items: center;
      justify-content: center;
      width: 100%;
      height: 100%;
    }

    /* Card Entry Animation */
    .card {
      background: rgba(255, 255, 255, 0.9);
      border-radius: 20px;
      box-shadow: 0 8px 30px rgba(0, 0, 0, 0.2);
      padding: 40px;
      width: 350px;
      animation: cardSlideIn 1s cubic-bezier(0.25, 0.46, 0.45, 0.94) forwards;
      opacity: 0;
      transform: translateY(50px);
    }

    @keyframes cardSlideIn {
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
      padding: 12px;
      border-radius: 10px;
      border: 1px solid #ccc;
      outline: none;
      transition: all 0.3s ease;
      font-size: 16px;
    }

    input:focus {
      border-color: #667eea;
      box-shadow: 0 0 12px rgba(102, 126, 234, 0.5);
      transform: scale(1.02);
    }

    button {
      margin-top: 25px;
      padding: 12px;
      background: linear-gradient(135deg, #667eea, #764ba2);
      border: none;
      border-radius: 10px;
      color: #fff;
      font-size: 16px;
      cursor: pointer;
      position: relative;
      overflow: hidden;
      transition: transform 0.2s ease, box-shadow 0.2s ease;
    }

    button:hover {
      transform: scale(1.05);
      box-shadow: 0 5px 15px rgba(0, 0, 0, 0.2);
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

    /* New Footer Styling */
    .footer {
      margin-top: 20px;
      text-align: center;
    }
    .footer a {
      color: #667eea;
      text-decoration: none;
      font-weight: bold;
      transition: color 0.3s ease;
    }
    .footer a:hover {
      color: #764ba2;
      text-decoration: underline;
    }
  </style>
</head>
<body>

<div class="icon-container">
  <li class="icon"></li>
  <li class="icon"></li>
  <li class="icon"></li>
  <li class="icon"></li>
  <li class="icon"></li>
  <li class="icon"></li>
  <li class="icon"></li>
  <li class="icon"></li>
  <li class="icon"></li>
  <li class="icon"></li>
</div>

<div class="container">
  <div class="card">
    <div class="header">
      <h2>Create account</h2>
    </div>
    <form action="<%=request.getContextPath()%>/register" method="post">
      <label>Name</label>
      <input type="text" name="name" required>
      <label>Email</label>
      <input type="email" name="email" required>
      <label>Password</label>
      <input type="password" name="password" required minlength="4">
      <button type="submit">Register</button>
    </form>
    <div class="footer">
      <a href="login.jsp">Already have one?</a>
    </div>
    <p style="color:#ff9e9e">
      <%= (request.getAttribute("error")==null?"":request.getAttribute("error")) %>
    </p>
  </div>
</div>
</body>
</html>