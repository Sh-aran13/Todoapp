package web;

import dao.UserDAO;
import javax.servlet.*;
import javax.servlet.http.*;
import java.io.IOException;

public class RegisterServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	@Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        String name = req.getParameter("name");
        String email = req.getParameter("email");
        String pass = req.getParameter("password");

        try {
            UserDAO dao = new UserDAO();
            if (dao.emailExists(email)) {
                req.setAttribute("error", "Email already registered");
                req.getRequestDispatcher("/jsp/register.jsp").forward(req, resp);
                return;
            }
            dao.register(name, email, pass);
            req.setAttribute("msg", "Registration successful. Please login.");
            req.getRequestDispatcher("/jsp/login.jsp").forward(req, resp);
        } catch (Exception e) {
            throw new ServletException(e);
        }
    }
}
