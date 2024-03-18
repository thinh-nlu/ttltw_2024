package controller;

import cart.CartProduct;
import dao.AddressDAO;
import database.DBConnect;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.Address;
import model.User;
import java.util.List;

import java.io.IOException;

@WebServlet("/saveAddress")
public class SaveAddress extends HttpServlet {
    AddressDAO dao;

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        dao = new AddressDAO(DBConnect.getConnection());
        boolean isAdd = false;
        HttpSession session = req.getSession();
        CartProduct cartProduct = (CartProduct) session.getAttribute("cart");
        User user = (User) session.getAttribute("success");
        Address a = dao.getAddressByUserId(user.getId());
        String firstName = req.getParameter("firstName");
        String lastName = req.getParameter("lastName");
        String email = req.getParameter("email");
        String contact = req.getParameter("contact");
        String address = req.getParameter("address");
        String paymentMethod = req.getParameter("paymentMethod");

        if(a==null) {
            a = new Address(user.getId(), firstName, lastName, address, paymentMethod, email, contact);
            isAdd = dao.insertToAddress(a);
        } else {
            isAdd = true;
        }
        if(isAdd) {
            session.setAttribute("saveAddressText", "Bạn đã cập nhật thông tin thành công");
        } else {
            session.setAttribute("saveAddressText", "Hệ thống đang gặp lỗi. Vui lòng thử lại sau");
        }

        if(cartProduct == null) {
            resp.sendRedirect("tien_ich/address.jsp");
        } else {
            resp.sendRedirect(req.getContextPath()+"/createOrder");
        }
    }
}
