package dao;

import database.DBConnect;
import model.Product;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class ProductDAO {
    private String query = "";
    private PreparedStatement ps;
    private ResultSet rs;
    private final Connection con;

    public ProductDAO(Connection con) {
        this.con = con;
    }

    public boolean addProduct(Product p) {
        boolean isAdd = false;
        query = "insert into products(title,image,price,unit,categoryId,keyword,status,insertDate,quantity,unitPrice,descrip) " +
                "values(?,?,?,?,?,?,?,NOW(),?,?,?)";
        try {
            ps = con.prepareStatement(query);
            ps.setString(1,p.getTitle());
            ps.setString(2,p.getImage());
            ps.setString(3,p.getPrice());
            ps.setString(4,p.getUnit());
            ps.setString(5,p.getCategoryId());
            ps.setString(6,p.getKeyword());
            ps.setString(7,p.getStatus());
            ps.setString(8,p.getQuantity());
            ps.setString(9,p.getUnitPrice());
            ps.setString(10,p.getDescription());
            int i = ps.executeUpdate();

            isAdd = i == 1;
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }

        return isAdd;
    }

    public List<Product> searchProduct(String title) {
        List<Product> list = new ArrayList<>();
        Product p;
        query = "SELECT id, title, image, price, unit, categoryId, keyword, status, insertDate, quantity, unitPrice, descrip FROM products WHERE title LIKE ?";
        try {
            ps = con.prepareStatement(query);
            ps.setString(1, "%" + title + "%");
            rs = ps.executeQuery();
            while (rs.next()) {
                p = new Product();
                p.setId(rs.getInt(1));
                p.setTitle(rs.getString(2));
                p.setImage(rs.getString(3));
                p.setPrice(rs.getString(4));
                p.setUnit(rs.getString(5));
                p.setCategoryId(rs.getString(6));
                p.setKeyword(rs.getString(7));
                p.setStatus(rs.getString(8));
                p.setDateInsert(rs.getTimestamp(9));
                p.setQuantity(rs.getString(10));
                p.setUnitPrice(rs.getString(11));
                p.setDescription(rs.getString(12));
                list.add(p);
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return list;
    }


    public List<Product> getAllProduct() {
        List<Product> products = new ArrayList<>();
        Product p = null;
        query = "SELECT id, title, image, price, unit, categoryId, keyword, status, insertDate, quantity, unitPrice, descrip FROM products";
        try {
            ps = con.prepareStatement(query);
            rs = ps.executeQuery();
            while (rs.next()){
                p = new Product();
                p.setId(rs.getInt(1));
                p.setTitle(rs.getString(2));
                p.setImage(rs.getString(3));
                p.setPrice(rs.getString(4));
                p.setUnit(rs.getString(5));
                p.setCategoryId(rs.getString(6));
                p.setKeyword(rs.getString(7));
                p.setStatus(rs.getString(8));
                p.setDateInsert(rs.getTimestamp(9));
                p.setQuantity(rs.getString(10));
                p.setUnitPrice(rs.getString(11));
                p.setDescription(rs.getString(12));
                products.add(p);
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return products;
    }

    public List<Product> getRecords(int start, int total) {
        List<Product> products = new ArrayList<>();
        Product p = null;
        query = "SELECT id, title, image, price, unit, categoryId, keyword, status, insertDate, quantity, unitPrice, descrip FROM products LIMIT ?, ?";
        try {
            ps = con.prepareStatement(query);
            ps.setInt(1, start - 1);
            ps.setInt(2, total);
            rs = ps.executeQuery();
            while (rs.next()){
                p = new Product();
                p.setId(rs.getInt(1));
                p.setTitle(rs.getString(2));
                p.setImage(rs.getString(3));
                p.setPrice(rs.getString(4));
                p.setUnit(rs.getString(5));
                p.setCategoryId(rs.getString(6));
                p.setKeyword(rs.getString(7));
                p.setStatus(rs.getString(8));
                p.setDateInsert(rs.getTimestamp(9));
                p.setQuantity(rs.getString(10));
                p.setUnitPrice(rs.getString(11));
                p.setDescription(rs.getString(12));
                products.add(p);
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return products;
    }


    public Product getProductById(int id) {
        Product product = null;
        query = "SELECT id, title, image, price, unit, categoryId, keyword, status, insertDate, quantity, unitPrice, descrip FROM products WHERE id = ?";
        try {
            ps = con.prepareStatement(query);
            ps.setInt(1, id);
            rs = ps.executeQuery();
            while (rs.next()){
                product = new Product();
                product.setId(rs.getInt(1));
                product.setTitle(rs.getString(2));
                product.setImage(rs.getString(3));
                product.setPrice(rs.getString(4));
                product.setUnit(rs.getString(5));
                product.setCategoryId(rs.getString(6));
                product.setKeyword(rs.getString(7));
                product.setStatus(rs.getString(8));
                product.setDateInsert(rs.getTimestamp(9));
                product.setQuantity(rs.getString(10));
                product.setUnitPrice(rs.getString(11));
                product.setDescription(rs.getString(12));
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return product;
    }


    public boolean updateProduct(Product p) {
        boolean isUpdate = false;
        query = "UPDATE products SET title = ?, price = ?, unit = ?, categoryId = ?, keyword = ?, quantity = ?, unitPrice = ?, descrip = ? WHERE id = ?";
        try {
            ps = con.prepareStatement(query);
            ps.setString(1,p.getTitle());
            ps.setString(2,p.getPrice());
            ps.setString(3,p.getUnit());
            ps.setString(4,p.getCategoryId());
            ps.setString(5,p.getKeyword());
            ps.setString(6,p.getQuantity());
            ps.setString(7,p.getUnitPrice());
            ps.setString(8,p.getDescription());
            ps.setInt(9,p.getId());
            int i = ps.executeUpdate();
            isUpdate = i == 1;
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return isUpdate;
    }

    public boolean deleteProduct(int id) {
        boolean isDelete = false;
        query = "delete from products where id = ?";
        try {
            ps = con.prepareStatement(query);
            ps.setInt(1,id);
            int i = ps.executeUpdate();
            isDelete = i == 1;
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return isDelete;
    }
    public List<Product> getProductsByCategory(String categoryId) {
        List<Product> products = new ArrayList<>();
        query = "SELECT id, title, image, price, unit, categoryId, keyword, status, insertDate, quantity, unitPrice, descrip FROM products WHERE categoryId = ?";
        try (PreparedStatement ps = con.prepareStatement(query)) {
            ps.setString(1, categoryId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Product product = new Product();
                    product.setId(rs.getInt(1));
                    product.setTitle(rs.getString(2));
                    product.setImage(rs.getString(3));
                    product.setPrice(rs.getString(4));
                    product.setUnit(rs.getString(5));
                    product.setCategoryId(rs.getString(6));
                    product.setKeyword(rs.getString(7));
                    product.setStatus(rs.getString(8));
                    product.setDateInsert(rs.getTimestamp(9));
                    product.setQuantity(rs.getString(10));
                    product.setUnitPrice(rs.getString(11));
                    product.setDescription(rs.getString(12));
                    products.add(product);
                }
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return products;
    }


    public static void main(String[] args) {
        ProductDAO dao = new ProductDAO(DBConnect.getConnection());
        List<Product> list = dao.searchProduct("bac ha");
        System.out.println(list);
    }

    public boolean updateQuantity(Product product, int quantity) {
        boolean isUpdate = false;
        query = "update products set quantity = ? where id = ?";
        try {
            ps = con.prepareStatement(query);
            ps.setInt(1,Integer.parseInt(product.getQuantity()) - quantity);
            ps.setInt(2,product.getId());
            int i = ps.executeUpdate();
            isUpdate = i == 1;
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return isUpdate;
    }
    public int CountProducts() {
        int rowCount = 0;
        query = "select count(*) from products";
        try {
            ps = con.prepareStatement(query);
            rs = ps.executeQuery();
            if (rs.next()) {
                rowCount = rs.getInt(1);
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return rowCount;
    }
}
