package controller;

import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.List;

import dao.CategoryDAO;
import databasesetup.DBConnection;
import entity.Category;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

@WebServlet("/category")
public class CategoryController extends HttpServlet {

    private CategoryDAO categoryDAO;
    private Connection connection;

    @Override
    public void init() throws ServletException {
        try {
            connection = DBConnection.getConnection();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        categoryDAO = new CategoryDAO(connection);
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String mode = req.getParameter("mode");
        if (mode == null) {
            mode = "list"; 
        }

        try {
            switch (mode) {
                case "showForm":
                    showCategoryForm(req, resp);
                    break;
                case "edit":
                    editCategory(req, resp);
                    break;
                case "delete":
                    deleteCategory(req, resp);
                    break;
                case "saveCategory":
                    saveCategory(req, resp);
                    break;
                default:
                    listCategories(req, resp);
                    break;
            }
        } catch (Exception e) {
            throw new ServletException(e);
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        doGet(req, resp);
    }

   

    private void listCategories(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException, SQLException {
    	List<Category> categories = categoryDAO.getAllCategories();
    	req.setAttribute("categories", categories);
        req.setAttribute("categoryList", categories);
        req.getRequestDispatcher("category.jsp").forward(req, resp);
    }

    private void showCategoryForm(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        req.getRequestDispatcher("category.jsp").forward(req, resp);
    }

    private void saveCategory(HttpServletRequest req, HttpServletResponse resp)
            throws IOException, SQLException {
        String id = req.getParameter("id");
        String name = req.getParameter("name");

        if (id == null || id.isEmpty()) {
           
            categoryDAO.addCategory(new Category(name));
        } else {
           
            categoryDAO.updateCategory(new Category(Integer.parseInt(id), name));
        }
        resp.sendRedirect("category"); 
    }

    private void editCategory(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException, SQLException {
        int id = Integer.parseInt(req.getParameter("id"));
        Category category = categoryDAO.getCategoryById(id);
        req.setAttribute("category", category);
        List<Category> list = categoryDAO.getAllCategories();
        req.setAttribute("categoryList", list);
        req.getRequestDispatcher("category.jsp").forward(req, resp);
        
    }

    private void deleteCategory(HttpServletRequest req, HttpServletResponse resp)
            throws IOException, SQLException {
        int id = Integer.parseInt(req.getParameter("id"));
        categoryDAO.deleteCategory(id);
        resp.sendRedirect("category"); 
    }
}
