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

@WebServlet("/shopping") // URL အသစ်
public class ShoppingController extends HttpServlet {
    private ProductDAO productDAO;
    private CategoryDAO categoryDAO;

    @Override
    public void init() throws ServletException {
        try {
            Connection conn = DBConnection.getConnection();
            productDAO = new ProductDAO(conn);
            categoryDAO = new CategoryDAO(conn);
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        try {
            String cidParam = request.getParameter("category_id");
            String search = request.getParameter("search");
            
            Integer cid = null;
            if (cidParam != null && !cidParam.isEmpty()) {
                cid = Integer.parseInt(cidParam);
            }
            List<Product> productList = productDAO.searchProducts(search, cid);
            List<Category> categoryList = categoryDAO.getAllCategories();

            request.setAttribute("products", productList);
            request.setAttribute("categories", categoryList);
            
            request.getRequestDispatcher("shopping.jsp").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("home");
        }
    }
}