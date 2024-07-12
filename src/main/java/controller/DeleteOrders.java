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
import model.User;
import org.apache.http.client.fluent.Request;

import java.io.IOException;

@WebServlet("/deleteOrders")
public class DeleteOrders extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String[] orderIds = request.getParameterValues("orderIds");
        OrderDAO orderDAO = new OrderDAO(DBConnect.getConnection());
        LogDAO logDAO = new LogDAO(DBConnect.getConnection());
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("success");
        String ip = IPAddressUtil.getPublicIPAddress();


        if (orderIds != null) {
            for (String orderId : orderIds) {
                orderDAO.deleteOrderById(Integer.parseInt(orderId));
                logDAO.insertLog(new Log(Log.ALERT, user.getId(),ip,"Đơn hàng","Xoá đơn hàng thành công",0));
            }
        }

        response.sendRedirect("admin/list-oders.jsp");
    }
}

