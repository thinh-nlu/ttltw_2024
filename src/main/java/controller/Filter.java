package controller;

import com.google.gson.Gson;
import dao.ProductDAO;
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
import java.util.List;

@WebServlet("/filter")
public class Filter extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String categoryId = request.getParameter("categoryId");

        ProductDAO dao = new ProductDAO(DBConnect.getConnection());
        List<Product> filter = dao.getProductsByCategory(categoryId);

        String jsonResponse = new Gson().toJson(filter);

        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        response.getWriter().write(jsonResponse);
    }


    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        if ("category".equals(action)) {
            String categoryId = request.getParameter("categoryId");
            List<Product> filterProduct = new ArrayList<>();
            ProductDAO dao = new ProductDAO(DBConnect.getConnection());
            filterProduct = dao.getProductsByCategory(categoryId);
            String json = new Gson().toJson(filterProduct);
            response.setContentType("application/json");
            response.setCharacterEncoding("UTF-8");
            response.getWriter().write(json);
        } else if ("bestSelling".equals(action)) {
            int limit = Integer.parseInt(request.getParameter("limit"));
            List<Product> bestSellingProducts = new ArrayList<>();
            ProductDAO dao = new ProductDAO(DBConnect.getConnection());
            bestSellingProducts = dao.getBestSellingProducts(limit);
            String json = new Gson().toJson(bestSellingProducts);
            response.setContentType("application/json");
            response.setCharacterEncoding("UTF-8");
            response.getWriter().write(json);
        } else if ("discounted".equals(action)) {
            List<Product> discountedProducts = new ArrayList<>();
            ProductDAO dao = new ProductDAO(DBConnect.getConnection());
            discountedProducts = dao.getDiscountedProducts();
            String json = new Gson().toJson(discountedProducts);
            response.setContentType("application/json");
            response.setCharacterEncoding("UTF-8");
            response.getWriter().write(json);
        }
    }
}
