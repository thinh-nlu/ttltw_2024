package controller;

import dao.FeedbackDAO;
import dao.LogDAO;
import dao.OrderDAO;
import dao.ProductDAO;
import database.DBConnect;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.*;

import java.io.IOException;
import java.sql.Timestamp;

@WebServlet("/userComment")
public class UserComment extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        int id = Integer.parseInt(req.getParameter("id"));

        String message = req.getParameter("message");
        FeedbackDAO feedbackDAO = new FeedbackDAO(DBConnect.getConnection());
        ProductDAO productDAO = new ProductDAO(DBConnect.getConnection());
        Feedback feedback = new Feedback();

        feedback.setMessage(message);
        feedback.setCreated(new Timestamp(id));
        feedback.setProductID(id);
        Product product = productDAO.getProductById(id);

        User user = (User) req.getSession().getAttribute("success");
        HttpSession session = req.getSession();
        LogDAO logDAO = new LogDAO(DBConnect.getConnection());
        String ip = IPAddressUtil.getPublicIPAddress();


        if (user == null) {
            resp.sendRedirect("account/login.jsp");
            return;
        }

        // Kiểm tra xem người dùng đã có đơn hàng hay chưa
        OrderDAO orderDAO = new OrderDAO(DBConnect.getConnection());
        boolean userHasOrders = orderDAO.userHasOrders(user.getId(),id);

        if (!userHasOrders) {
            req.getSession().setAttribute("msgFeedback", "Bạn cần phải mua hàng trước khi để lại bình luận.");
            resp.sendRedirect("product-detail?id=" + req.getParameter("id"));
            return;
        }


        if(feedbackDAO.addFeedback(feedback)) {
            if(id==0) {
                req.getSession().setAttribute("msgFeedback", "Cảm ơn quý khách đã đóng góp ý kiến. Chúc quý khách 1 ngày tốt lành.");
                resp.sendRedirect("contact-us.jsp");

            } else {
                logDAO.insertLog(new Log(Log.ALERT, user.getId(),ip,"Nhận xét","Nhận xét về sản phẩm" +" "+product.getTitle()+" ",0));
                req.getSession().setAttribute("msgFeedback", "Cảm ơn quý khách đã đóng góp ý kiến. Chúc quý khách 1 ngày tốt lành.");
                resp.sendRedirect("product-detail?id=" + id);
            }
        } else {
            req.getSession().setAttribute("msgFeedback", "Để lại bình luận không thành công.");
            resp.sendRedirect("product-detail?id=" + id);
        }
    }
}
