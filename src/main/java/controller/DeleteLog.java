package controller;

import dao.LogDAO;
import database.DBConnect;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.io.PrintWriter;

@WebServlet(name = "RemoveLogAdmin", value = "/RemoveLogAdmin")
public class DeleteLog extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String logId = request.getParameter("id");

        if (logId != null && !logId.isEmpty()) {
            try {
                LogDAO logDAO = new LogDAO(DBConnect.getConnection());
                logDAO.deleteLog(Integer.parseInt(logId));
                response.setStatus(HttpServletResponse.SC_OK);
            } catch (Exception e) {
                response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
                e.printStackTrace(); // In ra lỗi vào console để debug
            }
        } else {
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
        }
    }
}
