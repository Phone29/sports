package dao;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

import entity.Category;


public class CategoryDAO {

    private Connection connection;

    public CategoryDAO(Connection connection) {
        this.connection=connection;
    }

    public void addCategory(Category category) throws SQLException {
        String sql = "INSERT INTO categories(name) VALUES (?)";
        PreparedStatement ps = connection.prepareStatement(sql);
        ps.setString(1, category.getName());
        ps.executeUpdate();
    }

    public List<Category> getAllCategories() throws SQLException {
        List<Category> list = new ArrayList<>();
        String sql = "SELECT * FROM categories";
        PreparedStatement ps = connection.prepareStatement(sql);
        ResultSet rs = ps.executeQuery();

        while (rs.next()) {
            Category c = new Category(
                rs.getInt("id"),
                rs.getString("name")
            );
            list.add(c);
        }
        return list;
    }
    
 
    public Category getCategoryById(int id) throws SQLException {
        String sql = "SELECT * FROM categories WHERE id=?";
        PreparedStatement ps = connection.prepareStatement(sql);
        ps.setInt(1, id);
        ResultSet rs = ps.executeQuery();

        if (rs.next()) {
            return new Category(
                rs.getInt("id"),
                rs.getString("name")
            );
        }
        return null;
    }

    public void updateCategory(Category category) throws SQLException {
        String sql = "UPDATE categories SET name=? WHERE id=?";
        PreparedStatement ps = connection.prepareStatement(sql);
        ps.setString(1, category.getName());
        ps.setInt(2, category.getId());
        ps.executeUpdate();
    }

    public void deleteCategory(int id) throws SQLException {
        String sql = "DELETE FROM categories WHERE id=?";
        PreparedStatement ps = connection.prepareStatement(sql);
        ps.setInt(1, id);
        ps.executeUpdate();
    }
}
