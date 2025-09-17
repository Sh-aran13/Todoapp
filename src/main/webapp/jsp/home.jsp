<%@ page contentType="text/html;charset=UTF-8" %>
<%
  Integer uid = (Integer) session.getAttribute("userId");
  if (uid == null) { response.sendRedirect(request.getContextPath()+"/jsp/login.jsp"); return; }
%>
<!doctype html>
<html>
<head>
  <title>Home</title>
  <link rel="stylesheet" href="../assets/styles.css">
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
  <style>
    /* ===== Body & background ===== */
    body {
      margin: 0;
      font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
      min-height: 100vh;
      display: flex;
      justify-content: center;
      align-items: flex-start;
      background: linear-gradient(135deg, #a1c4fd, #c2e9fb);
      overflow-x: hidden;
      position: relative;
    }

    /* Animated floating shapes */
    body::before, body::after {
      content: '';
      position: absolute;
      border-radius: 50%;
      background: rgba(255,255,255,0.1);
      animation: float 10s linear infinite;
      z-index: 0;
    }
    body::before { width: 300px; height: 300px; top: -100px; left: -100px; }
    body::after { width: 400px; height: 400px; bottom: -150px; right: -150px; }

    @keyframes float {
      0% { transform: translateY(0) rotate(0deg); }
      50% { transform: translateY(-50px) rotate(180deg); }
      100% { transform: translateY(0) rotate(360deg); }
    }

    .container {
      position: relative;
      z-index: 1;
      width: 100%;
      max-width: 900px;
      margin-top: 50px;
      display: flex;
      flex-direction: column;
      align-items: center;
    }

    /* Header */
    .header {
      text-align: center;
      color: #fff;
      margin-bottom: 30px;
      animation: fadeSlideIn 1s ease forwards;
      opacity: 0;
      position: relative;
      width: 100%;
    }

    .header h2 {
      font-size: 28px;
      color: #404001;
    }

    .header .badge {
      background: rgba(255,255,255,0.4);
      padding: 5px 12px;
      border-radius: 12px;
      margin-left: 8px;
      display: inline-block;
      animation: badgePop 0.6s ease;
      color: #DE5B96;
      box-shadow: 0 4px 15px rgba(0,0,0,0.1);
    }

    @keyframes fadeSlideIn {
      from { opacity: 0; transform: translateY(-20px); }
      to { opacity: 1; transform: translateY(0); }
    }

    @keyframes badgePop {
      0% { transform: scale(0); }
      70% { transform: scale(1.2); }
      100% { transform: scale(1); }
    }

    .header .links {
        display: none; /* Hide the original links */
    }

    /* Card */
    .card {
      background: #fff;
      border-radius: 20px;
      box-shadow: 0 10px 30px rgba(0,0,0,0.2);
      padding: 30px;
      width: 100%;
      max-width: 500px;
      animation: slideFadeIn 1s ease forwards;
      opacity: 0;
    }

    @keyframes slideFadeIn {
      from { opacity: 0; transform: translateY(50px); }
      to { opacity: 1; transform: translateY(0); }
    }

    /* Form styling */
    label {
      margin-top: 10px;
      margin-bottom: 5px;
      font-size: 14px;
      color: #333;
    }

    input, textarea {
      width: 100%;
      padding: 10px;
      border-radius: 10px;
      border: 1px solid #ccc;
      outline: none;
      transition: all 0.3s ease;
    }

    input:focus, textarea:focus {
      border-color: #a1c4fd;
      box-shadow: 0 0 10px rgba(161,196,253,0.5);
      transform: scale(1.02);
    }

    textarea { resize: none; }

    /* Button */
    button {
      margin-top: 20px;
      padding: 12px;
      background: linear-gradient(135deg, #a1c4fd, #c2e9fb);
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
      background: rgba(255,255,255,0.2);
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

    /* Sidebar Styles */
    .sidebar-toggle {
        position: absolute;
        top: 20px;
        left: 20px;
        color: #fff;
        font-size: 24px;
        cursor: pointer;
        z-index: 100;
        transition: transform 0.3s ease;
    }

    .sidebar-toggle:hover {
        transform: scale(1.1);
    }
    
    .sidebar {
      height: 100%;
      width: 0; /* Hidden by default */
      position: fixed;
      z-index: 50;
      top: 0;
      left: 0;
      background-color: rgba(255, 255, 255, 0.95);
      overflow-x: hidden;
      transition: 0.5s;
      padding-top: 60px;
      box-shadow: 2px 0 10px rgba(0,0,0,0.1);
    }

    .sidebar a {
      padding: 15px 25px 15px 32px;
      text-decoration: none;
      font-size: 20px;
      color: #333;
      display: block;
      transition: 0.3s;
      font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
    }

    .sidebar a:hover {
      color: #475a5c;
      background: #f7d4d4;
    }

    .sidebar .closebtn {
      position: absolute;
      top: 0;
      right: 25px;
      font-size: 36px;
      margin-left: 50px;
    }
    
    .sidebar-header {
      padding: 20px;
      text-align: center;
      font-size: 24px;
      color: #a1c4fd;
      border-bottom: 1px solid #eee;
      margin-bottom: 20px;
    }
  </style>
</head>
<body>

<div id="mySidebar" class="sidebar">
  <div class="sidebar-header">To do App
  </div>
  <a href="javascript:void(0)" class="closebtn" onclick="closeNav()">&times;</a>
  <a href="<%=request.getContextPath()%>/jsp/home.jsp">Home</a>
  <a href="<%=request.getContextPath()%>/tasks">View Tasks</a>
  <a href="<%=request.getContextPath()%>/logout">Logout</a>
</div>

<div class="sidebar-toggle" onclick="openNav()">
    <i class="fas fa-bars"></i>
</div>

<div class="container">
  <div class="header">
    <h2>Hi, <span class="badge"><%= session.getAttribute("userName") %></span></h2>
    <div class="links">
      <a href="<%=request.getContextPath()%>/tasks">View Tasks</a> &nbsp;|&nbsp;
      <a href="<%=request.getContextPath()%>/logout">Logout</a>
    </div>
  </div>

  <div class="card">
    <h3>Add Task</h3>
    <form action="<%=request.getContextPath()%>/tasks/add" method="post">
      <label>Title</label>
      <input type="text" name="title" required>
      <label>Description</label>
      <textarea name="description" rows="3"></textarea>
      <button type="submit">Add</button>
    </form>
  </div>
</div>

<script>
function openNav() {
  document.getElementById("mySidebar").style.width = "250px";
}

function closeNav() {
  document.getElementById("mySidebar").style.width = "0";
}
</script>

</body>
</html>