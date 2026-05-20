package util;

import org.mindrot.jbcrypt.BCrypt;

/**
 * PasswordUtil — handles BCrypt password hashing and verification.
 */
public class PasswordUtil {

    // 12 rounds of hashing (good balance of speed vs security)
    private static final int ROUNDS = 12;

    /**
     * Hash a plain-text password using BCrypt.
     * Call this when registering a new user.
     */
    public static String hashPassword(String plainPassword) {
        return BCrypt.hashpw(plainPassword, BCrypt.gensalt(ROUNDS));
    }

    /**
     * Check if a plain-text password matches the stored BCrypt hash.
     * Call this during login.
     */
    public static boolean verifyPassword(String plainPassword, String hashedPassword) {
        return BCrypt.checkpw(plainPassword, hashedPassword);
    }
}