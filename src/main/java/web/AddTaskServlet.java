package web;

import dao.TaskDAO;

import javax.servlet.*;
import javax.servlet.http.*;
import java.io.IOException;

public class AddTaskServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        HttpSession s = req.getSession(false);
        int userId = (Integer) s.getAttribute("userId");
        String title = req.getParameter("title");
        String desc = req.getParameter("description");

        try {
            new TaskDAO().addTask(userId, title, desc);
            resp.sendRedirect(req.getContextPath() + "/tasks");
        } catch (Exception e) {
            throw new ServletException(e);
        }
    }
}
