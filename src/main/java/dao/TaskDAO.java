package dao;

import util.DB;
import model.Task;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class TaskDAO {

    public void addTask(int userId, String title, String description) throws Exception {
        String sql = "INSERT INTO tasks(user_id, title, description) VALUES(?,?,?)";
        try (Connection con = DB.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, userId);
            ps.setString(2, title);
            ps.setString(3, description);
            ps.executeUpdate();
        }
    }

    public List<Task> findByUser(int userId) throws Exception {
        String sql = "SELECT id, user_id, title, description, status FROM tasks WHERE user_id=? ORDER BY id DESC";
        List<Task> list = new ArrayList<>();
        try (Connection con = DB.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, userId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Task t = new Task();
                    t.setId(rs.getInt("id"));
                    t.setUserId(rs.getInt("user_id"));
                    t.setTitle(rs.getString("title"));
                    t.setDescription(rs.getString("description"));
                    t.setStatus(rs.getString("status"));
                    list.add(t);
                }
            }
        }
        return list;
    }

    public Task findByIdAndUser(int id, int userId) throws Exception {
        String sql = "SELECT id, user_id, title, description, status FROM tasks WHERE id=? AND user_id=?";
        try (Connection con = DB.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, id);
            ps.setInt(2, userId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    Task t = new Task();
                    t.setId(rs.getInt("id"));
                    t.setUserId(rs.getInt("user_id"));
                    t.setTitle(rs.getString("title"));
                    t.setDescription(rs.getString("description"));
                    t.setStatus(rs.getString("status"));
                    return t;
                }
                return null;
            }
        }
    }

    public void updateTask(int id, int userId, String title, String description, String status) throws Exception {
        String sql = "UPDATE tasks SET title=?, description=?, status=?, updated_at=NOW() WHERE id=? AND user_id=?";
        try (Connection con = DB.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, title);
            ps.setString(2, description);
            ps.setString(3, status);
            ps.setInt(4, id);
            ps.setInt(5, userId);
            ps.executeUpdate();
        }
    }

    public void deleteTask(int id, int userId) throws Exception {
        String sql = "DELETE FROM tasks WHERE id=? AND user_id=?";
        try (Connection con = DB.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, id);
            ps.setInt(2, userId);
            ps.executeUpdate();
        }
    }
}
