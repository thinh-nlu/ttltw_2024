package controller;

import dao.LogDAO;
import dao.ProductDAO;
import database.DBConnect;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import model.IPAddressUtil;
import model.Log;
import model.Product;
import model.User;

import java.io.File;
import java.io.IOException;

@WebServlet("/add_product")
@MultipartConfig
public class AddProduct extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String title = req.getParameter("product_title");
        String price = req.getParameter("product_price");
        String unit = req.getParameter("unit");
        String category = req.getParameter("product_category");
        String keyword = req.getParameter("product_keyword");
        String quantity = req.getParameter("quantity");
        String unitPrice = req.getParameter("unit_price");
        String descript = req.getParameter("product_descrip");
        HttpSession session = req.getSession();
        User user = (User) session.getAttribute("success");
        Part part = req.getPart("product_image");
        String image = part.getSubmittedFileName();
        String path = getServletContext().getRealPath("/DataWeb/");
        File file = new File(path);
        if(!file.exists()) file.mkdirs();
        part.write(path + File.separator + image);

        Product p = new Product(title,price,unit,image,category,keyword,quantity,"con",unitPrice,descript);
        System.out.println(p);
        ProductDAO dao = new ProductDAO(DBConnect.getConnection());
        LogDAO logDAO = new LogDAO(DBConnect.getConnection());
        String ip = IPAddressUtil.getPublicIPAddress();
        boolean isAdd = dao.addProduct(p);

        if (isAdd) {
            logDAO.insertLog(new Log(Log.ALERT, user.getId(),ip,"Quản Lí","Thêm sản phẩm "+p.getTitle()+" mới thành công",0));
            session.setAttribute("addProduct","Thêm sản phẩm thành công");
            resp.sendRedirect("admin/insert-product.jsp");

        } else {
            logDAO.insertLog(new Log(Log.ALERT, user.getId(),ip,"Quản Lí","Thêm 1 sản phẩm "+p.getTitle()+" thất bại",0));
            session.setAttribute("addProduct","Thêm sản phẩm thất bại");
            resp.sendRedirect("admin/insert-product.jsp");
        }

    }
}
