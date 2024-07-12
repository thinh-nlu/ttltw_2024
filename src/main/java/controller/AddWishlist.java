package controller;
import dao.LogDAO;
import dao.ProductDAO;
import dao.WishlistDAO;
import database.DBConnect;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.*;

import java.io.IOException;
import java.util.List;

@WebServlet("/add_wishlist")
public class AddWishlist extends HttpServlet {

    WishlistDAO wdao = new WishlistDAO(DBConnect.getConnection());

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession();
        User user = (User) session.getAttribute("success");
        int productId = Integer.parseInt(req.getParameter("productId"));
        ProductDAO productDAO = new ProductDAO( DBConnect.getConnection());
        Product p = productDAO.getProductById(productId);
        LogDAO logDAO = new LogDAO(DBConnect.getConnection());
        String ip = IPAddressUtil.getPublicIPAddress();


        if (user == null) {
            session.setAttribute("failed", "Vui lòng đăng nhập để sử dụng chức năng");
            resp.sendRedirect("account/login.jsp");
            return;
        }
        int userId = user.getId();
        List<Wishlist> existingWishlist = wdao.getAllWishlistByUserID(userId);
        for (Wishlist item : existingWishlist) {
            if (item.getProduct_id() == productId) {
                resp.setContentType("text/html; charset=UTF-8");
                resp.getWriter().println("<script>alert('Sản phẩm đã có trong danh sách yêu thích của bạn!');window.location.href='gallery.jsp';</script>");

                return;
            }
        }

        Wishlist wishlist = new Wishlist(userId, productId);
        boolean isAdd = wdao.addWishlist(wishlist);

        if (isAdd) {
            logDAO.insertLog(new Log(Log.INFO, user.getId(),ip,"Mua Hàng","Thêm sản phẩm "+" "+p.getTitle()+" "+"vào danh sách yêu thích",0));
            resp.sendRedirect("tien_ich/wishlist.jsp");
        }
    }

}
