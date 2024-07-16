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

@WebServlet("/changeStatus")
public class ChangeShippingStatus extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        int orderId = Integer.parseInt(req.getParameter("orderId"));
        OrderDAO orderDAO = new OrderDAO(DBConnect.getConnection());
        LogDAO logDAO = new LogDAO(DBConnect.getConnection());
        HttpSession session = req.getSession();
        String ip = IPAddressUtil.getPublicIPAddress();
        User user = (User) session.getAttribute("success");
        Order order = orderDAO.getOrderById(orderId);
        System.out.println(order);

        if(order.getAddressShipStatus().equals("Chờ xác nhận")){
            orderDAO.ChangeShippingStatus(orderId,"Đang vận chuyển");
            logDAO.insertLog(new Log(Log.ALERT, user.getId(),ip,"Quản Lí","Xác nhận đơn hàng cho đơn vị vận chuyển ",0));
            resp.sendRedirect("admin/list-oders.jsp");
        } else if (order.getAddressShipStatus().equals("Đang vận chuyển")) {
            orderDAO.ChangeShippingStatus(orderId,"Đã vận chuyển");
            logDAO.insertLog(new Log(Log.ALERT, user.getId(),ip,"Quản Lí","Xác nhận đơn hàng đã vận chuyển thành công ",0));
            resp.sendRedirect("admin/list-oders.jsp");
        }

    }
}
