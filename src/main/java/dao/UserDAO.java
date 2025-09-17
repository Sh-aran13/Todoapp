package dao;

import util.DB;
import util.PasswordUtil;
import model.User;
import java.sql.*;

public class UserDAO {

    public boolean emailExists(String email) throws Exception {
        String sql = "SELECT 1 FROM users WHERE email = ?";
        try (Connection con = DB.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, email);
            try (ResultSet rs = ps.executeQuery()) {
                return rs.next();
            }
        }
    }

    public void register(String name, String email, String plainPassword) throws Exception {
        String salt = PasswordUtil.generateSaltHex(16);
        String hash = PasswordUtil.hashPassword(plainPassword, salt);

        String sql = "INSERT INTO users(name, email, password_hash, salt) VALUES(?,?,?,?)";
        try (Connection con = DB.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, name);
            ps.setString(2, email);
            ps.setString(3, hash);
            ps.setString(4, salt);
            ps.executeUpdate();
        }
    }

    public User login(String email, String plainPassword) throws Exception {
        String sql = "SELECT id, name, email, password_hash, salt FROM users WHERE email = ?";
        try (Connection con = DB.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, email);
            try (ResultSet rs = ps.executeQuery()) {
                if (!rs.next()) return null;
                String salt = rs.getString("salt");
                String expected = rs.getString("password_hash");
                String actual = PasswordUtil.hashPassword(plainPassword, salt);
                if (expected.equals(actual)) {
                    return new User(rs.getInt("id"), rs.getString("name"), rs.getString("email"));
                }
                return null;
            }
        }
    }
}
