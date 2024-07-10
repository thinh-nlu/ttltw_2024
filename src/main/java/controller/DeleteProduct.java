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
import model.User;

import java.io.IOException;

@WebServlet("/delete")
public class DeleteProduct extends HttpServlet {
    ProductDAO dao = new ProductDAO(DBConnect.getConnection());

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        int id = Integer.parseInt(req.getParameter("id"));
        boolean isDelete = dao.deleteProduct(id);
        HttpSession session = req.getSession();
        User user = (User) session.getAttribute("success");
        LogDAO logDAO = new LogDAO(DBConnect.getConnection());
        String ip = IPAddressUtil.getPublicIPAddress();
        if(isDelete) {
            logDAO.insertLog(new Log(Log.DANGER, user.getId(),ip,"Quản Lí","Xóa 1 sản phẩm",0));
            session.setAttribute("successUpdate","Xóa sản phẩm thành công");
            resp.sendRedirect("admin/list-products.jsp");
        } else {
            session.setAttribute("failedUpdate","Xóa sản phẩm thất bại");
            resp.sendRedirect("admin/list-products.jsp");
        }
    }
}
