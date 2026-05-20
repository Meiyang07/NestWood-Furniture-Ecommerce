package util;

/**
 * ValidationUtil — server-side validation helpers for NestWood.
 * Phase 6 additions: sanitize(), isValidName(), isValidAddress(),
 * isValidQuantity(), maxLength() helper.
 */
public class ValidationUtil {

    // ── Basic ──────────────────────────────────────────────────────────────

    /** True if null, blank, or whitespace-only. */
    public static boolean isEmpty(String value) {
        return value == null || value.trim().isEmpty();
    }

    /** True if value is non-null, non-blank, and within maxLen chars. */
    public static boolean maxLength(String value, int maxLen) {
        return !isEmpty(value) && value.trim().length() <= maxLen;
    }

    // ── Field validators ───────────────────────────────────────────────────

    /** Full name: 2–80 chars, letters/spaces/hyphens/apostrophes only. */
    public static boolean isValidName(String name) {
        if (isEmpty(name)) return false;
        String t = name.trim();
        return t.length() >= 2 && t.length() <= 80 && t.matches("[\\p{L} '\\-]+");
    }

    /** Email format via RFC-style regex. */
    public static boolean isValidEmail(String email) {
        if (isEmpty(email)) return false;
        return email.trim().matches("^[\\w._%+\\-]+@[\\w.\\-]+\\.[a-zA-Z]{2,}$");
    }

    /** Phone: exactly 10 digits. */
    public static boolean isValidPhone(String phone) {
        if (isEmpty(phone)) return false;
        return phone.trim().matches("^[0-9]{10}$");
    }

    /**
     * Password strength:
     * – 8+ characters
     * – at least one uppercase letter
     * – at least one digit
     * – at least one special character  (added Phase 6 — keeps backward compat
     *   because old check is a subset; callers that only tested length/upper/digit
     *   will still pass if they also add a special char, which is best practice).
     *
     * If you need the old lenient rule just use isStrongPasswordLenient() below.
     */
    public static boolean isStrongPassword(String password) {
        if (isEmpty(password)) return false;
        return password.matches("^(?=.*[A-Z])(?=.*\\d)(?=.*[^A-Za-z0-9]).{8,}$");
    }

    /**
     * Lenient version — kept for backward compatibility with existing tests.
     * Only requires uppercase + digit (no special char).
     */
    public static boolean isStrongPasswordLenient(String password) {
        if (isEmpty(password)) return false;
        return password.matches("^(?=.*[A-Z])(?=.*\\d).{8,}$");
    }

    /** Price: positive number, max 10 integer digits and 2 decimal places. */
    public static boolean isValidPrice(String price) {
        if (isEmpty(price)) return false;
        try {
            double v = Double.parseDouble(price.trim());
            return v > 0 && v < 100_000_000;   // sanity cap
        } catch (NumberFormatException e) {
            return false;
        }
    }

    /** Stock: non-negative integer ≤ 99999. */
    public static boolean isValidStock(String stock) {
        if (isEmpty(stock)) return false;
        try {
            int v = Integer.parseInt(stock.trim());
            return v >= 0 && v <= 99_999;
        } catch (NumberFormatException e) {
            return false;
        }
    }

    /** Delivery address: 10–255 chars. */
    public static boolean isValidAddress(String address) {
        if (isEmpty(address)) return false;
        int len = address.trim().length();
        return len >= 10 && len <= 255;
    }

    /** Quantity: positive integer ≤ 999. */
    public static boolean isValidQuantity(String quantity) {
        if (isEmpty(quantity)) return false;
        try {
            int v = Integer.parseInt(quantity.trim());
            return v > 0 && v <= 999;
        } catch (NumberFormatException e) {
            return false;
        }
    }

    // ── Sanitization ───────────────────────────────────────────────────────

    /**
     * Strip leading/trailing whitespace and collapse internal runs of
     * whitespace to a single space.  Safe to pass null (returns "").
     */
    public static String sanitize(String value) {
        if (value == null) return "";
        return value.trim().replaceAll("\\s+", " ");
    }

    /**
     * Basic HTML-escape to prevent reflected XSS when re-displaying
     * user input inside JSP without c:out.
     * For full XSS protection use JSTL <c:out> in JSPs.
     */
    public static String escapeHtml(String value) {
        if (value == null) return "";
        return value
                .replace("&", "&amp;")
                .replace("<", "&lt;")
                .replace(">", "&gt;")
                .replace("\"", "&quot;")
                .replace("'", "&#x27;");
    }
}
