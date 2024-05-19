package controller;

import dao.ProductDAO;
import database.DBConnect;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet("/updateDiscount")
public class UpdateDiscount extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        response.setContentType("text/html; charset=UTF-8");

        String idParam = request.getParameter("id");
        String discountParam = request.getParameter("newDiscount");

        if (idParam == null || discountParam == null) {
            response.getWriter().write("Missing parameters.");
            return;
        }

        int id;
        double newDiscount;

        try {
            id = Integer.parseInt(idParam);
            newDiscount = Double.parseDouble(discountParam);
        } catch (NumberFormatException e) {
            response.getWriter().write("Invalid parameters.");
            return;
        }

        ProductDAO productDAO = new ProductDAO(DBConnect.getConnection());
        boolean isUpdated = productDAO.updateDiscount(id, newDiscount);

        if (isUpdated) {
            response.getWriter().write("Cập nhật thành công.");
        } else {
            response.getWriter().write("cập nhật thất bại.");
        }
    }
}
