package database;

import com.mysql.cj.jdbc.MysqlDataSource;
import org.jdbi.v3.core.Jdbi;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBConnect {

    private static Connection con;
    private static final String uri = "jdbc:mysql://" + DBConfig.host + ":" + DBConfig.port + "/" + DBConfig.dbname;
    public static Jdbi jdbi;

    public static Jdbi getJdbi() {
        if (jdbi == null) {
            connect();
        }
        return jdbi;
    }

    public static void connect() {
        MysqlDataSource dataSource = new MysqlDataSource();
        dataSource.setUrl(uri);
        dataSource.setUser(DBConfig.username);
        dataSource.setPassword(DBConfig.password);
        try {
            dataSource.setUseCompression(true);
            dataSource.setAutoReconnect(true);
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        jdbi = Jdbi.create(dataSource);
    }

    public static Connection getConnection() {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            con = DriverManager.getConnection(uri,DBConfig.username,DBConfig.password);
            System.out.println("thanh cong");
        } catch (ClassNotFoundException | SQLException e) {
            throw new RuntimeException(e);
        }
        return con;
    }

    public static void main(String[] args) {
        System.out.println(DBConnect.getConnection());
    }
}
