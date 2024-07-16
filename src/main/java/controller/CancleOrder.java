package controller;

import dao.LogDAO;
import dao.OrderDAO;
import database.DBConnect;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.IPAddressUtil;
import model.Log;
import model.Order;
import model.User;

import java.io.IOException;

@WebServlet("/CancleOrder")
public class CancleOrder extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int orderId = Integer.parseInt(request.getParameter("orderId"));
        LogDAO logDAO = new LogDAO(DBConnect.getConnection());
        HttpSession session = request.getSession();
        String ip = IPAddressUtil.getPublicIPAddress();
        User user = (User) session.getAttribute("success");

        OrderDAO orderDAO = new OrderDAO(DBConnect.getConnection());
        Order order = orderDAO.getOrderById(orderId);
        orderDAO.CancleOder(orderId, "Đơn hàng đã được huỷ");
        logDAO.insertLog(new Log(Log.ALERT, user.getId(),ip,"Mua Hàng","Đã huỷ đơn hàng"+" "+order.getInvoiceNumber(),0));
        response.sendRedirect("tien_ich/list-order.jsp");
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }
}
