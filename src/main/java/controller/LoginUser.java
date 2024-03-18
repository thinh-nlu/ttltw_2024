package controller;

import com.mysql.cj.Session;
import dao.UserDAO;
import database.DBConnect;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import model.User;

import java.io.IOException;
import java.nio.charset.StandardCharsets;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;

@WebServlet("/login")
public class LoginUser extends HttpServlet {



    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String username = req.getParameter("name").trim();
        String password = req.getParameter("password").trim();
        String remember = req.getParameter("remember");



        UserDAO dao = new UserDAO(DBConnect.getConnection());
        User user = dao.getUserByUsername(username);
        String passwordHash = hashPassword(password);
        HttpSession session = req.getSession();
        session.setMaxInactiveInterval(30 * 60);
        if (user==null) {
            session.setAttribute("failed","Tài khoản không tồn tại");
            resp.sendRedirect("account/login.jsp");
        } else if (user.getIsActive().equals("0")) {
            session.setAttribute("failed","Tài Khoản Đã Bị Chặn");
            resp.sendRedirect("account/login.jsp");
        } else if (!passwordHash.equals(user.getPassword())) {
            session.setAttribute("failed","Mật khẩu không chính xác");
            resp.sendRedirect("account/login.jsp");
        } else {
            Cookie cookieUser = new Cookie("cookieUser",username);
            Cookie cookiePass = new Cookie("cookiePass",password);
            Cookie cookieRem = new Cookie("cookieRem",remember);
            if (remember != null && remember.equals("ON")){
                cookieUser.setMaxAge(60*60*15);
                cookiePass.setMaxAge(60*60*15);
                cookieRem.setMaxAge(60*60*15);
            } else {
                cookieUser.setMaxAge(0);
                cookiePass.setMaxAge(0);
                cookieRem.setMaxAge(0);
            }
            resp.addCookie(cookieUser);
            resp.addCookie(cookiePass);
            resp.addCookie(cookieRem);

            session.setAttribute("success",user);
            resp.sendRedirect("index.jsp");
        }
    }

    public static String hashPassword(String password) {
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
