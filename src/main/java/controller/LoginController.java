package controller;

import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;

import dao.UserDAO;
import databasesetup.DBConnection;
import entity.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/login")
public class LoginController extends HttpServlet {

    private UserDAO userDAO;

    @Override
    public void init() throws ServletException {
        try {
            Connection connection = DBConnection.getConnection();
            userDAO = new UserDAO(connection);
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) 
            throws ServletException, IOException {
        
        String mode = req.getParameter("mode");
        if ("logout".equals(mode)) {
            HttpSession session = req.getSession(false);
            if (session != null) {
                session.invalidate();
            }
            resp.sendRedirect("home");
            return;
        }

        req.getRequestDispatcher("login.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) 
            throws ServletException, IOException {
        
        String email = req.getParameter("email");
        String password = req.getParameter("password");

        try {
            User user = userDAO.login(email, password);

            if (user != null) {
                HttpSession session = req.getSession();
                session.setAttribute("user", user);
                session.setAttribute("customerId", user.getId());

                if ("admin".equals(user.getRole())) {
                    resp.sendRedirect("adminDashboard"); 
                } else {
                    resp.sendRedirect("home"); 
                }
            } else {
                req.setAttribute("error", "Invalid email or password!");
                req.getRequestDispatcher("login.jsp").forward(req, resp);
            }
        } catch (SQLException e) {
            e.printStackTrace();
            resp.sendRedirect("login.jsp?error=db_error");
        }
    }
}