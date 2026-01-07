package controller;

import java.io.IOException;
import java.sql.SQLException;

import dao.UserDAO;
import entity.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/auth")
public class userController extends HttpServlet {
    private UserDAO userDAO;

    public void init() {
        try {
			userDAO = new UserDAO(databasesetup.DBConnection.getConnection());
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
    }

    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String mode = req.getParameter("mode");
        String email = req.getParameter("email");
        String password = req.getParameter("password");

        try {
            if ("register".equals(mode)) {

                User newUser = new User();
                newUser.setName(req.getParameter("name"));
                newUser.setEmail(email);
                newUser.setPassword(password);
                newUser.setPhone(req.getParameter("phone"));
                newUser.setAddress(req.getParameter("address"));

                if (userDAO.registerUser(newUser)) {
                    resp.sendRedirect("login.jsp?msg=success");
                } else {
                    resp.sendRedirect("register.jsp?error=true");
                }

            } else {
               
                User user = userDAO.login(email, password);
                if (user != null) {
                    HttpSession session = req.getSession();
                    session.setAttribute("user", user);
                    session.setAttribute("customerId", user.getId());

                    if ("admin".equals(user.getRole())) {
                        resp.sendRedirect("adminDashboard.jsp"); 
                    } else {
                        resp.sendRedirect("ui.jsp");
                    }
                } else {
                    req.setAttribute("error", "Invalid email or password!");
                    req.getRequestDispatcher("login.jsp").forward(req, resp);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
            resp.sendRedirect("login.jsp?error=db_error");
        }
    }
}