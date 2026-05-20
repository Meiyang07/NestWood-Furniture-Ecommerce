package util;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import model.User;

/**
 * SessionUtil — helper methods to manage session data.
 *
 * Fix: setUser(req, id, fullName, role, avatar) overload was empty —
 * it now properly writes the session attributes so profile updates
 * are reflected immediately without requiring a fresh login.
 */
public class SessionUtil {

    /** Store the logged-in user in the session */
    public static void setUser(HttpServletRequest request, User user) {
        HttpSession session = request.getSession(true);
        session.setAttribute("loggedUser", user);
        session.setAttribute("userId",    user.getId());
        session.setAttribute("userName",  user.getFullName());
        session.setAttribute("userRole",  user.getRole());
    }

    /** Get the logged-in User object from session */
    public static User getUser(HttpServletRequest request) {
        HttpSession session = request.getSession(false);
        if (session == null) return null;
        return (User) session.getAttribute("loggedUser");
    }

    /** Get the role of the logged-in user */
    public static String getRole(HttpServletRequest request) {
        HttpSession session = request.getSession(false);
        if (session == null) return null;
        return (String) session.getAttribute("userRole");
    }

    /** Check if a user is currently logged in */
    public static boolean isLoggedIn(HttpServletRequest request) {
        return getUser(request) != null;
    }

    /** Destroy the session on logout */
    public static void invalidate(HttpServletRequest request) {
        HttpSession session = request.getSession(false);
        if (session != null) {
            session.invalidate();
        }
    }

    /**
     * FIX — was empty body; now writes session attributes.
     * Called by UserProfileServlet after a profile update so the
     * header immediately shows the updated name/role without re-login.
     */
    public static void setUser(HttpServletRequest request, int id, String fullName, String role, String avatar) {
        HttpSession session = request.getSession(true);
        session.setAttribute("userId",   id);
        session.setAttribute("userName", fullName);
        session.setAttribute("userRole", role);
    }
}
