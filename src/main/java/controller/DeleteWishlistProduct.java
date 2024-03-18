package controller;

import dao.WishlistDAO;
import database.DBConnect;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
@WebServlet("/delete_wishlist")
public class DeleteWishlistProduct extends HttpServlet{
    WishlistDAO wdao = new WishlistDAO(DBConnect.getConnection());
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        int id = Integer.parseInt(req.getParameter("id"));
        WishlistDAO wdao = new WishlistDAO(DBConnect.getConnection());
        wdao.removeProductFromWishlist(id);
        resp.sendRedirect("tien_ich/wishlist.jsp");

    }
}
