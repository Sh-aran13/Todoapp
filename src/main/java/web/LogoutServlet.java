package web;

import javax.servlet.*;
import javax.servlet.http.*;
import java.io.IOException;

public class LogoutServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	@Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        
        // Check for confirmation parameter
        String confirm = req.getParameter("confirm");
        
        if ("true".equals(confirm)) {
            // User confirmed, proceed with logout
            HttpSession s = req.getSession(false);
            if (s != null) {
                s.invalidate();
            }
            resp.sendRedirect(req.getContextPath() + "/jsp/login.jsp");
        } else {
            // No confirmation, redirect to confirmation page
            RequestDispatcher dispatcher = req.getRequestDispatcher("/jsp/LogoutConfirmation.jsp");
            dispatcher.forward(req, resp);
        }
    }
}