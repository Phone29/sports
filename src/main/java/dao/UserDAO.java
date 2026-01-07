package dao;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

import entity.User;

public class UserDAO {
    private Connection conn;
    public UserDAO(Connection conn) { this.conn = conn; }

    public User login(String email, String password) throws SQLException {
        String sql = "SELECT * FROM users WHERE email=? AND password=?";
        PreparedStatement ps = conn.prepareStatement(sql);
        ps.setString(1, email);
        ps.setString(2, password);
        ResultSet rs = ps.executeQuery();
        if (rs.next()) {
            User u = new User();
            u.setId(rs.getInt("id"));
            u.setName(rs.getString("name"));
            u.setEmail(rs.getString("email"));
            u.setRole(rs.getString("role"));
            return u;
        }
        return null;
    }

    public boolean registerUser(User u) throws SQLException {
        String sql = "INSERT INTO users (name, email, password, phone, address, role) VALUES (?,?,?,?,?,?)";
        PreparedStatement ps = conn.prepareStatement(sql);
        ps.setString(1, u.getName());
        ps.setString(2, u.getEmail());
        ps.setString(3, u.getPassword());
        ps.setString(4, u.getPhone());
        ps.setString(5, u.getAddress());
        ps.setString(6, "customer"); 
        return ps.executeUpdate() > 0;
    }

    public List<User> getAllUser() throws SQLException {
        List<User> list = new ArrayList<>();
        String sql = "SELECT * FROM users";
        PreparedStatement ps = conn.prepareStatement(sql);
        ResultSet rs = ps.executeQuery();

        while (rs.next()) {
            User u = new User();
            u.setId(rs.getInt("id"));
            u.setName(rs.getString("name"));
            u.setEmail(rs.getString("email"));
            u.setPhone(rs.getString("phone"));
            u.setAddress(rs.getString("address"));
            u.setRole(rs.getString("role"));
            list.add(u);
        }
        return list;
    }
    public User getUserById(int id) {
        User u = null;
        String sql = "SELECT * FROM users WHERE id = ?"; 
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                u = new User();
                u.setId(rs.getInt("id"));
                u.setName(rs.getString("name"));
                u.setEmail(rs.getString("email"));
                u.setPhone(rs.getString("phone"));
                u.setAddress(rs.getString("address"));
                u.setRole(rs.getString("role"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return u;
    }
}