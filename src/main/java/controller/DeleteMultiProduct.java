package controller;

import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import dao.*;
import database.DBConnect;
import jakarta.servlet.ServletException;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.*;

import java.io.IOException;

@WebServlet("/deleteProduct")
public class DeleteMultiProduct extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String[] productIds = req.getParameterValues("orderCheckbox");
        HttpSession session = req.getSession();
        User user = (User) session.getAttribute("success");
        LogDAO logDAO = new LogDAO(DBConnect.getConnection());
        ProductDAO productDAO = new ProductDAO(DBConnect.getConnection());
        String ip = IPAddressUtil.getPublicIPAddress();

        boolean allDeleted = true;

        if (productIds != null) {
            for (String idStr : productIds) {
                int id = Integer.parseInt(idStr);
                Product p = productDAO.getProductById(id);
                boolean isDelete = productDAO.deleteProduct(id); // Assuming delete method in ProductDAO
                if (isDelete) {
                    logDAO.insertLog(new Log(Log.DANGER, user.getId(), ip, "Quản Lí", "Xóa sản phẩm " + p.getTitle() + " thành công", 0));
                } else {
                    logDAO.insertLog(new Log(Log.DANGER, user.getId(), ip, "Quản Lí", "Xóa sản phẩm " + p.getTitle() + " thất bại", 0));
                    allDeleted = false;
                }
            }
        }

        if (allDeleted) {
            session.setAttribute("successUpdate", "Xóa sản phẩm thành công");
        } else {
            session.setAttribute("failedUpdate", "Xóa sản phẩm thất bại");
        }
        resp.sendRedirect("admin/list-products.jsp");
    }


}
