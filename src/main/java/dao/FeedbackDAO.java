package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import database.DBConnect;
import model.Feedback;

public class FeedbackDAO {
    private final Connection con;

    public FeedbackDAO(Connection con) {
        this.con = con;
    }

    public boolean addFeedback(Feedback feedback) {
        String query = "INSERT INTO feedback (message, created, productID) VALUES (?, NOW(), ?)";
        try (PreparedStatement ps = con.prepareStatement(query)) {
            ps.setString(1, feedback.getMessage());
            ps.setInt(2, feedback.getProductID());
            int i = ps.executeUpdate();
            return i == 1;
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    public List<Feedback> getTop3Feedback(int id) {
        List<Feedback> feedbacks = new ArrayList<>();
        String query = "SELECT id, message, created, productID FROM feedback WHERE productID = ? ORDER BY id DESC LIMIT 3";
        try (PreparedStatement ps = con.prepareStatement(query)) {
            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Feedback feedback = new Feedback();
                    feedback.setId(rs.getInt("id"));
                    feedback.setMessage(rs.getString("message"));
                    feedback.setCreated(rs.getTimestamp("created"));
                    feedback.setProductID(rs.getInt("productID"));
                    feedbacks.add(feedback);
                }
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return feedbacks;
    }

    public static void main(String[] args) {
        FeedbackDAO feedbackDAO = new FeedbackDAO(DBConnect.getConnection());
        System.out.println(feedbackDAO.getTop3Feedback(123));
    }
}
