package controller;

import cart.Cart;
import cart.CartProduct;
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

@WebServlet("/add_cart")
public class AddCart extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession();
        CartProduct cart = (CartProduct) session.getAttribute("cart");
        ProductDAO productDAO = new ProductDAO(DBConnect.getConnection());
        LogDAO logDAO = new LogDAO(DBConnect.getConnection());
        User user = (User) session.getAttribute("success");
        String ip = IPAddressUtil.getPublicIPAddress();
        if(cart == null) cart = new CartProduct();
        int id = Integer.parseInt(req.getParameter("id"));
        Product p = productDAO.getProductById(id);
        cart.add(id);
        logDAO.insertLog(new Log(Log.INFO, user.getId(),ip,"Mua hàng","Thêm sản phẩm +"+" "+p.getTitle()+" "+"vào giỏ hàng",0));
        session.setAttribute("cart",cart);
        resp.sendRedirect("gallery.jsp");
    }
}
