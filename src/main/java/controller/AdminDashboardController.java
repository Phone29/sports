package controller;

import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.List;
import java.util.stream.Collectors;

import dao.CategoryDAO;
import dao.OrderDAO;
import dao.ProductDAO;
import dao.UserDAO;
import databasesetup.DBConnection;
import entity.Product;
import entity.User;
import entity.CartItem;
import entity.Category;
import entity.Order;
import jakarta.servlet.ServletConfig;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/adminDashboard")
public class AdminDashboardController extends HttpServlet {

    private UserDAO userDAO;
    private ProductDAO productDAO;
    private CategoryDAO categoryDAO; 
    private Connection connection;

    @Override
    public void init(ServletConfig config) throws ServletException {
        try {
            connection = DBConnection.getConnection();
            userDAO = new UserDAO(connection);
            productDAO = new ProductDAO(connection);
            categoryDAO = new CategoryDAO(connection); 
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String mode = req.getParameter("mode");
        
        try {
            if (mode == null || "admin".equals(mode)) {
                showDashboard(req, resp);
            } else if ("customerList".equals(mode)) {
                showCustomerList(req, resp);
            } else if ("userDetail".equals(mode)) {
                showUserDetail(req, resp);
            } else if ("orderList".equals(mode)) {
                showOrderList(req, resp);
            } else if ("orderDetail".equals(mode)) {
                showOrderDetails(req, resp);
            } else if ("salesReport".equals(mode)) {
                showSalesReport(req, resp);
            }
            else {
                showIndex(req, resp);
            }
        } catch (SQLException e) {
            e.printStackTrace();
            resp.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
        }
    }

    private void showSalesReport(HttpServletRequest req, HttpServletResponse resp) throws IOException, SQLException, ServletException {
		// TODO Auto-generated method stub
    	if (!isAdmin(req, resp)) return;

        OrderDAO orderDAO = new OrderDAO(connection);
        List<Order> salesData = orderDAO.getDailySales();
        
       
        double grandTotal = salesData.stream().mapToDouble(Order::getTotalAmount).sum();

        req.setAttribute("salesData", salesData);
        req.setAttribute("grandTotal", grandTotal);
        req.getRequestDispatcher("salesReport.jsp").forward(req, resp);
	}

	private void showOrderDetails(HttpServletRequest req, HttpServletResponse resp) throws IOException, SQLException, ServletException {
		// TODO Auto-generated method stub
    	if (!isAdmin(req, resp)) return;

        int orderId = Integer.parseInt(req.getParameter("id"));
        OrderDAO orderDAO = new OrderDAO(connection);
        
       
        List<CartItem> items = orderDAO.getOrderItemsByOrderId(orderId);
        
        req.setAttribute("items", items);
        req.setAttribute("orderId", orderId);
        req.getRequestDispatcher("orderDetail.jsp").forward(req, resp);
	}

	private void showOrderList(HttpServletRequest req, HttpServletResponse resp) throws IOException, SQLException, ServletException {
		// TODO Auto-generated method stub
    	if (!isAdmin(req, resp)) return;

        OrderDAO orderDAO = new OrderDAO(connection);
        List<Order> orders = orderDAO.getAllOrders();

        req.setAttribute("orders", orders);
        req.getRequestDispatcher("orderList.jsp").forward(req, resp);
	}

	
	private void showDashboard(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException, SQLException {
	    if (!isAdmin(req, resp)) return;

	    OrderDAO orderDAO = new OrderDAO(connection);
	    ProductDAO productDAO = new ProductDAO(connection);
	    UserDAO userDAO = new UserDAO(connection);

	    
	    req.setAttribute("totalProducts", productDAO.getAllProducts().size());
	    req.setAttribute("totalOrders", orderDAO.getAllOrders().size());
	    req.setAttribute("totalCustomers", userDAO.getAllUser().stream().filter(u -> !"admin".equalsIgnoreCase(u.getRole())).count());
	    req.setAttribute("totalRevenue", orderDAO.getTotalRevenue());

	   
	    req.setAttribute("recentOrders", orderDAO.getRecentOrders());

	    req.getRequestDispatcher("adminDashboard.jsp").forward(req, resp);
	}


    private void showCustomerList(HttpServletRequest req, HttpServletResponse resp) throws SQLException, ServletException, IOException {
        if (!isAdmin(req, resp)) return;

        List<User> allUsers = userDAO.getAllUser();
        List<User> customersOnly = allUsers.stream()
                .filter(u -> !"admin".equalsIgnoreCase(u.getRole()))
                .collect(Collectors.toList());

        req.setAttribute("users", customersOnly);
        req.getRequestDispatcher("customerList.jsp").forward(req, resp);
    }

    
    private void showUserDetail(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        if (!isAdmin(req, resp)) return;

        String idStr = req.getParameter("id");
        if (idStr != null) {
            try {
                int id = Integer.parseInt(idStr);
                User u = userDAO.getUserById(id);
                if (u != null) {
                    req.setAttribute("u", u);
                    req.getRequestDispatcher("userDetail.jsp").forward(req, resp);
                } else {
                    resp.sendRedirect("adminDashboard?mode=customerList");
                }
            } catch (NumberFormatException e) {
                resp.sendRedirect("adminDashboard?mode=customerList");
            }
        }
    }

    private void showIndex(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        resp.sendRedirect("login.jsp");
    }

   
    private boolean isAdmin(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        HttpSession session = req.getSession(false);
        User user = (session != null) ? (User) session.getAttribute("user") : null;

        if (user == null || !"admin".equalsIgnoreCase(user.getRole())) {
            resp.sendRedirect("login.jsp?error=unauthorized");
            return false;
        }
        return true;
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doGet(req, resp);
    }
}