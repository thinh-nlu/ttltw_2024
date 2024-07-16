package dao;

import database.DBConnect;
import model.Address;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class AddressDAO {
    private String query = "";
    private PreparedStatement ps;
    private ResultSet rs;
    private final Connection con;

    public AddressDAO(Connection con) {
        this.con = con;
    }

    public Address getAddressById(int addressId) {
        Address address = null;
        query = "SELECT id, user_id, first_name, last_name, address, method_payment, email, contact FROM address WHERE id = ?";
        try {
            ps = con.prepareStatement(query);
            ps.setInt(1, addressId);
            rs = ps.executeQuery();
            if (rs.next()) {
                address = new Address();
                address.setId(rs.getInt(1));
                address.setUserId(rs.getInt(2));
                address.setFirstName(rs.getString(3));
                address.setLastName(rs.getString(4));
                address.setAddress(rs.getString(5));
                address.setPaymentMethod(rs.getString(6));
                address.setEmail(rs.getString(7));
                address.setContact(rs.getString(8));
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return address;
    }


    public boolean insertToAddress(Address d) {
        boolean isAdd = false;
        query = "INSERT INTO address(user_id, first_name, last_name, address, method_payment, email, contact) VALUES (?,?,?,?,?,?,?)";
        try {
            ps = con.prepareStatement(query);
            ps.setInt(1, d.getUserId());
            ps.setString(2, d.getFirstName());
            ps.setString(3, d.getLastName());
            ps.setString(4, d.getAddress());
            ps.setString(5, d.getPaymentMethod());
            ps.setString(6, d.getEmail());
            ps.setString(7, d.getContact());

            int i = ps.executeUpdate();
            isAdd = i == 1;
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return isAdd;
    }
    public boolean updateAddress(Address address) {
        String query = "UPDATE address SET user_id = ?, first_name = ?, last_name = ?, address = ?, method_payment = ?, email = ?, contact = ? WHERE id = ?";
        try {
            PreparedStatement ps = con.prepareStatement(query);
            ps.setInt(1, address.getUserId());
            ps.setString(2, address.getFirstName());
            ps.setString(3, address.getLastName());
            ps.setString(4, address.getAddress());
            ps.setString(5, address.getPaymentMethod());
            ps.setString(6, address.getEmail());
            ps.setString(7, address.getContact());
            ps.setInt(8, address.getId());

            int rowsAffected = ps.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }



    public List<Address> getAllAddress() {
        List<Address> list = new ArrayList<>();
        Address a;
        query = "SELECT id, user_id, first_name, last_name, address, method_payment, email, contact, isSelect FROM address";
        try {
            ps = con.prepareStatement(query);
            rs = ps.executeQuery();
            while(rs.next()) {
                a = new Address();
                a.setId(rs.getInt(1));
                a.setUserId(rs.getInt(2));
                a.setFirstName(rs.getString(3));
                a.setLastName(rs.getString(4));
                a.setAddress(rs.getString(5));
                a.setPaymentMethod(rs.getString(6));
                a.setEmail(rs.getString(7));
                a.setContact(rs.getString(8));
                a.setIsSelect(rs.getInt(9));
                list.add(a);
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return list;
    }
    public List<Address> getAddressesByUserId(int userId) {
        List<Address> addresses = new ArrayList<>();
        query = "SELECT id, user_id, first_name, last_name, address, method_payment, email, contact, isSelect FROM address WHERE user_id = ?";
        try {
            ps = con.prepareStatement(query);
            ps.setInt(1, userId);
            rs = ps.executeQuery();
            while(rs.next()) {
                Address a = new Address();
                a.setId(rs.getInt(1));
                a.setUserId(rs.getInt(2));
                a.setFirstName(rs.getString(3));
                a.setLastName(rs.getString(4));
                a.setAddress(rs.getString(5));
                a.setPaymentMethod(rs.getString(6));
                a.setEmail(rs.getString(7));
                a.setContact(rs.getString(8));
                a.setIsSelect(rs.getInt(9));
                addresses.add(a);
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return addresses;
    }



    public Address getAddressByUserId(int id) {
        Address a = null;
        query = "SELECT id, user_id, first_name, last_name, address, method_payment, email, contact, isSelect FROM address WHERE user_id = ?";
        try {
            ps = con.prepareStatement(query);
            ps.setInt(1, id);
            rs = ps.executeQuery();
            while(rs.next()) {
                a = new Address();
                a.setId(rs.getInt(1));
                a.setUserId(rs.getInt(2));
                a.setFirstName(rs.getString(3));
                a.setLastName(rs.getString(4));
                a.setAddress(rs.getString(5));
                a.setPaymentMethod(rs.getString(6));
                a.setEmail(rs.getString(7));
                a.setContact(rs.getString(8));
                a.setIsSelect(rs.getInt(9));
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return a;
    }
    public boolean deleteAddressById(int addressId) {
        boolean isDeleted = false;
        query = "DELETE FROM address WHERE id = ?";
        try {
            ps = con.prepareStatement(query);
            ps.setInt(1, addressId);
            int result = ps.executeUpdate();
            isDeleted = result == 1;
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return isDeleted;
    }

    public boolean updateIsSelect(int addressId, int userId) {
        Connection conn = null;
        PreparedStatement ps1 = null;
        PreparedStatement ps2 = null;
        boolean isSuccess = false;

        try {
            conn = con;
            // Start transaction
            conn.setAutoCommit(false);

            // Update all addresses of the user to set isSelect to 0
            String query1 = "UPDATE address SET isSelect = 0 WHERE user_id = ?";
            ps1 = conn.prepareStatement(query1);
            ps1.setInt(1, userId);
            ps1.executeUpdate();

            // Update the specific address to set isSelect to 1
            String query2 = "UPDATE address SET isSelect = 1 WHERE id = ?";
            ps2 = conn.prepareStatement(query2);
            ps2.setInt(1, addressId);
            int rowsAffected = ps2.executeUpdate();

            // Commit transaction
            conn.commit();
            isSuccess = rowsAffected > 0;

        } catch (SQLException e) {
            try {
                if (conn != null) {
                    // Rollback transaction in case of error
                    conn.rollback();
                }
            } catch (SQLException rollbackEx) {
                throw new RuntimeException("Failed to rollback transaction", rollbackEx);
            }
            throw new RuntimeException("Failed to update isSelect field", e);
        } finally {
            try {
                if (ps1 != null) ps1.close();
                if (ps2 != null) ps2.close();
                if (conn != null) conn.setAutoCommit(true);
            } catch (SQLException e) {
                throw new RuntimeException("Failed to close resources", e);
            }
        }

        return isSuccess;
    }
    public Address getSelectedAddressByUserId(int userId) {
        Address selectedAddress = null;
        query = "SELECT id, user_id, first_name, last_name, address, method_payment, email, contact, isSelect FROM address WHERE user_id = ? AND isSelect = 1";
        try {
            ps = con.prepareStatement(query);
            ps.setInt(1, userId);
            rs = ps.executeQuery();
            if (rs.next()) {
                selectedAddress = new Address();
                selectedAddress.setId(rs.getInt(1));
                selectedAddress.setUserId(rs.getInt(2));
                selectedAddress.setFirstName(rs.getString(3));
                selectedAddress.setLastName(rs.getString(4));
                selectedAddress.setAddress(rs.getString(5));
                selectedAddress.setPaymentMethod(rs.getString(6));
                selectedAddress.setEmail(rs.getString(7));
                selectedAddress.setContact(rs.getString(8));
                selectedAddress.setIsSelect(rs.getInt(9));
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return selectedAddress;
    }



    public static void main(String[] args) {
        AddressDAO dao = new AddressDAO(DBConnect.getConnection());
        dao.getAddressByUserId(1);
    }

}
