package dao;

import entity.Product;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ProductDAO {

    private Connection conn;

    public ProductDAO(Connection conn) {
        this.conn = conn;
    }

    public List<Product> searchProducts(String search, Integer cid) {
        List<Product> list = new ArrayList<>();
        String sql = "SELECT * FROM product WHERE 1=1";

        if (search != null && !search.trim().isEmpty()) {
            sql += " AND name LIKE ?";
        }
        if (cid != null) {
            sql += " AND cid = ?";
        }

        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            int index = 1;
            if (search != null && !search.trim().isEmpty()) {
                ps.setString(index++, "%" + search + "%");
            }
            if (cid != null) {
                ps.setInt(index++, cid);
            }

            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Product p = new Product();
                p.setProductId(rs.getInt("product_id"));
                p.setName(rs.getString("name"));
                p.setPrice(rs.getDouble("price"));
                p.setQuantity(rs.getInt("quantity"));
                p.setImage(rs.getString("image"));
                p.setCid(rs.getInt("cid"));
                list.add(p);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public List<Product> getAllProducts() {
        List<Product> list = new ArrayList<>();
        String sql = "SELECT * FROM product";

        try (PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                Product p = new Product();
                p.setProductId(rs.getInt("product_id")); 
                p.setName(rs.getString("name"));
                p.setPrice(rs.getDouble("price"));
                p.setQuantity(rs.getInt("quantity"));
                p.setImage(rs.getString("image"));
                p.setCid(rs.getInt("cid"));
                list.add(p);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public void addProduct(Product p) {
        String sql = "INSERT INTO product(name, price, quantity, image, cid) VALUES (?, ?, ?, ?, ?)";

        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, p.getName());
            ps.setDouble(2, p.getPrice());
            ps.setInt(3, p.getQuantity());
            ps.setString(4, p.getImage());
            ps.setInt(5, p.getCid());
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

   
    public void updateProduct(Product p) {
        String sql = "UPDATE product SET name=?, price=?, quantity=?, image=?, cid=? WHERE product_id=?";

        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, p.getName());
            ps.setDouble(2, p.getPrice());
            ps.setInt(3, p.getQuantity());
            ps.setString(4, p.getImage());
            ps.setInt(5, p.getCid());
            ps.setInt(6, p.getProductId());
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void deleteProduct(int id) {
        String sql = "DELETE FROM product WHERE product_id=?";

        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public Product getProductById(int id) {
        String sql = "SELECT * FROM product WHERE product_id=?";
        Product p = null;
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                p = new Product();
                p.setProductId(rs.getInt("product_id"));
                p.setName(rs.getString("name"));
                p.setPrice(rs.getDouble("price"));
                p.setQuantity(rs.getInt("quantity"));
                p.setImage(rs.getString("image"));
                p.setCid(rs.getInt("cid"));
            }
        } catch (Exception e) { e.printStackTrace(); }
        return p;
    }
 
    
    public int getTotalCustomers() throws SQLException {
        String sql = "SELECT COUNT(*) FROM users WHERE role = 'customer'";
        try (PreparedStatement ps = conn.prepareStatement(sql);
        	ResultSet rs = ps.executeQuery()) {
            if (rs.next()) 
            return rs.getInt(1);
        }
        return 0;
    }

    public List<Product> getProductsByCategory(Integer cid) {

        List<Product> list = new ArrayList<>();
        String sql = "SELECT * FROM product";

        if (cid != null) {
            sql += " WHERE cid=?";
        }

        try {
            PreparedStatement ps = conn.prepareStatement(sql);

            if (cid != null) {
                ps.setInt(1, cid);
            }

            ResultSet rs = ps.executeQuery();
            while (rs.next()) {

                Product p = new Product();
                p.setProductId(rs.getInt("product_id"));
                p.setName(rs.getString("name"));
                p.setPrice(rs.getDouble("price"));
                p.setQuantity(rs.getInt("quantity"));
                p.setImage(rs.getString("image"));
                p.setCid(rs.getInt("cid"));

                list.add(p);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

}
