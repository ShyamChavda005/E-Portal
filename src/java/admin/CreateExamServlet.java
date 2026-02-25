package admin;

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.sql.*;

@WebServlet(urlPatterns = {"/CreateExamServlet"})
public class CreateExamServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        
        String title = request.getParameter("title");
        String subject = request.getParameter("subject");
        String total_marks = request.getParameter("total_marks");
        String passing_marks = request.getParameter("passing_marks");
        String duration = request.getParameter("duration");
        String start_time = request.getParameter("start_time");
        String end_time = request.getParameter("end_time");
        String status = request.getParameter("status");
        String max_attempts = request.getParameter("max_attempts");
        
        out.println(title);
        out.println(subject);
        out.println(total_marks);out.println(passing_marks);out.println(duration);out.println(start_time);
        out.println(end_time);
        out.println(status);
        out.println(max_attempts);
        
        
        try {
             Class.forName("com.mysql.cj.jdbc.Driver");
             Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/exam", "root", "");
             
             if (con == null) out.println("connection not setup");
             
             PreparedStatement pst = con.prepareStatement(""
                     + "INSERT INTO examcreate"
                     + "(title,subject,total_marks,passing_marks,duration,start_dt,end_dt,max_attempts,status) VALUES"
                     + "(?,?,?,?,?,?,?,?,?)");
             
             pst.setString(1, title);
             pst.setString(2, subject);
             pst.setInt(3, Integer.parseInt(total_marks));
             pst.setInt(4, Integer.parseInt(passing_marks));
             pst.setInt(5, Integer.parseInt(duration));
             pst.setString(6, start_time);
             pst.setString(7, end_time);
             pst.setInt(8, Integer.parseInt(max_attempts));
             pst.setString(9, status);
             
             int rs = pst.executeUpdate();
             
             if (rs > 0) {
                 response.sendRedirect("admin/Exam.jsp?success=1");
             } else {
                 response.sendRedirect("admin/Exam.jsp?error=1");
             }
             
        }
        catch (Exception e) {
            out.println("<h2> Exception : " + e.getMessage() + "</h2>");
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
