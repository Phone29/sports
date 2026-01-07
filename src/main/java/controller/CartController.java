package controller;

import java.io.IOException;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import dao.OrderDAO;
import dao.ProductDAO;
import databasesetup.DBConnection;
import entity.CartItem;
import entity.Product;
import entity.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

@WebServlet("/cart")
public class CartController extends HttpServlet {
    private ProductDAO productDAO;

    @Override
    public void init() throws ServletException {
        try {
            productDAO = new ProductDAO(DBConnection.getConnection());
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String mode = request.getParameter("mode");
        HttpSession session = request.getSession();
        
     
        User user = (User) session.getAttribute("user");
        List<CartItem> cart = (List<CartItem>) session.getAttribute("cart");
        if (cart == null) cart = new ArrayList<>();

        try {
           
            if ("add".equals(mode)) {
                addToCart(request, response, cart, session);
            } 
            
            
            else if ("view".equals(mode) || "checkout".equals(mode)) {
                if (user == null) {
                   
                    response.sendRedirect("login.jsp?error=loginRequired");
                    return;
                }
                
                if ("checkout".equals(mode)) {
                    processCheckout(request, response, cart, user);
                } else {
                    // View Cart
                    request.setAttribute("cartItems", cart);
                    request.getRequestDispatcher("cart.jsp").forward(request, response);
                }
            } 
            
            
            else if ("remove".equals(mode)) {
                removeFromCart(request, response, cart, session);
            } 
            
            else {
                response.sendRedirect("product?mode=productList");
            }
            
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
        }
    }

    
    private void addToCart(HttpServletRequest request, HttpServletResponse response, List<CartItem> cart, HttpSession session) throws IOException, SQLException {
        int id = Integer.parseInt(request.getParameter("productId"));
        Product p = productDAO.getProductById(id);
        
        boolean exists = false;
        for (CartItem item : cart) {
            if (item.getProduct().getProductId() == id) {
                item.setQuantity(item.getQuantity() + 1);
                exists = true;
                break;
            }
        }
        if (!exists && p != null) cart.add(new CartItem(p, 1));
        
        session.setAttribute("cart", cart);

        
        String referer = request.getHeader("Referer");
        response.sendRedirect(referer != null ? referer : "product?mode=productList");
    }

   
    private void removeFromCart(HttpServletRequest request, HttpServletResponse response, List<CartItem> cart, HttpSession session) throws IOException {
        int id = Integer.parseInt(request.getParameter("productId"));
        cart.removeIf(item -> item.getProduct().getProductId() == id);
        session.setAttribute("cart", cart);
        response.sendRedirect("cart?mode=view");
    }

    
    private void processCheckout(HttpServletRequest request, HttpServletResponse response, List<CartItem> cart, User user) throws IOException, SQLException {
        if (cart.isEmpty()) {
            response.sendRedirect("cart?mode=view&error=emptyCart");
            return;
        }

        double total = 0;
        for (CartItem item : cart) {
            total += item.getSubtotal();
        }

        OrderDAO orderDAO = new OrderDAO(DBConnection.getConnection());
        boolean success = orderDAO.placeOrder(user.getId(), cart, total);
        
        if (success) {
            request.getSession().removeAttribute("cart"); 
            response.sendRedirect("orderSuccess.jsp");
        } else {
            response.sendRedirect("cart?mode=view&error=checkoutFailed");
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }
}