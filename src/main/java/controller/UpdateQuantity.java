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
import java.util.HashMap;
import java.util.Map;

@WebServlet("/update_quantity")
public class UpdateQuantity extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession();
        CartProduct cartProduct = (CartProduct) session.getAttribute("cart");

        for (Map.Entry<Integer, Cart> entry: cartProduct.getData().entrySet()) {
            int quantity = Integer.parseInt(req.getParameter("quantity"));
            int id = Integer.parseInt(req.getParameter("id"));

            if(entry.getKey() == id) {
                Cart cart = entry.getValue();
                cart.setQuantity(quantity);
                break;
            }
        }
        session.setAttribute("cart",cartProduct);
        resp.sendRedirect("tien_ich/cart.jsp");
    }
}
