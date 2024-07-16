package dao;

import database.DBConnect;
import model.Order;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class OrderDAO {
    private String query = "";
    private PreparedStatement ps;
    private ResultSet rs;
    private final Connection con;

    public OrderDAO(Connection con) {
        this.con = con;
    }

    public boolean insertOrder(Order o) {
        boolean isAdd = false;
        query = "insert into orders(user_id, invoice_number, amount_due, order_date, order_status, address_id) " +
                "value(?,?,?,?,?,?)";
        try {
            ps = con.prepareStatement(query);
            ps.setInt(1,o.getUserId());
            ps.setString(2,o.getInvoiceNumber());
            ps.setString(3,o.getAmountDue());
            ps.setTimestamp(4,o.getOrderDate());
            ps.setString(5,o.getOrderStatus());
            ps.setString(5,o.getOrderStatus());
            ps.setInt(6,o.getAddressId());
            int i = ps.executeUpdate();
            isAdd = i == 1;
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return isAdd;
    }
    public int getOrderRowCount() {
        int rowCount = 0;
        query = "select count(*) from orders";
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

    public Order getOrderByInvoiceNumber(String invoiceNumber) {
        Order o = null;
        query = "SELECT id, user_id, invoice_number, amount_due, order_date, order_status, address_id, order_shipping_status FROM orders WHERE invoice_number = ?";
        try {
            ps = con.prepareStatement(query);
            ps.setString(1, invoiceNumber);
            rs = ps.executeQuery();
            while (rs.next()) {
                o = new Order();
                o.setId(rs.getInt("id"));
                o.setUserId(rs.getInt("user_id"));
                o.setInvoiceNumber(rs.getString("invoice_number"));
                o.setAmountDue(rs.getString("amount_due"));
                o.setOrderDate(rs.getTimestamp("order_date"));
                o.setOrderStatus(rs.getString("order_status"));
                o.setAddressId(rs.getInt("address_id"));
                o.setAddressShipStatus(rs.getString("order_shipping_status"));
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return o;
    }


    public Order getOrderById(int id) {
        Order o = null;
        query = "SELECT id, user_id, invoice_number, amount_due, order_date, order_status, order_shipping_status FROM orders WHERE id = ?";
        try {
            ps = con.prepareStatement(query);
            ps.setInt(1, id);
            rs = ps.executeQuery();
            while (rs.next()) {
                o = new Order();
                o.setId(rs.getInt("id"));
                o.setUserId(rs.getInt("user_id"));
                o.setInvoiceNumber(rs.getString("invoice_number"));
                o.setAmountDue(rs.getString("amount_due"));
                o.setOrderDate(rs.getTimestamp("order_date"));
                o.setOrderStatus(rs.getString("order_status"));
                o.setAddressShipStatus(rs.getString("order_shipping_status"));
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return o;
    }



    public boolean updateStatus(int orderId) {
        boolean isUpdate = false;
        query = "update orders set order_status = ? where id = ?";
        try {
            ps = con.prepareStatement(query);
            ps.setString(1,"Đã thanh toán");
            ps.setInt(2,orderId);
            int i = ps.executeUpdate();
            isUpdate = i == 1;
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return isUpdate;
    }
    public boolean updateShipStatus(int orderId) {
        boolean isUpdate = false;
        query = "update orders set order_shipping_status = ? where id = ?";
        try {
            ps = con.prepareStatement(query);
            ps.setString(1,"Chờ xác nhận");
            ps.setInt(2,orderId);
            int i = ps.executeUpdate();
            isUpdate = i == 1;
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return isUpdate;
    }

    public List<Order> getListOrderByUser(int userId) {
        List<Order> list = new ArrayList<>();
        Order o;
        query = "SELECT id, user_id, invoice_number, amount_due, order_date, order_status, address_id, order_shipping_status FROM orders WHERE user_id = ?";
        try {
            ps = con.prepareStatement(query);
            ps.setInt(1, userId);
            rs = ps.executeQuery();
            while(rs.next()) {
                o = new Order();
                o.setId(rs.getInt("id"));
                o.setUserId(rs.getInt("user_id"));
                o.setInvoiceNumber(rs.getString("invoice_number"));
                o.setAmountDue(rs.getString("amount_due"));
                o.setOrderDate(rs.getTimestamp("order_date"));
                o.setOrderStatus(rs.getString("order_status"));
                o.setAddressId(rs.getInt("address_id"));
                o.setAddressShipStatus(rs.getString("order_shipping_status"));
                list.add(o);
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return list;
    }

    public List<Order> getAllOrder() {
        List<Order> list = new ArrayList<>();
        Order o;
        query = "select id, user_id, invoice_number, amount_due, order_date, order_status, address_id,order_shipping_status from orders";
        try {
            ps = con.prepareStatement(query);
            rs = ps.executeQuery();
            while(rs.next()) {
                o = new Order();
                o.setId(rs.getInt(1));
                o.setUserId(rs.getInt(2));
                o.setInvoiceNumber(rs.getString(3));
                o.setAmountDue(rs.getString(4));
                o.setOrderDate(rs.getTimestamp(5));
                o.setOrderStatus(rs.getString(6));
                o.setAddressId(rs.getInt(7));
                o.setAddressShipStatus(rs.getString(8));
                list.add(o);
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return list;
    }

    public boolean userHasOrders(int userId,int productId) {
        boolean exists = false;
        query = "SELECT COUNT(*) FROM order_detail od " +
                "JOIN orders o ON od.order_id = o.id " +
                "WHERE o.user_id = ? AND od.product_id = ?";
        try {
            ps = con.prepareStatement(query);
            ps.setInt(1, userId);
            ps.setInt(2, productId);
            rs = ps.executeQuery();
            if (rs.next() && rs.getInt(1) > 0) {
                exists = true;
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return exists;
    }

    public void deleteOrderById(int orderId) {
        String query = "DELETE FROM orders WHERE id = ?";
        try (PreparedStatement ps = this.con.prepareStatement(query)) {
            ps.setInt(1, orderId);
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void CancleOder(int orderId, String status) {
        try {
            String query = "UPDATE orders SET order_shipping_status = ? WHERE id = ?";
            PreparedStatement pstmt = this.con.prepareStatement(query);
            pstmt.setString(1, status);
            pstmt.setInt(2, orderId);
            pstmt.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
    public void ChangeShippingStatus(int orderId, String status) {
        try {
            String query = "UPDATE orders SET order_shipping_status = ? WHERE id = ?";
            PreparedStatement pstmt = this.con.prepareStatement(query);
            pstmt.setString(1, status);
            pstmt.setInt(2, orderId);
            pstmt.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public static void main(String[] args) {
        OrderDAO orderDAO = new OrderDAO(DBConnect.getConnection());


    }

}
