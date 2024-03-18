package dao;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import database.DBConnect;
import model.Feedback;


public class FeedbackDAO {
    private String query = "";
    private PreparedStatement ps;
    private ResultSet rs;
    private final Connection con;

    public FeedbackDAO(Connection con) {
        this.con = con;
    }

    public boolean addFeedback(Feedback feedback) {
        boolean isAdd = false;
        query = "insert into feedback(name,email,message,created,productID) " + "values(?,?,?,NOW(),?)";
        try {
            ps = con.prepareStatement(query);
            ps.setString(1, feedback.getName());
            ps.setString(2, feedback.getEmail());
            ps.setString(3, feedback.getMessage());
            ps.setInt(4, feedback.getProductID());

            int i = ps.executeUpdate();

            isAdd = i == 1;
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }

        return isAdd;
    }

    public List<Feedback> getTop3Feedback(int id) {
        List<Feedback> feedbacks = new ArrayList<>();
        Feedback feedback = null;
        query = "SELECT id, name, email, message, created, productID FROM feedback WHERE productID = ? ORDER BY id DESC LIMIT 3";
        try {
            ps = con.prepareStatement(query);
            ps.setInt(1, id);
            rs = ps.executeQuery();
            while (rs.next()) {
                feedback = new Feedback();
                feedback.setId(rs.getInt(1));
                feedback.setName(rs.getString(2));
                feedback.setEmail(rs.getString(3));
                feedback.setMessage(rs.getString(4));
                feedback.setCreated(rs.getTimestamp(5));
                feedback.setProductID(rs.getInt(6));
                feedbacks.add(feedback);
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return feedbacks;
    }


    public static void main(String[] args) {
        FeedbackDAO feedbackDAO = new FeedbackDAO(DBConnect.getConnection());
        System.out.println(feedbackDAO.getTop3Feedback(165));
    }
}
