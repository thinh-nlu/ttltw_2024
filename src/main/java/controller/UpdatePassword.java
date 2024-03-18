package controller;

import dao.UserDAO;
import database.DBConnect;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.User;

import java.io.IOException;
import java.nio.charset.StandardCharsets;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;

@WebServlet("/updatePassword")
public class UpdatePassword extends HttpServlet {

    UserDAO dao = new UserDAO(DBConnect.getConnection());

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        int id = Integer.parseInt(req.getParameter("id"));
        String oldpassword = req.getParameter("password");
        String newpassword = req.getParameter("newpassword");
        String confirmpassword = req.getParameter("confirmpassword");
        User u = dao.getUserById(id);

        HttpSession session = req.getSession();
        if (oldpassword == null || oldpassword.isEmpty() || newpassword == null || newpassword.isEmpty() || confirmpassword == null || confirmpassword.isEmpty()) {

            session.setAttribute("failedUpdatePassword", "Vui lòng nhập đầy đủ thông tin");
            resp.sendRedirect("tien_ich/my-account.jsp");
            return;
        } else if (newpassword.length() <= 7) {
            session.removeAttribute("failedUpdatePassword");
            session.setAttribute("failedUpdatePassword", "Vui lòng nhập mật khẩu mới có ít nhất 8 kí tự");
            resp.sendRedirect("tien_ich/my-account.jsp");
            return;
        }else if(!newpassword.equals(confirmpassword)){
            session.removeAttribute("failedUpdatePassword");
            session.setAttribute("failedUpdatePassword", "Mật khẩu xác nhận không khớp với mật khẩu mới");
            resp.sendRedirect("tien_ich/my-account.jsp");
            return;
        }else if (u.getPassword().equals(hashPassword(oldpassword))){
            String newpassword_h = hashPassword(newpassword);
            u.setPassword(newpassword_h);

        }else {
            session.setAttribute("failedUpdatePassword", "Mật khẩu cũ không khớp");
            resp.sendRedirect("tien_ich/my-account.jsp");
            return;

        }
        boolean isUpdate = dao.updatePassword(u);
        if (isUpdate) {
            session.setAttribute("successUpdatePassword", "Cập nhật mật khẩu thành công");
            session.setAttribute("success", u);
            session.removeAttribute("failedUpdatePassword");
            resp.sendRedirect("tien_ich/my-account.jsp");
        } else {
            session.setAttribute("failedUpdatePassword", "Cập nhật mật khẩu thất bại");
            resp.sendRedirect("tien_ich/my-account.jsp");
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
