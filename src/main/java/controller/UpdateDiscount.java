package controller;

import dao.LogDAO;
import dao.ProductDAO;
import database.DBConnect;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.IPAddressUtil;
import model.Log;
import model.Product;
import model.User;

import java.io.IOException;

@WebServlet("/updateDiscount")
public class UpdateDiscount extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        response.setContentType("text/html; charset=UTF-8");
        HttpSession session = request.getSession();

        String idParam = request.getParameter("id");
        String discountParam = request.getParameter("newDiscount");
        User user = (User) session.getAttribute("success");
        LogDAO logDAO = new LogDAO(DBConnect.getConnection());
        String ip = IPAddressUtil.getPublicIPAddress();

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
        Product p = productDAO.getProductById(Integer.parseInt(idParam));
        boolean isUpdated = productDAO.updateDiscount(id, newDiscount);

        if (isUpdated) {
            response.getWriter().write("Cập nhật thành công.");
            logDAO.insertLog(new Log(Log.ALERT, user.getId(),ip,"Quản Lí","Cập nhật khuyến mãi sản phẩm"+" "+p.getTitle()+" "+" thành công",0));
        } else {
            response.getWriter().write("cập nhật thất bại.");
            logDAO.insertLog(new Log(Log.ALERT, user.getId(),ip,"Quản Lí","Cập nhật khuyến mãi sản phẩm"+" "+p.getTitle()+" "+" thất bại",0));
        }
    }
}
