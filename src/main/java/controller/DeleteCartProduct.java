package controller;

import cart.CartProduct;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebServlet("/deleteCartProduct")
public class DeleteCartProduct extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession();
        CartProduct cartProduct = (CartProduct) session.getAttribute("cart");
        int id = Integer.parseInt(req.getParameter("id"));
        cartProduct.removeProduct(id);
        session.setAttribute("cart",cartProduct);
        resp.sendRedirect("tien_ich/cart.jsp");
    }
}
