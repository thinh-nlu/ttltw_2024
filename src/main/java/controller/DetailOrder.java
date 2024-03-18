package controller;

import dao.OrderDetailDAO;
import database.DBConnect;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.OrderDetail;

import java.io.IOException;
import java.util.List;

@WebServlet("/orderDetail")
public class DetailOrder extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        int id = Integer.parseInt(req.getParameter("orderId"));
        HttpSession session = req.getSession();
        OrderDetailDAO dao = new OrderDetailDAO(DBConnect.getConnection());
        List<OrderDetail> list = dao.getDetailOfOrder(id);
        session.setAttribute("orderDetail",list);
        resp.sendRedirect("tien_ich/order-detail.jsp");
    }
}
