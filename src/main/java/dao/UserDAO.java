package dao;

import models.User;
import utils.DBConnection;
import java.sql.*;

public class UserDAO {
    
    public static boolean registerUser(User user) throws SQLException {
        Connection conn = DBConnection.getConnection();
        String sql = "INSERT INTO users (name, email, password, role) VALUES (?, ?, ?, ?)";
        PreparedStatement stmt = conn.prepareStatement(sql);
        stmt.setString(1, user.getName());
        stmt.setString(2, user.getEmail());
        stmt.setString(3, user.getPassword());
        stmt.setString(4, user.getRole());

        return stmt.executeUpdate() > 0;
    }

    public static User loginUser(String email, String password) throws SQLException {
        Connection conn = DBConnection.getConnection();
        String sql = "SELECT * FROM users WHERE email = ? AND password = ?";
        PreparedStatement stmt = conn.prepareStatement(sql);
        stmt.setString(1, email);
        stmt.setString(2, password);
        ResultSet rs = stmt.executeQuery();

        if (rs.next()) {
            return new User(
                rs.getInt("id"),
                rs.getString("name"),
                rs.getString("email"),
                rs.getString("password"),
                rs.getString("role")
            );
        }
        return null;
    }

    public static User getUserByEmail(String email) throws SQLException {
        Connection conn = DBConnection.getConnection();
        String sql = "SELECT * FROM users WHERE email = ?";
        PreparedStatement stmt = conn.prepareStatement(sql);
        stmt.setString(1, email);
        ResultSet rs = stmt.executeQuery();

        if (rs.next()) {
            return new User(
                rs.getInt("id"),
                rs.getString("name"),
                rs.getString("email"),
                rs.getString("password"),
                rs.getString("role")
            );
        }
        return null;
    }
}
