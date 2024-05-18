    package controller;
    import com.google.gson.Gson;
    import dao.ProductDAO;
    import database.DBConnect;
    import jakarta.servlet.annotation.WebServlet;
    import jakarta.servlet.http.*;
    import model.Product;
    import java.io.IOException;
    import java.util.ArrayList;
    import java.util.List;
    import jakarta.servlet.ServletException;
    import jakarta.servlet.annotation.WebServlet;
    import jakarta.servlet.http.HttpServlet;

    @WebServlet("/filterProduct")
    public class FilterProduct extends HttpServlet {
        protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
            String categoryId = request.getParameter("categoryId");
            HttpSession session = request.getSession();
            // lay san pham
            ProductDAO dao = new ProductDAO(DBConnect.getConnection());
            List<Product> filterProduct = dao.getProductsByCategory(categoryId);

            String jsonResponse = new Gson().toJson(filterProduct);

            response.setContentType("application/json");
            response.setCharacterEncoding("UTF-8");
            response.getWriter().write(jsonResponse);


            // phan loai san pham theo categoryId
//            List<Product> filterProduct = null;
//            if (filterProduct == null) {
//                filterProduct = new ArrayList<>();
//                filterProduct.clear();
//            }

    //        List<Product> filterProduct = new ArrayList<>();
    //        filterProduct.clear();
//            filterProduct = dao.getProductsByCategory(categoryId);
//            session.setAttribute("searchListSuccess", filterProduct);
           response.getWriter().write(jsonResponse);
//            System.out.println(jsonResponse);

        }
    }