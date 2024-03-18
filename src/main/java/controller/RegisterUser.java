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

import javax.mail.*;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import java.io.IOException;
import java.nio.charset.StandardCharsets;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;
import java.util.Properties;
import java.util.Random;

@WebServlet("/register")
public class RegisterUser extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        int otpvalue = 0;
        boolean isUserExist = false;
        RequestDispatcher dispatcher = null;
        String username = req.getParameter("name").trim();
        String email = req.getParameter("email");
        String password = req.getParameter("password").trim();
        String rePass = req.getParameter("re_pass").trim();
        String contact = req.getParameter("contact").trim();
        String hashPassword = hashPassword(password);

        User user = new User(username,email,hashPassword,contact,"1","1");
        HttpSession session = req.getSession();
        UserDAO dao = new UserDAO(DBConnect.getConnection());
        List<User> users = dao.getAllUser();
        session.setAttribute("user", user);
        for (User u: users) {
            if (u.getName().equals(username) || u.getEmail().equals(email)) {
                session.setAttribute("failedRegister","Tên đăng nhập hoặc email đã tồn tại");
                resp.sendRedirect("account/registration.jsp");
                isUserExist = true;
            }
        }
        if (!isUserExist) {
            if (password.length() <= 7) {
                session.setAttribute("failedRegister","Vui lòng nhập mật khẩu có ít nhất 8 kí tự");
                resp.sendRedirect("account/registration.jsp");
            } else if (!password.equals(rePass)) {
                session.setAttribute("failedRegister","Mật khẩu không trùng khớp");
                resp.sendRedirect("account/registration.jsp");
            } else if (!validatePhoneNumber(contact)){
                session.setAttribute("failedRegister","Số điện thoại không tồn tại");
                resp.sendRedirect("account/registration.jsp");
            } else {
                // Sending OTP
                Random rand = new Random();
                otpvalue = rand.nextInt(1255650);

                String to = email;

                // Get the session object
                Properties props = new Properties();
                props.put("mail.smtp.host", "smtp.gmail.com");
                props.put("mail.smtp.socketFactory.port", "465");
                props.put("mail.smtp.socketFactory.class", "javax.net.ssl.SSLSocketFactory");
                props.put("mail.smtp.auth", "true");
                props.put("mail.smtp.port", "465");

                Session session1 = Session.getDefaultInstance(props, new javax.mail.Authenticator() {
                    protected PasswordAuthentication getPasswordAuthentication() {
                        return new PasswordAuthentication("tindao2310@gmail.com", "lvqo ninn yqoe ottb");
                    }
                });

                try {
                    MimeMessage message = new MimeMessage(session1);
                    message.setFrom(new InternetAddress(email));
                    message.addRecipient(Message.RecipientType.TO, new InternetAddress(to));
                    message.setSubject("Hello");
                    message.setText("Your OTP is: " + otpvalue);
                    // Send message
                    Transport.send(message);

                } catch (MessagingException e) {
                    throw new RuntimeException(e);
                }
                dispatcher = req.getRequestDispatcher("account/EnterOtpVerifyEmail.jsp");
                req.setAttribute("messagesuccess", "OTP đã được gửi tới email của bạn vui lòng nhập vào bên dưới để xác thực tài khoản của bạn!");
                session.setAttribute("otp", otpvalue);
                session.setAttribute("email", email);
                dispatcher.forward(req, resp);
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

    public boolean validatePhoneNumber(String contact) {
        return contact.matches("\\d{10}");
    }
}
