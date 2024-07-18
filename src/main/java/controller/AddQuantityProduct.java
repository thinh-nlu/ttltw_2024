package controller;

import dao.LogDAO;
import dao.ProductDAO;
import dao.WarehouseDAO;
import database.DBConnect;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import model.*;

import java.io.File;
import java.io.IOException;

@WebServlet("/add_quantity_product")
public class AddQuantityProduct extends HttpServlet {
    ProductDAO dao = new ProductDAO(DBConnect.getConnection());
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        int id = Integer.parseInt(req.getParameter("id"));
        Product productFromId = dao.getProductById(id);
        int quantity = Integer.parseInt(req.getParameter("quantity"));
        int totalQuantity = Integer.parseInt(productFromId.getQuantity()) + quantity;
        productFromId.setQuantity(String.valueOf(totalQuantity));

        HttpSession session = req.getSession();
        User user = (User) session.getAttribute("success");
        LogDAO logDAO = new LogDAO(DBConnect.getConnection());
        WarehouseDAO warehouseDAO = new WarehouseDAO(DBConnect.getConnection());
        String ip = IPAddressUtil.getPublicIPAddress();
        boolean isUpdate = dao.updateProduct(productFromId);
        if (isUpdate) {
            warehouseDAO.addWareHouse(new Warehouse(productFromId.getId(), quantity));
            session.setAttribute("updateProductMes","Cập nhật sản phẩm thành công");
            logDAO.insertLog(new Log(Log.ALERT, user.getId(),ip,"Quản Lí","Cập nhật thông tin sản phẩm "+" "+productFromId.getTitle()+" "+"thành công",0));
            resp.sendRedirect("admin/list-products.jsp");
        } else {
            session.setAttribute("updateProductMes","Cập nhật sản phẩm thất bại");
            logDAO.insertLog(new Log(Log.ALERT, user.getId(),ip,"Quản Lí","Cập nhật thông tin sản phẩm "+" "+productFromId.getTitle()+" "+"thất bại",0));
            resp.sendRedirect("admin/list-products.jsp");
        }
    }
}
