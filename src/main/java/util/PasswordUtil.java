package util;

import java.security.MessageDigest;
import java.security.SecureRandom;

public class PasswordUtil {
    private static final SecureRandom RNG = new SecureRandom();

    public static String bytesToHex(byte[] b) {
        StringBuilder sb = new StringBuilder();
        for (byte x : b) sb.append(String.format("%02x", x));
        return sb.toString();
    }

    public static String generateSaltHex(int bytes) {
        byte[] salt = new byte[bytes];
        RNG.nextBytes(salt);
        return bytesToHex(salt);
    }

    public static String sha256Hex(String s) {
        try {
            MessageDigest md = MessageDigest.getInstance("SHA-256");
            return bytesToHex(md.digest(s.getBytes("UTF-8")));
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
    }

    public static String hashPassword(String plain, String saltHex) {
        return sha256Hex(plain + ":" + saltHex);
    }
}
