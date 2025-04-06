package ma.ac.esi.nutritrack.controleur;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet("/LogoutController")
public class LogoutController extends HttpServlet {
    private static final long serialVersionUID = 1L;
    
    // Security headers constants
    private static final String CACHE_CONTROL = "Cache-Control";
    private static final String NO_CACHE = "no-cache, no-store, must-revalidate";
    private static final String PRAGMA = "Pragma";
    private static final String NO_CACHE_LEGACY = "no-cache";
    private static final String EXPIRES = "Expires";
    private static final String ZERO = "0";

    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        // 1. Invalidate the session (if exists)
        HttpSession session = request.getSession(false);
        if (session != null) {
            // Clear all session attributes first
            session.removeAttribute("user");
            session.removeAttribute("login");
            
            // Invalidate the session
            session.invalidate();
        }

        // 2. Set security headers to prevent caching
        response.setHeader(CACHE_CONTROL, NO_CACHE);
        response.setHeader(PRAGMA, NO_CACHE_LEGACY);
        response.setHeader(EXPIRES, ZERO);

        // 3. Redirect to login page with logout parameter
        String contextPath = request.getContextPath();
        response.sendRedirect(contextPath + "/LoginController?logout=true");
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        // Prevent direct GET access to logout
        response.sendError(HttpServletResponse.SC_METHOD_NOT_ALLOWED, 
                         "GET method not supported for logout");
    }
}
