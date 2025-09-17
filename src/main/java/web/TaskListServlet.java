package web;

import dao.TaskDAO;
import model.Task;

import javax.servlet.*;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.List;

public class TaskListServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        HttpSession s = req.getSession(false);
        int userId = (Integer) s.getAttribute("userId");
        try {
            List<Task> tasks = new TaskDAO().findByUser(userId);
            req.setAttribute("tasks", tasks);
            req.getRequestDispatcher("/jsp/tasks.jsp").forward(req, resp);
        } catch (Exception e) {
            throw new ServletException(e);
        }
    }
}
