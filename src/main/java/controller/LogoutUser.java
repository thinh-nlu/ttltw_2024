package controller;

import dao.LogDAO;
import database.DBConnect;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.IPAddressUtil;
import model.Log;
import model.User;

import java.io.IOException;

@WebServlet("/logout")
public class LogoutUser extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session1 = req.getSession();
        LogDAO logDao = new LogDAO(DBConnect.getConnection());
        String ip = IPAddressUtil.getPublicIPAddress();


        Cookie[] cookies = req.getCookies();
        if (cookies != null) {
            for (Cookie cookie : cookies) {
                cookie.setValue(null);
                cookie.setMaxAge(0);
                resp.addCookie(cookie);
            }
        }
        HttpSession session = req.getSession(false);
        User user = (User) session.getAttribute("success");
        logDao.insertLog(new Log(Log.INFO, user.getId(),ip,"Đăng xuất","Đăng xuất thành công ",0));
        if (session != null) {
            session.invalidate();
        }

        resp.sendRedirect("index.jsp");
    }
}
