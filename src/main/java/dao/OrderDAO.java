package dao;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import entity.CartItem;
import entity.Order;
import entity.Product;

public class OrderDAO {
    private Connection con;

    public OrderDAO(Connection con) {
        this.con = con;
    }

    public boolean placeOrder(int userId, List<CartItem> cartItems, double total) throws SQLException {
        boolean success = false;
        
        String orderSql = "INSERT INTO orders (user_id, total_amount) VALUES (?, ?)";
        String detailSql = "INSERT INTO order_details (order_id, product_id, quantity, price) VALUES (?, ?, ?, ?)";

        try {
            con.setAutoCommit(false); 

           
            PreparedStatement psOrder = con.prepareStatement(orderSql, Statement.RETURN_GENERATED_KEYS);
            psOrder.setInt(1, userId);
            psOrder.setDouble(2, total);
            psOrder.executeUpdate();

           
            ResultSet rs = psOrder.getGeneratedKeys();
            int orderId = 0;
            if (rs.next()) {
                orderId = rs.getInt(1);
            }

           
            PreparedStatement psDetail = con.prepareStatement(detailSql);
            for (CartItem item : cartItems) {
                psDetail.setInt(1, orderId);
                psDetail.setInt(2, item.getProduct().getProductId());
                psDetail.setInt(3, item.getQuantity());
                psDetail.setDouble(4, item.getProduct().getPrice());
                psDetail.addBatch();
            }
            psDetail.executeBatch();

            con.commit(); 
            success = true;
        } catch (SQLException e) {
            con.rollback(); 
            e.printStackTrace();
            throw e;
        } finally {
            con.setAutoCommit(true);
        }
        return success;
    }

    public List<Order> getAllOrders() throws SQLException {
        List<Order> list = new ArrayList<>();
        
        String sql = "SELECT o.*, u.name FROM orders o JOIN users u ON o.user_id = u.id ORDER BY o.order_date DESC";
        
        PreparedStatement ps = con.prepareStatement(sql);
        ResultSet rs = ps.executeQuery();
        while (rs.next()) {
            Order o = new Order();
            o.setId(rs.getInt("order_id"));
            o.setCustomerName(rs.getString("name")); 
            o.setTotalAmount(rs.getDouble("total_amount"));
            o.setOrderDate(rs.getString("order_date"));
            o.setStatus(rs.getString("status"));
            list.add(o);
        }
        return list;
    }
 
    public List<CartItem> getOrderItemsByOrderId(int orderId) throws SQLException {
        List<CartItem> items = new ArrayList<>();
        String sql = "SELECT p.name, p.image, od.quantity, od.price " +
                     "FROM order_details od " +
                     "JOIN product p ON od.product_id = p.product_id " +
                     "WHERE od.order_id = ?";
        
        try (PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, orderId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Product p = new Product();
                p.setName(rs.getString("name"));
                p.setImage(rs.getString("image"));
                p.setPrice(rs.getDouble("price"));
                
                CartItem item = new CartItem(p, rs.getInt("quantity"));
                items.add(item);
            }
        }
        return items;
    }
 // OrderDAO.java ထဲမှာ ထည့်ပါ
    public List<Order> getDailySales() throws SQLException {
        List<Order> list = new ArrayList<>();
        
        String sql = "SELECT DATE(order_date) as sales_date, SUM(total_amount) as daily_total, COUNT(order_id) as order_count " +
                     "FROM orders " +
                     "WHERE status = 'Delivered' " +
                     "GROUP BY DATE(order_date) " +
                     "ORDER BY sales_date DESC";
        
        try (PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                Order o = new Order();
                o.setOrderDate(rs.getString("sales_date"));
                o.setTotalAmount(rs.getDouble("daily_total"));
                o.setId(rs.getInt("order_count")); 
                list.add(o);
            }
        }
        return list;
    }

    public double getTotalRevenue() throws SQLException {
        String sql = "SELECT SUM(total_amount) FROM orders";
        try (PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            if (rs.next()) return rs.getDouble(1);
        }
        return 0;
    }

    
    public List<Order> getRecentOrders() throws SQLException {
        List<Order> list = new ArrayList<>();
        String sql = "SELECT o.*, u.name FROM orders o JOIN users u ON o.user_id = u.id ORDER BY o.order_date DESC LIMIT 5";
        try (PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                Order o = new Order();
                o.setId(rs.getInt("order_id"));
                o.setCustomerName(rs.getString("name"));
                o.setTotalAmount(rs.getDouble("total_amount"));
                o.setOrderDate(rs.getString("order_date"));
                o.setStatus(rs.getString("status"));
                list.add(o);
            }
        }
        return list;
    }
}