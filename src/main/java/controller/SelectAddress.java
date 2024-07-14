package controller;



import dao.AddressDAO;
import database.DBConnect;
import jakarta.servlet.http.HttpSession;
import model.Address;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Connection;
import java.util.List;

@WebServlet("/selectAddress")
public class SelectAddress extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Lấy addressId và userId từ yêu cầu
        int addressId = Integer.parseInt(request.getParameter("addressId"));
        int userId = Integer.parseInt(request.getParameter("userId"));
        HttpSession session = request.getSession();

        // Kết nối cơ sở dữ liệu
        Connection con = DBConnect.getConnection();
        AddressDAO addressDAO = new AddressDAO(con);

        // Cập nhật isSelect
        boolean isUpdated = addressDAO.updateIsSelect(addressId, userId);

        if (isUpdated) {
            // Chuyển hướng về trang chính nếu cập nhật thành công
            response.sendRedirect("tien_ich/List-address.jsp");

        } else {
            // Xử lý lỗi nếu cập nhật thất bại
            response.sendRedirect("tien_ich/List-address.jsp");

        }
    }
}

