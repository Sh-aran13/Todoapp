<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.util.*, model.Task" %>
<%
  Integer uid = (Integer) session.getAttribute("userId");
  if (uid == null) { response.sendRedirect(request.getContextPath()+"/jsp/login.jsp"); return; }
  List<Task> tasks = (List<Task>) request.getAttribute("tasks");

  // Sort the tasks list in ascending order by title
  if (tasks != null && !tasks.isEmpty()) {
    Collections.sort(tasks, new Comparator<Task>() {
      @Override
      public int compare(Task t1, Task t2) {
        return t1.getTitle().compareTo(t2.getTitle());
      }
    });
  }
%>
<!doctype html>
<html>
<head>
  <title>Tasks</title>
  <link rel="stylesheet" href="../assets/styles.css">
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
  <link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@500;700&display=swap" rel="stylesheet">
  <style>
    /* Animated Background */
    body {
      margin: 0;
      font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
      min-height: 100vh;
      display: flex;
      justify-content: center;
      align-items: flex-start;
      background: linear-gradient(270deg, #e0c3fc, #8ec5fc, #a1c4fd);
      background-size: 400% 400%;
      animation: GradientBackground 15s ease infinite;
      color: #333;
      overflow-x: hidden;
      position: relative;
    }

    @keyframes GradientBackground {
      0% { background-position: 0% 50%; }
      50% { background-position: 100% 50%; }
      100% { background-position: 0% 50%; }
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
      width: 0;
      position: fixed;
      z-index: 50;
      top: 0;
      left: 0;
      background-color: rgba(25, 25, 50, 0.95);
      overflow-x: hidden;
      transition: 0.5s;
      padding-top: 60px;
      box-shadow: 2px 0 10px rgba(0,0,0,0.1);
    }

    .sidebar a {
      padding: 15px 25px 15px 32px;
      text-decoration: none;
      font-size: 20px;
      color: #ccc;
      display: block;
      transition: 0.3s;
      font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
    }

    .sidebar a:hover {
      background: rgba(40, 40, 80, 0.5);
      color: #64ffda;
    }

    .sidebar .closebtn {
      position: absolute;
      top: 0;
      right: 25px;
      font-size: 36px;
      margin-left: 50px;
      color: #fff;
    }
    
    .sidebar-header {
      padding: 20px;
      text-align: center;
      font-size: 24px;
      color: #64ffda;
      border-bottom: 1px solid rgba(100, 255, 218, 0.2);
      margin-bottom: 20px;
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

    .header {
      text-align: center;
      color: #4a4a4a;
      margin-bottom: 30px;
      animation: fadeSlideIn 1s ease forwards;
      opacity: 0;
    }

    .header h2 {
      font-family: 'Montserrat', sans-serif;
      font-weight: 700;
      font-size: 2.5em;
      text-shadow: 0 0 5px rgba(0,0,0,0.2), 0 0 10px rgba(0,0,0,0.1);
    }

    @keyframes fadeSlideIn {
      from { opacity: 0; transform: translateY(-20px); }
      to { opacity: 1; transform: translateY(0); }
    }

    .header .links {
      display: none;
    }

    /* Dark Glass Neon Effect on Card */
    .card {
      background: rgba(25, 25, 50, 0.5);
      border-radius: 20px;
      border: 1px solid rgba(255, 255, 255, 0.1);
      box-shadow: 0 0 20px #8ec5fc, 0 0 40px #e0c3fc;
      backdrop-filter: blur(10px);
      -webkit-backdrop-filter: blur(10px);
      padding: 30px;
      width: 100%;
      max-width: 800px;
      animation: cardSlideFadeIn 1.5s ease forwards;
      opacity: 0;
      transform: translateY(50px);
      color: #fff;
    }

    @keyframes cardSlideFadeIn {
        to {
            opacity: 1;
            transform: translateY(0);
        }
    }

    /* Neon Glass Table */
    .table {
      width: 100%;
      border-collapse: separate;
      border-spacing: 0 10px;
      text-align: left;
    }

    .table thead th {
      padding: 15px;
      background-color: rgba(255, 255, 255, 0.1);
      border-bottom: 2px solid rgba(255, 255, 255, 0.2);
      box-shadow: inset 0 -3px 5px rgba(224, 195, 252, 0.3);
      color: #fff;
    }

    .table tbody tr {
      background-color: rgba(0, 0, 0, 0.2);
      transition: all 0.3s ease;
      box-shadow: 0 0 10px rgba(142, 197, 252, 0.2), 0 0 20px rgba(142, 197, 252, 0.1);
      border-radius: 10px;
      animation: rowFadeIn 1.5s ease forwards;
      opacity: 0;
    }
    
    .table tbody tr:hover {
      transform: translateY(-5px);
      box-shadow: 0 0 15px rgba(142, 197, 252, 0.4), 0 0 30px rgba(142, 197, 252, 0.2);
    }

    @keyframes rowFadeIn {
      from { opacity: 0; transform: translateX(-50px); }
      to { opacity: 1; transform: translateX(0); }
    }
    
    .table tbody tr:nth-child(1) { animation-delay: 0.2s; }
    .table tbody tr:nth-child(2) { animation-delay: 0.4s; }
    .table tbody tr:nth-child(3) { animation-delay: 0.6s; }
    .table tbody tr:nth-child(4) { animation-delay: 0.8s; }
    .table tbody tr:nth-child(5) { animation-delay: 1.0s; }
    
    .table td, .table th {
        padding: 15px;
        border: none;
        color: #fff;
    }

    /* Action Buttons */
    .actions button {
      padding: 8px 15px;
      border: 1px solid;
      border-radius: 8px;
      color: #fff;
      cursor: pointer;
      position: relative;
      overflow: hidden;
      transition: transform 0.2s ease, box-shadow 0.2s ease, border-color 0.3s ease;
      background: transparent;
      backdrop-filter: blur(5px);
      -webkit-backdrop-filter: blur(5px);
    }

    .actions button:hover {
      transform: translateY(-2px);
      box-shadow: 0 0 10px, 0 0 20px, 0 0 30px;
    }

    .actions button[type="submit"] {
      border-color: #ff6b6b;
      box-shadow: 0 0 10px #ff6b6b;
    }

    .actions button[type="submit"]:hover {
      box-shadow: 0 0 15px #ff6b6b, 0 0 30px #ff6b6b;
    }
    
    .actions form:nth-child(1) button {
      border-color: #64ffda;
      box-shadow: 0 0 10px #64ffda;
    }
    
    .actions form:nth-child(1) button:hover {
      box-shadow: 0 0 15px #64ffda, 0 0 30px #64ffda;
    }

    /* Add Task Button */
    .add-task-btn {
      display: block;
      width: 200px;
      padding: 15px;
      margin: 20px auto;
      text-align: center;
      border: 2px solid #a1c4fd;
      border-radius: 50px;
      color: #fff;
      font-size: 1em;
      text-decoration: none;
      background: linear-gradient(45deg, rgba(161, 196, 253, 0.2), rgba(161, 196, 253, 0.1));
      backdrop-filter: blur(5px);
      transition: all 0.3s ease;
      box-shadow: 0 0 15px rgba(161, 196, 253, 0.4);
    }

    .add-task-btn:hover {
      transform: translateY(-5px);
      box-shadow: 0 0 20px rgba(161, 196, 253, 0.6), 0 0 40px rgba(161, 196, 253, 0.4);
    }

    @media (max-width: 768px) {
      .card {
        padding: 15px;
        margin-top: 20px;
      }
      .table {
        font-size: 14px;
      }
      .table td, .table th {
        padding: 10px;
      }
    }
  </style>
</head>
<body>

<div id="mySidebar" class="sidebar">
  <div class="sidebar-header">
    ToDoApp
  </div>
  <a href="javascript:void(0)" class="closebtn" onclick="closeNav()">&times;</a>
  <a href="jsp/home.jsp">Home</a>
  <a href="<%=request.getContextPath()%>/logout">Logout</a>
</div>

<div class="sidebar-toggle" onclick="openNav()">
    <i class="fas fa-bars"></i>
</div>

<div class="container">
  <div class="header">
    <h2>Your Tasks</h2>
  </div>

  <div class="card">
    <a href="jsp/home.jsp" class="add-task-btn">Add Task</a>
    <table class="table">
      <thead>
        <tr><th>Title</th><th>Description</th><th>Status</th><th>Actions</th></tr>
      </thead>
      <tbody>
      <%
        if (tasks==null || tasks.isEmpty()) {
      %>
        <tr><td colspan="5">No tasks yet.</td></tr>
      <%
        } else {
          for (Task t : tasks) {
      %>
        <tr>
          <td><%= t.getTitle() %></td>
          <td><%= t.getDescription()==null?"":t.getDescription() %></td>
          <td><%= t.getStatus() %></td>
          <td class="actions">
            <form action="<%=request.getContextPath()%>/tasks/edit" method="get" style="display:inline">
              <input type="hidden" name="id" value="<%= t.getId() %>">
              <button type="submit">Edit</button>
            </form>
            <form action="<%=request.getContextPath()%>/tasks/delete" method="post" style="display:inline"
                  onsubmit="return confirm('Delete this task?');">
              <input type="hidden" name="id" value="<%= t.getId() %>">
              <button type="submit">Delete</button>
            </form>
          </td>
        </tr>
      <%
          }
        }
      %>
      </tbody>
    </table>
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