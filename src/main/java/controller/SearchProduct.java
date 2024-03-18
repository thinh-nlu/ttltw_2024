package controller;

import dao.ProductDAO;
import dao.UserDAO;
import database.DBConnect;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.Product;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

@WebServlet("/searchProduct")
public class SearchProduct extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String keyword = req.getParameter("keyword");
        ProductDAO dao = new ProductDAO(DBConnect.getConnection());
        List<Product> display = dao.searchProduct(keyword);
        HttpSession session = req.getSession();
        if (display.isEmpty()) {
            session.setAttribute("searchListFailed", "Không tìm thấy sản phẩm");
        } else {
            session.setAttribute("searchListSuccess", display);
        }
        resp.sendRedirect("gallery.jsp");
    }

}

