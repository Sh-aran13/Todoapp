package web;

import dao.TaskDAO;

import javax.servlet.*;
import javax.servlet.http.*;
import java.io.IOException;

public class DeleteTaskServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        HttpSession s = req.getSession(false);
        int userId = (Integer) s.getAttribute("userId");
        int id = Integer.parseInt(req.getParameter("id"));

        try {
            new TaskDAO().deleteTask(id, userId);
            resp.sendRedirect(req.getContextPath() + "/tasks");
        } catch (Exception e) {
            throw new ServletException(e);
        }
    }
}
