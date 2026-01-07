package controller;

import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.List;

import dao.CategoryDAO;
import dao.ProductDAO;
import databasesetup.DBConnection;
import entity.Category;
import entity.Product;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/home")
public class HomeController extends HttpServlet {
    private CategoryDAO categoryDAO;
    private ProductDAO productDAO;

    @Override
    public void init() throws ServletException {
        try {
            Connection conn = DBConnection.getConnection();
            categoryDAO = new CategoryDAO(conn);
            productDAO = new ProductDAO(conn);
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            
            String categoryIdParam = request.getParameter("category_id");
            String searchParam = request.getParameter("search");

            List<Category> categoryList = categoryDAO.getAllCategories();
            List<Product> productList;

            Integer cid = null;
            if (categoryIdParam != null && !categoryIdParam.isEmpty()) {
                cid = Integer.parseInt(categoryIdParam);
            }

            
            productList = productDAO.searchProducts(searchParam, cid);

           
            request.setAttribute("categories", categoryList);
            request.setAttribute("products", productList);

            request.getRequestDispatcher("ui.jsp").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("home");
        }
    }
}