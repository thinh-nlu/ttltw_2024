package controller;

import cart.Cart;
import cart.CartProduct;
import dao.OrderDAO;
import dao.OrderDetailDAO;
import database.DBConnect;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.Order;
import model.OrderDetail;
import model.Product;

import java.io.IOException;
import java.util.Map;

@WebServlet("/createOrderDetail")
public class CreateOrderDetail extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession();
        OrderDAO orderDAO = new OrderDAO(DBConnect.getConnection());
        OrderDetailDAO dao = new OrderDetailDAO(DBConnect.getConnection());
        CartProduct cartProduct = (CartProduct) session.getAttribute("cart");
        Order o = (Order) session.getAttribute("createOrder");
        Order order = orderDAO.getOrderByInvoiceNumber(o.getInvoiceNumber());
        OrderDetail orderDetail = null;
        boolean isAdd = false;
        if(order != null) {
            for (Map.Entry<Integer, Cart> entry: cartProduct.getData().entrySet()) {
                Product product = entry.getValue().getProduct();
                int quantity = entry.getValue().getQuantity();
                orderDetail = new OrderDetail(product.getId(),order.getId(),quantity);
                isAdd = dao.insertToOrderDetail(orderDetail);
            }
            if (isAdd) {
                session.setAttribute("createOrderDetail", orderDetail);
                session.setAttribute("createOrder",order);
            }
        }
        resp.sendRedirect("tien_ich/checkout.jsp");
    }
}
