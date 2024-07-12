package dao;

import database.DBConnect;
import model.Address;
import model.IPAddressUtil;
import model.Log;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class LogDAO {
    private String query = "";
    private PreparedStatement ps;
    private ResultSet rs;
   private final Connection con ;

   public LogDAO(Connection con) {
        this.con = con;
   }
    public boolean insertLog(Log l) {
        boolean isAdd = false;
        query = "INSERT INTO log(level , src, userId, ip, content, creatAt, status) VALUES (?,?,?,?,?,?,?)";
        try {
            ps = con.prepareStatement(query);
            ps.setInt(1, l.getLevel());
            ps.setString(2, l.getSrc());
            ps.setInt(3, l.getUserId());
            ps.setString(4, l.getIp());
            ps.setString(5, l.getContent());
            ps.setString(6, l.getCreatAt());
            ps.setInt(7, l.getStatus());

            int i = ps.executeUpdate();
            isAdd = i == 1;
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return isAdd;
    }
    public List<Log> getAllLogs() {
        List<Log> logs = new ArrayList<>();
        query = "SELECT * FROM log";
        try {
            ps = con.prepareStatement(query);
            rs = ps.executeQuery();
            while (rs.next()) {
                Log log = new Log();
                log.setId(rs.getInt("id"));
                log.setLevel(rs.getInt("level"));
                log.setSrc(rs.getString("src"));
                log.setUserId(rs.getInt("userId"));
                log.setIp(rs.getString("ip"));
                log.setContent(rs.getString("content"));
                log.setCreatAt(rs.getString("creatAt"));
                log.setStatus(rs.getInt("status"));
                logs.add(log);
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return logs;
    }

    public static void main(String[] args) {
        IPAddressUtil.getPublicIPAddress();
        LogDAO dao = new LogDAO(DBConnect.getConnection());
        dao.insertLog(new Log(Log.ALERT,6, IPAddressUtil.getPublicIPAddress(),"Đổi mật khẩu","Nhập lại mật khẩu cũ không đúng",0) );
    }

    public boolean deleteLog(int id) {
        boolean isDeleted = false;
        query = "DELETE FROM log WHERE id = ?";
        try {
            ps = con.prepareStatement(query);
            ps.setInt(1, id);

            int i = ps.executeUpdate();
            isDeleted = i == 1;
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return isDeleted;
    }
    public boolean deleteAllLogs() {
        boolean deleted = false;
        String query = "DELETE FROM log";

        try (Connection con = DBConnect.getConnection();
             PreparedStatement ps = con.prepareStatement(query)) {

            int rowsAffected = ps.executeUpdate();
            deleted = rowsAffected > 0;

        } catch (SQLException e) {
            e.printStackTrace();
            // Xử lý lỗi nếu cần thiết
        }

        return deleted;
    }
    public List<Log> getLogsByAdminStatus(String isAdmin) {
        List<Log> logs = new ArrayList<>();
        query = "SELECT * FROM log WHERE userId IN (SELECT id FROM users WHERE isAdmin = ?)";
        try {
            ps = con.prepareStatement(query);
            ps.setString(1, isAdmin);
            rs = ps.executeQuery();
            while (rs.next()) {
                Log log = new Log();
                log.setId(rs.getInt("id"));
                log.setLevel(rs.getInt("level"));
                log.setSrc(rs.getString("src"));
                log.setUserId(rs.getInt("userId"));
                log.setIp(rs.getString("ip"));
                log.setContent(rs.getString("content"));
                log.setCreatAt(rs.getString("creatAt"));
                log.setStatus(rs.getInt("status"));
                logs.add(log);
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return logs;
    }

}
