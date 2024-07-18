package dao;

import database.DBConnect;
import model.Product;
import model.Warehouse;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class WarehouseDAO {
    private String query = "";
    private PreparedStatement ps;
    private ResultSet rs;
    private final Connection con;

    public WarehouseDAO(Connection con) {
        this.con = con;
    }

    public boolean addWareHouse(Warehouse p) {
        boolean isAdd = false;
        query = "insert into warehouse(product_id,quantity,insertDate) " +
                "values(?,?,NOW())";
        try {
            ps = con.prepareStatement(query);
            ps.setInt(1,p.getProductId());
            ps.setInt(2,p.getQuantity());
            int i = ps.executeUpdate();

            isAdd = i == 1;
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }

        return isAdd;
    }
    public List<Warehouse> getAllWarehouses() {
        List<Warehouse> warehouses = new ArrayList<>();
        query = "SELECT * FROM warehouse";
        try {
            ps = con.prepareStatement(query);
            rs = ps.executeQuery();

            while (rs.next()) {
                Warehouse warehouse = new Warehouse();
                warehouse.setId(rs.getInt("id"));
                warehouse.setProductId(rs.getInt("product_id"));
                warehouse.setQuantity(rs.getInt("quantity"));
                warehouse.setTimestamp(rs.getTimestamp("insertDate"));
                warehouses.add(warehouse);
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        } finally {
            try {
                if (rs != null) rs.close();
                if (ps != null) ps.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }

        return warehouses;
    }

    public static void main(String[] args) {
        WarehouseDAO warehouseDAO = new WarehouseDAO(DBConnect.getConnection());
        System.out.println(warehouseDAO.getAllWarehouses());

    }

}
