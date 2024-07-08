package controller;

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

import java.io.IOException;

@WebServlet("/newAddress")
public class NewAddress extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // Lấy thông tin từ biểu mẫu
        HttpSession session = req.getSession();
        User user = (User) session.getAttribute("success");
        String firstName = req.getParameter("firstName");
        String lastName = req.getParameter("lastName");
        String email = req.getParameter("email");
        String contact = req.getParameter("contact");
        String addressText = req.getParameter("address");
        String paymentMethod = req.getParameter("paymentMethod");

        // Tạo một đối tượng địa chỉ từ thông tin được gửi từ biểu mẫu
        Address newAddress = new Address(user.getId(), firstName, lastName, addressText, paymentMethod, email, contact);

        // Lưu đối tượng địa chỉ vào cơ sở dữ liệu
        AddressDAO addressDAO = new AddressDAO(DBConnect.getConnection());
        boolean success = addressDAO.insertToAddress(newAddress);

        if (success) {
            // Nếu lưu thành công, chuyển hướng người dùng đến trang thông báo thành công
            resp.sendRedirect("tien_ich/List-address.jsp");
        } else {
            // Nếu lưu không thành công, chuyển hướng người dùng đến trang thông báo lỗi
            resp.sendRedirect("tien_ich/List-address.jsp");
        }
    }
    }

