package controller;

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

@WebServlet("/deleteCartProduct")
public class DeleteCartProduct extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession();
        CartProduct cartProduct = (CartProduct) session.getAttribute("cart");
        int id = Integer.parseInt(req.getParameter("id"));
        User user = (User) session.getAttribute("success");
        LogDAO logDAO = new LogDAO(DBConnect.getConnection());
        ProductDAO productDAO = new ProductDAO(DBConnect.getConnection());
        Product p = productDAO.getProductById(id);
        String ip = IPAddressUtil.getPublicIPAddress();
        logDAO.insertLog(new Log(Log.ALERT, user.getId(),ip,"Mua Hàng","Xóa sản phẩm"+" "+p.getTitle()+" "+" khỏi giỏ hàng",0));
        cartProduct.removeProduct(id);
        session.setAttribute("cart",cartProduct);
        resp.sendRedirect("tien_ich/cart.jsp");
    }
}
