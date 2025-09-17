package filter;

import javax.servlet.*;
import javax.servlet.http.*;
import java.io.IOException;

public class AuthFilter implements Filter {
    @Override public void init(FilterConfig filterConfig) {}
    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {

        HttpServletRequest req = (HttpServletRequest) request;
        HttpServletResponse res = (HttpServletResponse) response;

        String path = req.getRequestURI();
        boolean publicPath = path.endsWith("/login") ||
                             path.endsWith("/register") ||
                             path.contains("/assets/") ||
                             path.endsWith(".css") ||
                             path.endsWith(".js") ||
                             path.endsWith(".png") ||
                             path.endsWith(".jpg") ||
                             path.contains("/jsp/login.jsp") ||
                             path.contains("/jsp/register.jsp");

        if (publicPath) {
            chain.doFilter(request, response);
            return;
        }

        HttpSession session = req.getSession(false);
        if (session != null && session.getAttribute("userId") != null) {
            chain.doFilter(request, response);
        } else {
            res.sendRedirect(req.getContextPath() + "/jsp/login.jsp");
        }
    }
    @Override public void destroy() {}
}
