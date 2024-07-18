package controller;

import com.google.gson.Gson;
import dao.OrderDAO;
import database.DBConnect;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.util.Map;

@WebServlet("/DailyRevenue")
public class RevenueDay extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("application/json");
        PrintWriter out = response.getWriter();
        Connection con = DBConnect.getConnection();
        OrderDAO orderDAO = new OrderDAO(con);

        String monthParam = request.getParameter("month");
        String yearParam = request.getParameter("year");
        int month = 1; // Mặc định là tháng 1
        int year = 2024; // Mặc định là năm 2024

        if (monthParam != null) {
            try {
                month = Integer.parseInt(monthParam);
            } catch (NumberFormatException e) {
                // Nếu không phải là số hợp lệ thì giữ nguyên giá trị mặc định
            }
        }

        if (yearParam != null) {
            try {
                year = Integer.parseInt(yearParam);
            } catch (NumberFormatException e) {
                // Nếu không phải là số hợp lệ thì giữ nguyên giá trị mặc định
            }
        }

        Map<String, Double> dailyRevenueMap = orderDAO.getDailyRevenue(month, year);

        String json = new Gson().toJson(dailyRevenueMap);
        out.print(json);
        out.flush();
    }
}
