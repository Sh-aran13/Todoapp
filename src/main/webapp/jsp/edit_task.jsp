<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="model.Task" %>
<%
  Integer uid = (Integer) session.getAttribute("userId");
  if (uid == null) { response.sendRedirect(request.getContextPath()+"/jsp/login.jsp"); return; }
  Task t = (Task) request.getAttribute("task");
  if (t == null) { response.sendRedirect(request.getContextPath()+"/tasks"); return; }
%>
<!doctype html>
<html>
<head>
  <title>Edit Task</title>
  <link rel="stylesheet" href="../assets/styles.css">
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
  <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600;700&display=swap" rel="stylesheet">
  <style>
    /* Background Gradient Waves */
    body {
      margin: 0;
      font-family: 'Poppins', sans-serif; /* New Font Style */
      min-height: 100vh;
      display: flex;
      justify-content: center;
      align-items: center;
      background: linear-gradient(-45deg, #1e3c72, #2a5298, #0f2027, #203a43);
      background-size: 400% 400%;
      animation: gradientShift 12s ease infinite;
      color: #fff;
    }

    @keyframes gradientShift {
      0% { background-position: 0% 50%; }
      50% { background-position: 100% 50%; }
      100% { background-position: 0% 50%; }
    }

    .container {
      width: 90%;
      max-width: 600px;
      text-align: center;
      animation: fadeIn 1.2s ease-in-out;
    }

    @keyframes fadeIn {
      from { opacity: 0; transform: translateY(20px); }
      to { opacity: 1; transform: translateY(0); }
    }

    .header h2 {
      font-size: 2.5em;
      font-weight: 700;
      margin-bottom: 15px;
      text-shadow: 0 0 10px rgba(255, 255, 255, 0.7);
    }

    .header a {
      color: #00d4ff;
      text-decoration: none;
      font-weight: bold;
      transition: 0.3s;
    }
    .header a:hover {
      color: #fff;
      text-shadow: 0 0 12px #00d4ff;
    }

    .card {
      background: rgba(255, 255, 255, 0.08);
      border-radius: 20px;
      padding: 35px;
      backdrop-filter: blur(12px);
      border: 1px solid rgba(255, 255, 255, 0.15);
      box-shadow: 0 10px 25px rgba(0,0,0,0.4);
      animation: floatUp 6s ease-in-out infinite alternate;
    }

    @keyframes floatUp {
      from { transform: translateY(0); }
      to { transform: translateY(-12px); }
    }

    .card form {
      display: flex;
      flex-direction: column;
      gap: 15px;
    }

    .card label {
      font-weight: 600;
      font-size: 1.05em;
      font-family:Cursive;
      text-align: left;
    }

    .card input[type="text"],
    .card textarea,
    .card select {
      width: 100%;
      padding: 12px;
      border-radius: 10px;
      border: none;
      background: rgba(255,255,255,0.12);
      color: #fff;
      font-size: 16px;
      outline: none;
      transition: 0.3s;
    }
    .card input:focus,
    .card textarea:focus,
    .card select:focus {
      border: 1px solid #00d4ff;
      box-shadow: 0 0 12px #00d4ff;
    }

    .card button {
      align-self: center;
      margin-top: 20px;
      padding: 12px 30px;
      border-radius: 50px;
      border: none;
      background: linear-gradient(45deg, #00d4ff, #64ffda);
      font-weight: bold;
      color: #0a0a1a;
      font-size: 16px;
      cursor: pointer;
      transition: 0.3s;
    }
    .card button:hover {
      transform: scale(1.08);
      box-shadow: 0 0 15px rgba(0,212,255,0.6);
    }
  </style>
</head>
<body>
<div class="container">
  <div class="header">
    <h2>Edit Task #<%= t.getId() %></h2>
    <a href="<%=request.getContextPath()%>/tasks"><i class="fas fa-arrow-left"></i> Back</a>
  </div>

  <div class="card">
    <form action="<%=request.getContextPath()%>/tasks/edit" method="post">
      <input type="hidden" name="id" value="<%= t.getId() %>">

      <label>Title</label>
      <input type="text" name="title" value="<%= t.getTitle() %>" required>

      <label>Description</label>
      <textarea name="description" rows="3"><%= t.getDescription()==null?"":t.getDescription() %></textarea>

      <label>Status</label>
      <select name="status">
        <option <%= "PENDING".equals(t.getStatus())?"selected":"" %>>PENDING</option>
        <option <%= "DONE".equals(t.getStatus())?"selected":"" %>>DONE</option>
      </select>

      <button type="submit"><i class="fas fa-save"></i> Save</button>
    </form>
  </div>
</div>
</body>
</html>
