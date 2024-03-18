package controller;

import dao.UserDAO;
import database.DBConnect;
import jakarta.servlet.RequestDispatcher;
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

/**
 * Servlet implementation class ValidateOtp
 */
@WebServlet("/ValidateOtpVerifyEmail")
public class ValidateOtpVerifyEmail extends HttpServlet {
    private static final long serialVersionUID = 1L;


    protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
    {



        UserDAO dao = new UserDAO(DBConnect.getConnection());
        int value=Integer.parseInt(request.getParameter("otp").trim());
        HttpSession session=request.getSession();
        User user = (User) session.getAttribute("user");
        int otp=(int)session.getAttribute("otp");



        if (value==otp)
        {


            boolean isAdd = dao.registerUser(user);
            if (isAdd) {
                session.setAttribute("successRegister","Đăng kí thành công mời bạn đăng nhập");
                session.removeAttribute("failedRegister");
            } else {
                session.setAttribute("failedRegister","Hệ thống đang gặp lỗi vui lòng thử lại sau");
            }
            request.setAttribute("email", request.getParameter("email"));
            request.setAttribute("status", "success");
            response.sendRedirect("account/registration.jsp");

        }
        else
        {
            request.setAttribute("messagefail","Mã Otp không chính xác");
            response.sendRedirect("account/registration.jsp");
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