package controller;

import dao.ProductDAO;
import database.DBConnect;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebServlet("/delete")
public class DeleteProduct extends HttpServlet {
    ProductDAO dao = new ProductDAO(DBConnect.getConnection());

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        int id = Integer.parseInt(req.getParameter("id"));
        boolean isDelete = dao.deleteProduct(id);
        HttpSession session = req.getSession();
        if(isDelete) {
            session.setAttribute("successUpdate","Xóa sản phẩm thành công");
            resp.sendRedirect("admin/list-products.jsp");
        } else {
            session.setAttribute("failedUpdate","Xóa sản phẩm thất bại");
            resp.sendRedirect("admin/list-products.jsp");
        }
    }
}
