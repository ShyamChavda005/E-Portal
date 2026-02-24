/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.sql.*;
import java.util.*;
import java.security.*;

/**
 *
 * @author Shyam
 */
@WebServlet(urlPatterns = {"/loginServlet"})
public class loginServlet extends HttpServlet {

    
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        String role = request.getParameter("role");
        String username = request.getParameter("username");
        String password = request.getParameter("password");

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/exam", "root", "");
            if (con == null) {
                out.println("Connection lost to database");
            }
            
            MessageDigest md = MessageDigest.getInstance("SHA-256");
            byte[] hashBytes = md.digest(password.getBytes());
            StringBuilder sb = new StringBuilder();
            
            for (byte b : hashBytes) {
                sb.append(String.format("%02x", b));
            }
            
            String hashPass = sb.toString();
            HttpSession session = request.getSession();
            
            // Student 
            if (role.equals("student")) {
                PreparedStatement pst = con.prepareStatement("SELECT * FROM users WHERE username = ?");
                pst.setString(1, username);
                ResultSet rs = pst.executeQuery();
                
                if (!rs.next()) {
                    response.sendRedirect("index.html?username=1");
                }
                
                String dbPass = rs.getString("password");
                
                if (hashPass.equals(dbPass)) {
                    session.setAttribute("studentUsername", username);
                    response.sendRedirect("student/StudentDashboard.jsp");
                } else {
                    response.sendRedirect("index.html?password=1");
                }  
            }
            
            // Admin
            else {
                PreparedStatement pst = con.prepareStatement("SELECT * FROM admin WHERE username = ?");
                pst.setString(1, username);
                ResultSet rs = pst.executeQuery();
                
                if (!rs.next()) {
                    response.sendRedirect("index.html?adusername=1");
                }
                
                String dbPass = rs.getString("password");
                
                if (hashPass.equals(dbPass)) {
                    session.setAttribute("adminUsername", username);
                    response.sendRedirect("admin/AdminDashboard.jsp");
                } else {
                    response.sendRedirect("index.html?adpassword=1");
                }    
            }

        } catch (Exception e) {
            out.println("<html>");
            out.println("<body>");
            out.println("<h2> Exception : " + e.getMessage() + "</h2>");
            out.println("</body>");
            out.println("</html>");
        }
        
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
