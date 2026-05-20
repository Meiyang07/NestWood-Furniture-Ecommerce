package util;

import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

/**
 * CookieUtil — helper methods for remember-me cookie management.
 */
public class CookieUtil {

    private static final String REMEMBER_ME_COOKIE = "nestwood_remember";
    private static final int    MAX_AGE_7_DAYS     = 7 * 24 * 60 * 60; // seconds

    /** Set a remember-me cookie storing the user's email */
    public static void setRememberMe(HttpServletResponse response, String email) {
        Cookie cookie = new Cookie(REMEMBER_ME_COOKIE, email);
        cookie.setMaxAge(MAX_AGE_7_DAYS);
        cookie.setPath("/");          // available across whole app
        cookie.setHttpOnly(true);     // not accessible by JavaScript
        response.addCookie(cookie);
    }

    /** Get the remember-me cookie value (email), or null if not found */
    public static String getRememberMe(HttpServletRequest request) {
        Cookie[] cookies = request.getCookies();
        if (cookies == null) return null;
        for (Cookie c : cookies) {
            if (REMEMBER_ME_COOKIE.equals(c.getName())) {
                return c.getValue();
            }
        }
        return null;
    }

    /** Delete the remember-me cookie on logout */
    public static void deleteRememberMe(HttpServletResponse response) {
        Cookie cookie = new Cookie(REMEMBER_ME_COOKIE, "");
        cookie.setMaxAge(0);   // age 0 = delete immediately
        cookie.setPath("/");
        response.addCookie(cookie);
    }
}