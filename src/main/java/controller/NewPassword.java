package controller;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.nio.charset.StandardCharsets;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;

/**
 * Servlet implementation class NewPassword
 */
@WebServlet("/newPassword")
public class NewPassword extends HttpServlet {


    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        HttpSession session = req.getSession();

        String newPassword = req.getParameter("password");
        String confPassword = req.getParameter("confPassword");

        RequestDispatcher dispatcher = null;
        if (newPassword == null || newPassword.isEmpty() || confPassword ==null || confPassword.isEmpty()){
            session.removeAttribute("resetSuccess");
            session.setAttribute("resetFailed","Vui lòng điền đầy đủ thông tin");
            resp.sendRedirect("account/newPassword.jsp");

        } else if (newPassword.length()<= 7 ) {
            session.removeAttribute("resetSuccess");
            session.setAttribute("resetFailed","Mật khẩu phải có nhiều hơn hoặc bằng 8 kí tự");
            resp.sendRedirect("account/newPassword.jsp");

        } else if (!newPassword.equals(confPassword)){
            session.removeAttribute("resetSuccess");
            session.setAttribute("resetFailed","mật khẩu xác nhận không khớp với mật khẩu mới");
            resp.sendRedirect("account/newPassword.jsp");
        }
        else  {
            session.removeAttribute("resetFailed");
            try {
                Class.forName("com.mysql.jdbc.Driver");
                Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/nonglamxanh_shop", "root",
                        "");
                PreparedStatement pst = con.prepareStatement("update users set password = ? where email = ? ");
                pst.setString(1, hashPassword(newPassword));
                pst.setString(2, (String) session.getAttribute("email"));

                int rowCount = pst.executeUpdate();
                if (rowCount > 0) {
                    req.setAttribute("resetSuccess", "khôi phục mật khẩu thành công");
                    dispatcher = req.getRequestDispatcher("account/newPassword.jsp");
                } else {
                    req.setAttribute("resetFailed", "khôi phục mật khẩu thất bại");
                    dispatcher = req.getRequestDispatcher("account/newPassword.jsp");
                }
                dispatcher.forward(req,resp);

            } catch (Exception e) {
                e.printStackTrace();
            }
        }





    }

    private String hashPassword(String password) {
        try {
            MessageDigest digest = MessageDigest.getInstance("SHA-256");
            byte[] encodedHash = digest.digest(
                    password.getBytes(StandardCharsets.UTF_8));

            StringBuilder hexString = new StringBuilder();
            for (byte b : encodedHash) {
                String hex = Integer.toHexString(0xff & b);
                if (hex.length() == 1) {
                    hexString.append('0');
                }
                hexString.append(hex);
            }
            return hexString.toString();
        } catch (NoSuchAlgorithmException e) {
            e.printStackTrace();
            // Xử lý ngoại lệ nếu cần thiết
        }
        return null;
    }
}