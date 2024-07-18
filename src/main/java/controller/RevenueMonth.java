package controller;

import com.google.gson.Gson;
import dao.OrderDAO;
import database.DBConnect;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.util.HashMap;
import java.util.Map;

@WebServlet("/MonthlyRevenue")
public class RevenueMonth extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("application/json");
        PrintWriter out = response.getWriter();
        Connection con = DBConnect.getConnection();
        OrderDAO orderDAO = new OrderDAO(con);

        String yearParam = request.getParameter("year");
        int year = 2024; // Mặc định là 2024
        if (yearParam != null) {
            try {
                year = Integer.parseInt(yearParam);
            } catch (NumberFormatException e) {
                // Nếu không phải là số hợp lệ thì giữ nguyên giá trị mặc định
            }
        }

        Map<String, Double> revenueMap = new HashMap<>();
        for (int month = 1; month <= 12; month++) {
            double revenue = orderDAO.getMonthlyRevenue(month, year);
            revenueMap.put("Tháng " + month, revenue);
        }

        String json = new Gson().toJson(revenueMap);
        out.print(json);
        out.flush();
    }
}
