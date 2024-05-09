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

@WebServlet("/UpdateRole")
public class EditRole extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        int userId = Integer.parseInt(req.getParameter("userId"));
        String newRole = req.getParameter("newRole");
        UserDAO dao = new UserDAO(DBConnect.getConnection());
        User user = dao.getUserById(userId);
        HttpSession session = req.getSession();

        if (user.getIsAdmin().equals(newRole)){
            session.removeAttribute("edit_role_success");
            session.setAttribute("edit_role_fail", "Vui lòng chọn vai trò mới.");
        } else {
            session.removeAttribute("edit_role_fail");
            dao.updateRole(newRole, userId);
            session.setAttribute("edit_role_success", "Cập nhật thành công.");
        }

        resp.sendRedirect("admin/edit_role.jsp");
    }
}


