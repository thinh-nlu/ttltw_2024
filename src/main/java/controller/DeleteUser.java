package controller;

import dao.LogDAO;
import dao.UserDAO;
import database.DBConnect;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.IPAddressUtil;
import model.Log;
import model.User;

import java.io.IOException;

@WebServlet("/deleteUser")
public class DeleteUser extends HttpServlet {
    UserDAO dao = new UserDAO(DBConnect.getConnection());

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        int id = Integer.parseInt(req.getParameter("id"));
        User user = dao.getUserById(id);
        HttpSession session = req.getSession();
        User user1 = (User) session.getAttribute("success");
        LogDAO logDAO = new LogDAO(DBConnect.getConnection());
        String ip = IPAddressUtil.getPublicIPAddress();
        if (user!=null) {
            boolean isDelete = dao.deleteUser(id);
            if(isDelete) {
                session.setAttribute("deleteSuccess","Đã Xóa Thành Công");
                logDAO.insertLog(new Log(Log.DANGER, user1.getId(),ip,"Quản Lí","Xóa tài khoản"+" "+user.getName()+" "+"thành công",0));
            } else {
                session.setAttribute("deleteFailed","Hệ Thống Đang Gap Lỗi");
                logDAO.insertLog(new Log(Log.DANGER, user1.getId(),ip,"Quản Lí","Xóa tài khoản"+" "+user.getName()+" "+"thất bại",0));
            }
        }
        resp.sendRedirect("admin/list-user.jsp");
    }
}
