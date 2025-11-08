package util;

import java.sql.Connection;
import java.sql.DriverManager;

public class DB {
    private static final String URL = "jdbc:postgresql://dpg-d47f16a4d50c7384hkc0-a:5432/todoapp_b1tw";
    private static final String USER = todoapp_b1tw_user;    // <- change
    private static final String PASS = ycJZRQke7IFfsbMZ4n3Uk6Z3ETlhxkyc";    // <- change

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
