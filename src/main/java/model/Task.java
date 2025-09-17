package model;

import java.time.LocalDateTime;

public class Task {
    private int id;
    private int userId;
    private String title;
    private String description;
    private String status; // PENDING / DONE
    private LocalDateTime createdAt;
    private LocalDateTime updatedAt;

    // Getters/Setters
    public int getId() { return id; }
    public void setId(int id) { this.id=id; }
    public int getUserId() { return userId; }
    public void setUserId(int userId) { this.userId=userId; }
    public String getTitle() { return title; }
    public void setTitle(String title) { this.title=title; }
    public String getDescription() { return description; }
    public void setDescription(String description) { this.description=description; }
    public String getStatus() { return status; }
    public void setStatus(String status) { this.status=status; }
}
