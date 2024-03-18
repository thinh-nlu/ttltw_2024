package dao;

import database.DBConnect;
import model.Product;
import model.User;

import java.nio.charset.StandardCharsets;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class UserDAO {

    private String query = "";
    private PreparedStatement ps;
    private ResultSet rs;
    private final Connection con;

    public UserDAO(Connection con) {
        this.con = con;
    }

    public boolean registerUser(User user) {
        boolean isAdd = false;
        query = "insert into users(username,email,password,contact,isAdmin,date,isActive) values (?,?,?,?,?,NOW(),?)";
        try {
            ps = con.prepareStatement(query);
            ps.setString(1,user.getName());
            ps.setString(2,user.getEmail());
            ps.setString(3,user.getPassword());
            ps.setString(4,user.getContact());
            ps.setString(5,user.getIsAdmin());
            ps.setString(6, user.getIsActive());
            int i = ps.executeUpdate();
            isAdd = i == 1;
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }

        return isAdd;
    }

    public User getUserByUsername(String username) {
        User user=null;
        query = "SELECT id, username, email, password, contact, isAdmin, date, isActive FROM users WHERE username = ?";
        try {
            ps = con.prepareStatement(query);
            ps.setString(1, username);
            rs = ps.executeQuery();
            while (rs.next()) {
                user = new User();
                user.setId(rs.getInt(1));
                user.setName(rs.getString(2));
                user.setEmail(rs.getString(3));
                user.setPassword(rs.getString(4));
                user.setContact(rs.getString(5));
                user.setIsAdmin(rs.getString(6));
                user.setTimestamp(rs.getTimestamp(7));
                user.setIsActive(rs.getString(8));
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return user;
    }


    public User getUserById(int id) {
        User user=null;
        query = "SELECT id, username, email, password, contact, isAdmin, date, isActive FROM users WHERE id = ?";
        try {
            ps = con.prepareStatement(query);
            ps.setInt(1, id);
            rs = ps.executeQuery();
            if (rs.next()) {
                user = new User();
                user.setId(rs.getInt(1));
                user.setName(rs.getString(2));
                user.setEmail(rs.getString(3));
                user.setPassword(rs.getString(4));
                user.setContact(rs.getString(5));
                user.setIsAdmin(rs.getString(6));
                user.setTimestamp(rs.getTimestamp(7));
                user.setIsActive(rs.getString(8));
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return user;
    }


    public List<User> getAllUser() {
        List<User> users = new ArrayList<>();
        query = "SELECT id, username, email, password, contact, isAdmin, date, isActive FROM users";
        User u = null;
        try {
            ps = con.prepareStatement(query);
            rs = ps.executeQuery();
            while (rs.next()) {
                u = new User();
                u.setId(rs.getInt(1));
                u.setName(rs.getString(2));
                u.setEmail(rs.getString(3));
                u.setPassword(rs.getString(4));
                u.setContact(rs.getString(5));
                u.setIsAdmin(rs.getString(6));
                u.setTimestamp(rs.getTimestamp(7));
                u.setIsActive(rs.getString(8));
                users.add(u);
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return users;
    }
    public List<User> getRecords(int start, int total) {
        List<User> users = new ArrayList<>();
        query = "SELECT id, username, email, password, contact, isAdmin, date, isActive FROM users LIMIT ?, ?";
        User u = null;
        try {
            ps = con.prepareStatement(query);
            ps.setInt(1, start - 1);
            ps.setInt(2, total);
            rs = ps.executeQuery();
            while (rs.next()) {
                u = new User();
                u.setId(rs.getInt(1));
                u.setName(rs.getString(2));
                u.setEmail(rs.getString(3));
                u.setPassword(rs.getString(4));
                u.setContact(rs.getString(5));
                u.setIsAdmin(rs.getString(6));
                u.setTimestamp(rs.getTimestamp(7));
                u.setIsActive(rs.getString(8));
                users.add(u);
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return users;
    }


    public boolean blockUser(String isActive, int id) {
        boolean isUpdate = false;
        query = "UPDATE users SET isActive = ? WHERE id = ?";
        try {
            ps = con.prepareStatement(query);
            ps.setString(1,isActive);
            ps.setInt(2,id);
            int i = ps.executeUpdate();
            isUpdate = i == 1;
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return isUpdate;

    }
    public int getUserCount() {
        int soLuongNguoiDung = 0;
        query = "select count(*) from users";
        try {
            ps = con.prepareStatement(query);
            rs = ps.executeQuery();
            if (rs.next()) {
                soLuongNguoiDung = rs.getInt(1);
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return soLuongNguoiDung;
    }

    public boolean updatePassword(User u) {
        boolean isUpdate = false;
        query = "UPDATE users SET password = ? WHERE id = ?";
        try {
            ps = con.prepareStatement(query);
            ps.setString(1,u.getPassword());
            ps.setInt(2,u.getId());

            int i = ps.executeUpdate();
            isUpdate = i == 1;
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return isUpdate;
    }
    public boolean updateUser(User u) {
        boolean isUpdate = false;
        query = "UPDATE users SET username = ?, email = ?, contact = ? WHERE id = ?";
        try {
            ps = con.prepareStatement(query);
            ps.setString(1,u.getName());
            ps.setString(2,u.getEmail());
            ps.setString(3,u.getContact());
            ps.setInt(4,u.getId());

            int i = ps.executeUpdate();
            isUpdate = i == 1;
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return isUpdate;
    }



    private String hashPassword(String password) {
        try {
            MessageDigest digest = MessageDigest.getInstance("SHA-256");
            byte[] encodedHash = digest.digest(
                    password.getBytes(StandardCharsets.UTF_8));

            StringBuilder hexString = new StringBuilder();
            for (byte b : encodedHash) {
                String hex = Integer.toHexString(0xff & b);
                if (hex.length() == 1) {
                    hexString.append('0');
                }
                hexString.append(hex);
            }
            return hexString.toString();
        } catch (NoSuchAlgorithmException e) {
            e.printStackTrace();
            // Xử lý ngoại lệ nếu cần thiết
        }
        return null;
    }

    public boolean deleteUser(int id) {
        boolean isDelete = false;
        query = "delete from users where id = ?";
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
    public boolean isEmailExists(String email) {
        boolean exists = false;
        query = "select count(*) from users where email = ?";

        try {
            ps = con.prepareStatement(query);
            ps.setString(1, email);
            rs = ps.executeQuery();

            if (rs.next()) {
                int count = rs.getInt(1);
                exists = count > 0;
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }

        return exists;
    }
    public boolean isPasswordNull(String email) {
        boolean isNull = false;
        query = "select password from users where email = ?";

        try {
            ps = con.prepareStatement(query);
            ps.setString(1, email);
            rs = ps.executeQuery();

            if (rs.next()) {
                String password = rs.getString("password");
                isNull = (password == null || password.trim().isEmpty());
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }

        return isNull;
    }
    public boolean isUsernameExist(String username) {
        boolean exists = false;
        query = "select count(*) from users where username = ?";

        try {
            ps = con.prepareStatement(query);
            ps.setString(1, username);
            rs = ps.executeQuery();

            if (rs.next()) {
                int count = rs.getInt(1);
                exists = count > 0;
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }

        return exists;
    }
    public boolean isFbUser(String name) {
        boolean isNull = false;
        query = "select email, password from users where username = ?";

        try {
            ps = con.prepareStatement(query);
            ps.setString(1, name);
            rs = ps.executeQuery();

            if (rs.next()) {
                String email = rs.getString("email");
                String password = rs.getString("password");

                // Kiểm tra xem email và password có đều là null hay không
                isNull = (email == null || email.trim().isEmpty()) && (password == null || password.trim().isEmpty());
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }

        return isNull;
    }




    public static void main(String[] args) {
        UserDAO dao = new UserDAO(DBConnect.getConnection());
        List<User> users = dao.getAllUser();
        System.out.println(users.toString());
    }
}
