<%@ page contentType="text/html;charset=UTF-8" %>
<!doctype html>
<html>
<head>
  <title>Login / Register</title>
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
      height: 550px; /* Increased height to accommodate CAPTCHA */
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
    
    /* --- CAPTCHA Specific Styles --- */
    .captcha-group {
      margin-top: 10px;
      display: flex;
      flex-direction: column;
    }

    .captcha-question {
      display: flex;
      align-items: center;
      margin-bottom: 5px;
    }

    .captcha-question-text {
      padding: 8px 15px;
      background-color: #f0f0f0;
      border: 1px dashed #667eea;
      border-radius: 8px;
      font-size: 18px;
      font-weight: bold;
      letter-spacing: 2px;
      color: #333;
      margin-right: 10px;
      min-width: 100px;
      text-align: center;
    }

    #captcha-error {
        color: #ff4c4c;
        font-size: 12px;
        text-align: left;
        margin-top: 5px;
    }

    /* --- Custom Alert/Toast Styles - MODIFIED FOR TOP CENTER --- */
    #custom-alert {
        position: fixed;
        top: 20px; /* Distance from the top */
        
        /* Centering horizontally: */
        left: 50%;
        transform: translateX(-50%) translateY(-100%); /* Start off-screen above the visible area */

        background-color: #ff4c4c; /* Default: Red background for error */
        color: white;
        padding: 15px 25px;
        border-radius: 10px;
        box-shadow: 0 4px 15px rgba(0, 0, 0, 0.2);
        z-index: 1000;
        opacity: 0;
        visibility: hidden;
        
        /* New transition for smooth slide-down/slide-up effect */
        transition: opacity 0.4s ease-out, transform 0.4s ease-out;
        font-weight: 600;
    }

    #custom-alert.show {
        opacity: 1;
        visibility: visible;
        /* Slide down to the 'top: 20px' position */
        transform: translateX(-50%) translateY(0); 
    }

    /* Success style for the alert */
    #custom-alert.success {
        background-color: #28a745; /* Green background for success */
    }
    
  </style>
</head>
<body>

<div id="custom-alert"></div>
<div class="flip-container" id="flip-card">
  <div class="flipper">
    
    <div class="front">
      <div class="card">
        <div class="header">
          <h2>Welcome back</h2>
          <a href="#" onclick="flipCard(); return false;">Need an account?</a>
        </div>
        <form id="login-form" action="<%=request.getContextPath()%>/login" method="post" onsubmit="return validateCaptcha(event)">
          <label>Email</label>
          <input type="email" name="email" required>
          <label>Password</label>
          <input type="password" name="password" required>
          
          <div class="captcha-group">
            <label>Security Check (Enter the code below)</label>
            <div class="captcha-question">
              <span class="captcha-question-text" id="captcha-display"></span>
              <input type="text" id="captcha-answer" name="captcha-answer" placeholder="Enter the 6 digits" maxlength="6" required>
            </div>
            <p id="captcha-error"></p>
          </div>
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
          <a href="#" onclick="flipCard(); return false;">Already have an account?</a>
        </div>
        <form id="register-form" action="<%=request.getContextPath()%>/register" method="post">
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
let correctCaptchaAnswer = "";
let alertTimeout; // Variable to hold the timeout reference

function generateCaptcha() {
    let captcha = '';
    for (let i = 0; i < 6; i++) {
        captcha += Math.floor(Math.random() * 10).toString();
    }
    correctCaptchaAnswer = captcha;
    const captchaDisplay = document.getElementById('captcha-display');
    captchaDisplay.textContent = captcha;
    document.getElementById('captcha-error').textContent = '';
    document.getElementById('captcha-answer').value = '';
}

/**
 * Shows the custom animated toast message.
 * @param {string} message - The message to display.
 * @param {boolean} isSuccess - True for success (green), false for error (red).
 */
function showCustomAlert(message, isSuccess) {
    const customAlert = document.getElementById('custom-alert');
    
    // 1. Clear any existing timeout and reset classes
    clearTimeout(alertTimeout);
    customAlert.classList.remove('show', 'success');
    
    // 2. Set the message and apply success class if needed
    customAlert.textContent = message;
    if (isSuccess) {
        customAlert.classList.add('success');
    }

    // 3. Make it visible/animate in
    customAlert.classList.add('show');
    
    // 4. Set a timeout to automatically hide the alert after 3 seconds
    alertTimeout = setTimeout(() => {
        customAlert.classList.remove('show');
    }, 3000);
}


function validateCaptcha(event) {
    const userAnswer = document.getElementById('captcha-answer').value;
    const errorElement = document.getElementById('captcha-error');
    const successMessage = 'Security check passed! Logging in...';
    const errorMessage = 'Incorrect security code. Please try again.';

    if (userAnswer === correctCaptchaAnswer) {
        // CAPTCHA CORRECT
        event.preventDefault(); // Stop default submission to display toast
        errorElement.textContent = '';
        
        showCustomAlert(successMessage, true); // Show green success toast

        // Automatically submit the form after the toast starts animating (e.g., 500ms)
        setTimeout(() => {
            document.getElementById('login-form').submit();
        }, 500);
        
        // Return false here because we are handling the submission manually with a delay
        return false; 

    } else {
        // CAPTCHA WRONG
        event.preventDefault(); // Stop form submission
        
        // 1. Display error on page (existing functionality)
        errorElement.textContent = errorMessage;
        
        // 2. SHOW ANIMATED TOAST (Error)
        showCustomAlert(errorMessage, false); 
        
        generateCaptcha(); // Generate a new CAPTCHA immediately
        return false;
    }
}

function flipCard() {
  const card = document.getElementById('flip-card');
  const isFlipped = card.classList.contains('flipped');
  card.classList.toggle('flipped');
  // Generate a new CAPTCHA only when flipping TO the login side (i.e., when isFlipped is true)
  if (isFlipped) {
      setTimeout(generateCaptcha, 500); 
  }
}

window.onload = function() {
    const card = document.getElementById('flip-card');
    // Generate CAPTCHA if the login form (front) is visible on load
    if (card && !card.classList.contains('flipped')) {
        generateCaptcha();
    }
};
</script>
</body>
</html>