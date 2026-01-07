package dao;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

import entity.Cart;

public class CartDAO {

    private Connection con;

    public CartDAO(Connection con) {
        this.con = con;
    }

    
    public boolean addToCart(Cart cart) throws SQLException {
        String sql = "INSERT INTO cart (customer_id, product_id, quantity) VALUES (?, ?, ?) ON DUPLICATE KEY UPDATE quantity = quantity + ?";

        PreparedStatement ps = con.prepareStatement(sql);
        ps.setInt(1, cart.getCustomerId());
        ps.setInt(2, cart.getProductId());
        ps.setInt(3, cart.getQuantity());
        ps.setInt(4, cart.getQuantity());

        return ps.executeUpdate() > 0;
    }

 
    public List<Cart> getCartByCustomer(int customerId) throws SQLException {
        List<Cart> list = new ArrayList<>();
       
        String sql = "SELECT c.*, p.name as pName, p.price as pPrice, p.image as pImage " +
                     "FROM cart c JOIN product p ON c.product_id = p.product_id " +
                     "WHERE c.customer_id=?";

        PreparedStatement ps = con.prepareStatement(sql);
        ps.setInt(1, customerId);
        ResultSet rs = ps.executeQuery();

        while (rs.next()) {
            Cart c = new Cart();
            c.setId(rs.getInt("id"));
            c.setCustomerId(rs.getInt("customer_id"));
            c.setProductId(rs.getInt("product_id"));
            c.setQuantity(rs.getInt("quantity"));
            
            list.add(c);
        }
        return list;
    }

    public boolean updateQuantity(int cartId, int quantity) throws SQLException {
        String sql = "UPDATE cart SET quantity=? WHERE id=?";
        PreparedStatement ps = con.prepareStatement(sql);
        ps.setInt(1, quantity);
        ps.setInt(2, cartId);
        return ps.executeUpdate() > 0;
    }
    
    public void clearCartByCustomer(int customerId) throws SQLException {
        String sql = "DELETE FROM cart WHERE customer_id=?";
        PreparedStatement ps = con.prepareStatement(sql);
        ps.setInt(1, customerId);
        ps.executeUpdate();
    }


    public boolean removeFromCart(int cartId) throws SQLException {
        String sql = "DELETE FROM cart WHERE id=?";
        PreparedStatement ps = con.prepareStatement(sql);
        ps.setInt(1, cartId);
        return ps.executeUpdate() > 0;
    }
}
