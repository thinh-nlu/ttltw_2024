package controller;

import dao.UserDAO;
import database.DBConnect;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import model.User;

import java.io.IOException;

@WebServlet("/autoLogin")
public class AutoLogin extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        Cookie[] cookies = request.getCookies();
        if (cookies != null) {
            String username = null;
            String passwordHash = null;
            for (Cookie cookie : cookies) {
                if (cookie.getName().equals("cookieUser")) {
                    username = cookie.getValue();
                } else if (cookie.getName().equals("cookiePass")) {
                    passwordHash = cookie.getValue();
                }
            }
            if (username != null && passwordHash != null) {
                UserDAO dao = new UserDAO(DBConnect.getConnection());
                User user = dao.getUserByUsername(username);
                String passwordHashFromDB = user.getPassword();
                if (passwordHash.equals(passwordHashFromDB)) {
                    HttpSession session = request.getSession();
                    session.setAttribute("success", user);
                }
            }
        }
        response.sendRedirect("index.jsp");
    }
}