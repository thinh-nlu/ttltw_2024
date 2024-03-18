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

@WebServlet("/blockUser")
public class BlockUser extends HttpServlet {
    UserDAO dao = new UserDAO(DBConnect.getConnection());

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        int id  = Integer.parseInt(req.getParameter("id"));
        System.out.println(id);
        User user = dao.getUserById(id);
        boolean isBlock = false;
        if(user==null) return;
        if(user.getIsActive().equals("1")) {
            isBlock = dao.blockUser("0",id);
        } else {
            isBlock = dao.blockUser("1",id);
        }
        resp.sendRedirect("admin/list-user.jsp");
    }
}
