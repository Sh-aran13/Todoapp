package util;

import java.sql.Connection;
import java.sql.DriverManager;

public class DB {
    private static final String URL = "jdbc:postgresql://localhost:5432/todoapp";
    private static final String USER = "postgres";    // <- change
    private static final String PASS = "1328";    // <- change

    static {
        try {
            Class.forName("org.postgresql.Driver");
        } catch (Exception e) {
            throw new RuntimeException("PostgreSQL Driver load failed", e);
        }
    }

    public static Connection getConnection() throws Exception {
        return DriverManager.getConnection(URL, USER, PASS);
    }
}
