package dao;

import model.Product;
import model.User;
import model.Wishlist;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class WishlistDAO {
    private String query = "";
    private PreparedStatement ps;
    private ResultSet rs;
    private final Connection con;

    public WishlistDAO(Connection con) {
        this.con = con;
    }

    public boolean addWishlist(Wishlist w) {
        boolean isAdd = false;
        query = "insert into wishlist(user_id, product_id, date) " +
                "values(?,?,NOW())";
        try {
            ps = con.prepareStatement(query);
            ps.setInt(1, w.getUser_id());
            ps.setInt(2, w.getProduct_id());
            int i = ps.executeUpdate();
            isAdd = i == 1;
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return isAdd;
    }
    public boolean removeProductFromWishlist(int wishlistId) {
        boolean isRemoved = false;
        query = "delete from wishlist where id = ?";
        try {
            ps = con.prepareStatement(query);
            ps.setInt(1, wishlistId);
            int i = ps.executeUpdate();
            isRemoved = i == 1;
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return isRemoved;
    }


    public List<Wishlist> getAllWishlistByUserID(int userId) {
        List<Wishlist> list = new ArrayList<>();
        Wishlist w;
        query = "SELECT id, user_id, product_id, date FROM wishlist WHERE user_id = ?";
        try {
            ps = con.prepareStatement(query);
            ps.setInt(1, userId);
            rs = ps.executeQuery();
            while (rs.next()) {
                w = new Wishlist();
                w.setId(rs.getInt(1));
                w.setUser_id(rs.getInt(2));
                w.setProduct_id(rs.getInt(3));
                w.setTimestamp(rs.getTimestamp(4));
                list.add(w);
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return list;
    }




}

