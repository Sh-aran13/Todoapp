package web;

import dao.UserDAO;
import model.User;

import javax.servlet.*;
import javax.servlet.http.*;
import java.io.IOException;

public class LoginServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        String email = req.getParameter("email");
        String pass = req.getParameter("password");
        try {
            UserDAO dao = new UserDAO();
            User user = dao.login(email, pass);
            if (user == null) {
                req.setAttribute("error", "Invalid email or password");
                req.getRequestDispatcher("/jsp/login.jsp").forward(req, resp);
                return;
            }
            HttpSession session = req.getSession(true);
            session.setAttribute("userId", user.getId());
            session.setAttribute("userName", user.getName());
            resp.sendRedirect(req.getContextPath() + "/jsp/home.jsp");
        } catch (Exception e) {
            throw new ServletException(e);
        }
    }
}
