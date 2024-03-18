package controller;

import cart.CartProduct;
import dao.OrderDAO;
import dao.OrderDetailDAO;
import dao.ProductDAO;
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
import java.util.List;

@WebServlet("/buy_product")
public class BuyProduct extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        int orderId = Integer.parseInt(req.getParameter("order_id"));
        HttpSession session = req.getSession();
        OrderDAO dao = new OrderDAO(DBConnect.getConnection());
        OrderDetailDAO orderDetailDAO = new OrderDetailDAO(DBConnect.getConnection());
        ProductDAO productDAO = new ProductDAO(DBConnect.getConnection());
        CartProduct cartProduct = (CartProduct) session.getAttribute("cart");
        boolean isUpdate = false;
        boolean updateStatusProduct = false;
        List<OrderDetail> orderDetailList = orderDetailDAO.getDetailOfOrder(orderId);
        for (OrderDetail o: orderDetailList) {
            Product product = productDAO.getProductById(o.getProductId());
            isUpdate = productDAO.updateQuantity(product, o.getQuantity());
        }
        if(isUpdate) {
            updateStatusProduct = dao.updateStatus(orderId);
            cartProduct.getData().clear();
            session.setAttribute("cart",cartProduct);
            session.setAttribute("createOrder",null);
            session.setAttribute("buyProductMessage","Đơn hàng đã được đặt thành công");
            resp.sendRedirect("index.jsp");
        } else {
            session.setAttribute("buyProductMessage","Hệ thống đang gap lỗi");
            resp.sendRedirect("tien_ich/checkout.jsp");
        }
    }
}
