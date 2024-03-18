package controller;

import dao.ProductDAO;
import database.DBConnect;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import model.Product;

import java.io.File;
import java.io.IOException;
@WebServlet("/edit_product")
@MultipartConfig
public class UpdateProduct extends HttpServlet {
    ProductDAO dao = new ProductDAO(DBConnect.getConnection());
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        int id = Integer.parseInt(req.getParameter("id"));
        Product productFromId = dao.getProductById(id);
        String title = req.getParameter("product_title");
        String price = req.getParameter("product_price");
        String unit = req.getParameter("unit");
        String category = req.getParameter("product_category");
        String keyword = req.getParameter("product_keyword");
        String quantity = req.getParameter("quantity");
        String unitPrice = req.getParameter("unit_price");
        Part part = req.getPart("product_image");
        String image = part.getSubmittedFileName();
        String path = getServletContext().getRealPath("/DataWeb/");
        File file = new File(path);
        if(!file.exists()) file.mkdirs();
        part.write(path + File.separator + image);

        Product p = new Product(id,title,price,unit,productFromId.getImage(),category,keyword,productFromId.getTimestamp(),quantity,productFromId.getStatus(),unitPrice);
        System.out.println(p);
        HttpSession session = req.getSession();
        if(checkChangingProduct(p,id)) {
            boolean isUpdate = dao.updateProduct(p);
            if (isUpdate) {
                session.setAttribute("updateProductMes","Cập nhật sản phẩm thành công");
                resp.sendRedirect("admin/list-products.jsp");
            } else {
                session.setAttribute("updateProductMes","Cập nhật sản phẩm thất bại");
                resp.sendRedirect("admin/list-products.jsp");
            }
        } else {
            session.setAttribute("updateProductMes","Chưa có dữ liệu nào được cập nhật");
            resp.sendRedirect("admin/list-products.jsp");
        }
    }

    private boolean checkChangingProduct(Product p, int id) {
        Product product = dao.getProductById(id);
        return !product.equals(p);
    }
}
