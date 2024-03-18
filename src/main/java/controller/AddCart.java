package controller;

import cart.Cart;
import cart.CartProduct;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebServlet("/add_cart")
public class AddCart extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession();
        CartProduct cart = (CartProduct) session.getAttribute("cart");
        if(cart == null) cart = new CartProduct();
        int id = Integer.parseInt(req.getParameter("id"));
        cart.add(id);
        session.setAttribute("cart",cart);
        resp.sendRedirect("tien_ich/cart.jsp");
    }
}
