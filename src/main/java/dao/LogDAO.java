package dao;

import database.DBConnect;
import model.Address;
import model.IPAddressUtil;
import model.Log;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

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

    public static void main(String[] args) {
        IPAddressUtil.getPublicIPAddress();
        LogDAO dao = new LogDAO(DBConnect.getConnection());
        dao.insertLog(new Log(Log.ALERT,6, IPAddressUtil.getPublicIPAddress(),"Đổi mật khẩu","Nhập lại mật khẩu cũ không đúng",0) );
    }
}
