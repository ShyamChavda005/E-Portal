
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%
    if (session.getAttribute("studentUsername") == null) {
        response.sendRedirect("/ExamPortal");
        return;
    } 
%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <form method="post" action="/ExamPortal/logoutServlet">
            
            <h1>Hello <% out.println(session.getAttribute("studentUsername")); %>!</h1>
        
            <button name="logout"> Logout </button>
        </form>
    </body>
</html>
