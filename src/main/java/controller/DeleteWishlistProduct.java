package controller;

import dao.LogDAO;
import dao.ProductDAO;
import dao.WishlistDAO;
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
@WebServlet("/delete_wishlist")
public class DeleteWishlistProduct extends HttpServlet{
    WishlistDAO wdao = new WishlistDAO(DBConnect.getConnection());
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        int id = Integer.parseInt(req.getParameter("id"));
        WishlistDAO wdao = new WishlistDAO(DBConnect.getConnection());
        ProductDAO productDAO = new ProductDAO(DBConnect.getConnection());
        Product p = productDAO.getProductById(id);
        HttpSession session =req.getSession();
        User user = (User) session.getAttribute("success");
        LogDAO logDAO = new LogDAO(DBConnect.getConnection());
        String ip = IPAddressUtil.getPublicIPAddress();
        logDAO.insertLog(new Log(Log.ALERT, user.getId(),ip,"Tài Khoản","Xóa sản phẩm "+" "+p.getTitle()+" "+"khỏi danh sách yêu thích",0));
        wdao.removeProductFromWishlist(id);
        resp.sendRedirect("tien_ich/wishlist.jsp");

    }
}
