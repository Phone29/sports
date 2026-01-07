package controller;

import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;
import dao.ProductDAO;
import databasesetup.DBConnection;
import entity.Product;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/product-detail")
public class ProductDetailController extends HttpServlet {
    private ProductDAO productDAO;

    @Override
    public void init() throws ServletException {
        try {
            Connection conn = DBConnection.getConnection();
            productDAO = new ProductDAO(conn);
        } catch (SQLException e) { e.printStackTrace(); }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String idParam = request.getParameter("productId");
        
        if (idParam != null) {
            int productId = Integer.parseInt(idParam);
            Product product = productDAO.getProductById(productId);
            
            if (product != null) {
                request.setAttribute("p", product);
                request.getRequestDispatcher("productDetail.jsp").forward(request, response);
            } else {
                response.sendRedirect("home");
            }
        } else {
            response.sendRedirect("home");
        }
    }
}