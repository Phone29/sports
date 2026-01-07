package controller;

import dao.ProductDAO;
import databasesetup.DBConnection;
import dao.CategoryDAO;
import entity.Product;
import entity.Category;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

import java.io.File;
import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.List;

@WebServlet("/product")
@MultipartConfig(
	    fileSizeThreshold = 1024 * 1024,
	    maxFileSize = 5 * 1024 * 1024,
	    maxRequestSize = 10 * 1024 * 1024
	)
public class ProductController extends HttpServlet {
    private ProductDAO productDAO;
    private CategoryDAO categoryDAO;
    private Connection connection;
    @Override
    public void init() throws ServletException {
        try {
            connection = DBConnection.getConnection();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        productDAO = new ProductDAO(connection);
        categoryDAO = new CategoryDAO(connection);
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String mode = request.getParameter("mode");
        if (mode == null) {
        	mode = "list";
        }

        switch (mode) {
            case "new":
			try {
				showNewForm(request, response);
			} catch (ServletException | IOException | SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
                break;
            case "edit":
			try {
				showEditForm(request, response);
			} catch (ServletException | IOException | SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
                break;
            case "delete":
                deleteProduct(request, response);
                break;
            case "productDetail":
			try {
				showProductDetail(request, response);
			} catch (ServletException | IOException | SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
                break;
            default:
			try {
				listProducts(request, response);
			} catch (ServletException | IOException | SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
                break;
        }
    }

    private void showProductDetail(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException, SQLException {
        int productId = Integer.parseInt(request.getParameter("productId"));
        Product product = productDAO.getProductById(productId);

        request.setAttribute("product", product); 
        request.getRequestDispatcher("productDetail.jsp").forward(request, response);
    }

    private void listProducts(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException, SQLException {
        String cidParam = request.getParameter("cid");
        Integer cid = (cidParam != null && !cidParam.isEmpty()) ? Integer.parseInt(cidParam) : null;

        List<Product> products = productDAO.getProductsByCategory(cid);
        List<Category> categories = categoryDAO.getAllCategories(); 

        request.setAttribute("products", products);
        request.setAttribute("categories", categories);

        request.getRequestDispatcher("productList.jsp").forward(request, response);
    }
    private void showNewForm(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException, SQLException {
        List<Category> categories = categoryDAO.getAllCategories();
        request.setAttribute("categories", categories);
        RequestDispatcher dispatcher = request.getRequestDispatcher("addProduct.jsp");
        dispatcher.forward(request, response);
    }

    private void showEditForm(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException, SQLException {
        int id = Integer.parseInt(request.getParameter("id"));
        Product product = productDAO.getProductById(id);
        List<Category> categories = categoryDAO.getAllCategories();
        request.setAttribute("product", product);
        request.setAttribute("categories", categories);
        RequestDispatcher dispatcher = request.getRequestDispatcher("addProduct.jsp");
        dispatcher.forward(request, response);
    }

    private void deleteProduct(HttpServletRequest request, HttpServletResponse response) throws IOException {

    	
    	 String idParam = request.getParameter("id");
         if (idParam != null && !idParam.isEmpty()) {
             int id = Integer.parseInt(idParam);
             Product product = productDAO.getProductById(id);

             if (product.getImage() != null) {
                 String uploadPath = getServletContext().getRealPath("/uploads/");
                 File file = new File(uploadPath + File.separator + product.getImage());
                 if (file.exists()) file.delete();
             }

             productDAO.deleteProduct(id);
         }
         response.sendRedirect("product");
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int id = request.getParameter("productId") != null && !request.getParameter("productId").isEmpty() ?
                Integer.parseInt(request.getParameter("productId")) : 0;

        String name = request.getParameter("name");
        double price = Double.parseDouble(request.getParameter("price"));
        int quantity = Integer.parseInt(request.getParameter("quantity"));
        int cId = Integer.parseInt(request.getParameter("cid"));
        
//        Part filePart = request.getPart("image");
//        String image = null;
//        if (filePart != null && filePart.getSize() > 0) {
//            image = filePart.getSubmittedFileName();
//        }
        
//        Part filePart = request.getPart("image"); // name="image" in form
//        String image = null;
//
//        if (filePart != null && filePart.getSize() > 0) {
//            // server folder path
//            String uploadPath = getServletContext().getRealPath("/") + "uploads" + File.separator;
//            java.io.File uploadDir = new java.io.File(uploadPath);
//            if (!uploadDir.exists()) uploadDir.mkdir();
//
//            // unique file name
//            image = System.currentTimeMillis() + "_" + filePart.getSubmittedFileName();
//            filePart.write(uploadPath + image);
//        }

        
        Part filePart = request.getPart("image");
        String image = null;

        if (filePart != null && filePart.getSize() > 0) {
            String uploadPath = getServletContext().getRealPath("/uploads/");
            File uploadDir = new File(uploadPath);
            if (!uploadDir.exists()) uploadDir.mkdir();

            image = System.currentTimeMillis() + "_" + filePart.getSubmittedFileName();
            filePart.write(uploadPath + File.separator + image);
        }
           
        Product product = new Product(id, name, price, quantity, image, cId);

        if (id == 0) {
            productDAO.addProduct(product);
        } else {
            productDAO.updateProduct(product);
        }
        response.sendRedirect("product");
    }
}






























