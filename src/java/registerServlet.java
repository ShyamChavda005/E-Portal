
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.sql.*;
import java.security.*;
import java.util.*;

@WebServlet(urlPatterns = {"/registerServlet"})
public class registerServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/exam", "root", "");
            if (con == null) {
                out.println("Connection lost to database");
            }
            
            PreparedStatement ps = con.prepareStatement("SELECT * FROM users where username = ?");
            ps.setString(1, username);
            ResultSet result = ps.executeQuery();
            
            if (result.next()) {
                response.sendRedirect("register.html?ExitsUser=1");
                return;
            }
            
            MessageDigest md = MessageDigest.getInstance("SHA-256");
            byte[] hashBytes = md.digest(password.getBytes());
            StringBuilder sb = new StringBuilder();
            
            for (byte b : hashBytes) {
                sb.append(String.format("%02x", b));
            }
            
            String hashPassword = sb.toString();
            
            PreparedStatement pst = con.prepareStatement("INSERT INTO users(name,email,username,password) VALUES (?,?,?,?) ");
            pst.setString(1, name);
            pst.setString(2, email);
            pst.setString(3, username);
            pst.setString(4, hashPassword);

            int rows = pst.executeUpdate();

            if (rows > 0) {
                response.sendRedirect("index.html?success=1");
            } else {
                response.sendRedirect("register.html?error=1");
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
