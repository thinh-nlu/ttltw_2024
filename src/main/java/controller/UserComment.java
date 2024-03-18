package controller;

import dao.FeedbackDAO;
import database.DBConnect;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Feedback;

import java.io.IOException;
import java.sql.Timestamp;

@WebServlet("/userComment")
public class UserComment extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        int id = Integer.parseInt(req.getParameter("id"));
        String name = req.getParameter("name");
        String email = req.getParameter("email");
        String message = req.getParameter("message");
        FeedbackDAO feedbackDAO = new FeedbackDAO(DBConnect.getConnection());
        Feedback feedback = new Feedback();
        feedback.setName(name);
        feedback.setEmail(email);
        feedback.setMessage(message);
        feedback.setCreated(new Timestamp(id));
        feedback.setProductID(id);
        if(feedbackDAO.addFeedback(feedback)) {
            if(id==0) {
                req.getSession().setAttribute("msgFeedback", "Cảm ơn quý khách đã đóng góp ý kiến. Chúc quý khách 1 ngày tốt lành.");
                resp.sendRedirect("contact-us.jsp");
            } else {
                req.getSession().setAttribute("msgFeedback", "Cảm ơn quý khách đã đóng góp ý kiến. Chúc quý khách 1 ngày tốt lành.");
                resp.sendRedirect("product-detail?id=" + id);
            }
        } else {
            req.getSession().setAttribute("msgFeedback", "Để lại bình luận không thành công.");
            resp.sendRedirect("product-detail?id=" + id);
        }
    }
}
