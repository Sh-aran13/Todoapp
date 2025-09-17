package web;

import dao.TaskDAO;
import model.Task;

import javax.servlet.*;
import javax.servlet.http.*;
import java.io.IOException;

public class EditTaskServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        HttpSession s = req.getSession(false);
        int userId = (Integer) s.getAttribute("userId");
        int id = Integer.parseInt(req.getParameter("id"));

        try {
            Task t = new TaskDAO().findByIdAndUser(id, userId);
            if (t == null) {
                resp.sendRedirect(req.getContextPath() + "/tasks");
                return;
            }
            req.setAttribute("task", t);
            req.getRequestDispatcher("/jsp/edit_task.jsp").forward(req, resp);
        } catch (Exception e) {
            throw new ServletException(e);
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        HttpSession s = req.getSession(false);
        int userId = (Integer) s.getAttribute("userId");

        int id = Integer.parseInt(req.getParameter("id"));
        String title = req.getParameter("title");
        String description = req.getParameter("description");
        String status = req.getParameter("status"); // PENDING / DONE

        try {
            new TaskDAO().updateTask(id, userId, title, description, status);
            resp.sendRedirect(req.getContextPath() + "/tasks");
        } catch (Exception e) {
            throw new ServletException(e);
        }
    }
}
