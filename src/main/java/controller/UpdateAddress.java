package controller;


import dao.AddressDAO;
import database.DBConnect;
import model.Address;
import model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebServlet("/updateAddress")
public class UpdateAddress extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession();
        User user = (User) session.getAttribute("success");

        if (user == null) {
            resp.sendRedirect("login.jsp");
            return;
        }

        AddressDAO dao = new AddressDAO(DBConnect.getConnection());
        Address address = dao.getAddressByUserId(user.getId());

        if (address == null) {
            resp.sendError(HttpServletResponse.SC_NOT_FOUND, "Address not found");
            return;
        }

        String firstName = req.getParameter("firstName");
        String lastName = req.getParameter("lastName");
        String email = req.getParameter("email");
        String contact = req.getParameter("contact");
        String addr = req.getParameter("address");
        String paymentMethod = req.getParameter("paymentMethod");

        address.setFirstName(firstName);
        address.setLastName(lastName);
        address.setEmail(email);
        address.setContact(contact);
        address.setAddress(addr);
        address.setPaymentMethod(paymentMethod);

        boolean success = dao.updateAddress(address);

        if (success) {
            req.setAttribute("message", "Cập nhật thành công");
            req.setAttribute("messageType", "success");
        } else {
            req.setAttribute("message", "Cập nhật thất bại");
            req.setAttribute("messageType", "error");
        }

        req.getRequestDispatcher("tien_ich/List-address.jsp").forward(req, resp);
    }
}



