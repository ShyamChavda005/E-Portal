<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*" %>

<%
    if (session.getAttribute("adminUsername") == null) {
        response.sendRedirect("/ExamPortal");
        return;
    }
%>

<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <title>Admin - Exams</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
        <link rel="stylesheet" href="https://cdn.datatables.net/1.13.6/css/dataTables.bootstrap5.min.css">
        <link rel="stylesheet" href="https://cdn.datatables.net/buttons/2.4.1/css/buttons.bootstrap5.min.css">

        <style>

            body{
                background:#f1f5f9;
            }

            /* SIDEBAR */
            .sidebar{
                height:100vh;
                background:#0f172a;
                color:white;
                position:fixed;
                width:240px;
            }

            .sidebar h4{
                text-align:center;
                padding:20px 0;
                border-bottom:1px solid rgba(255,255,255,.1);
            }

            .sidebar a{
                display:block;
                color:#cbd5e1;
                padding:14px 20px;
                text-decoration:none;
                transition:.3s;
            }

            .sidebar a:hover{
                background:#1e293b;
                color:#fff;
                padding-left:28px;
            }

            .sidebar a.active{
                background:#2563eb;
                color:white;
            }

            /* MAIN */
            .main{
                margin-left:240px;
                padding:25px;
            }

            /* TOPBAR */
            .topbar{
                background:white;
                padding:15px 25px;
                border-radius:14px;
                box-shadow:0 3px 12px rgba(0,0,0,.05);
            }

            /* CARD */
            .card-box{
                border:none;
                border-radius:18px;
                box-shadow:0 4px 18px rgba(0,0,0,.05);
            }

            /* TABLE HEADER */
            .table thead{
                background:#2563eb;
                color:white;
            }

            /* STATUS BADGES */
            .badge-active{
                background:#22c55e;
            }
            .badge-inactive{
                background:#64748b;
            }

            /* DATATABLE STYLE */
            .dataTables_wrapper .dataTables_filter input{
                border-radius:8px;
                padding:6px 10px;
            }

            .dataTables_wrapper .dataTables_length select{
                border-radius:8px;
                padding:4px;
            }

            .dt-buttons .btn{
                margin-right:6px;
            }

        </style>
    </head>

    <body>

        <!-- SIDEBAR -->
        <div class="sidebar">

            <h4><i class="fa-solid fa-graduation-cap"></i> Admin</h4>

            <a href="/ExamPortal/admin/AdminDashboard.jsp"><i class="fa fa-chart-line me-2"></i> Dashboard</a>
            <a href="#"><i class="fa fa-users me-2"></i> Students</a>
            <a class="active" href="#"><i class="fa fa-book me-2"></i> Exams</a>
            <a href="#"><i class="fa fa-question-circle me-2"></i> Questions</a>
            <a href="#"><i class="fa fa-chart-bar me-2"></i> Results</a>
            <a href="#"><i class="fa fa-gear me-2"></i> Settings</a>
            <a href="/ExamPortal/logoutServlet"><i class="fa fa-right-from-bracket me-2"></i> Logout</a>

        </div>

        <!-- MAIN -->
        <div class="main">

            <div class="topbar d-flex justify-content-between align-items-center mb-4">
                <h5 class="fw-bold mb-0">Exam Management</h5>

                <button class="btn btn-primary shadow-sm" data-bs-toggle="modal" data-bs-target="#examModal">
                    <i class="fa fa-plus me-2"></i>Create Exam
                </button>
            </div>

            <div id="msg"></div>

            <div class="card card-box p-4">

                <h5 class="fw-bold mb-3">Existing Exams</h5>

                <table id="examTable" class="table table-hover align-middle">
                    <thead>
                        <tr>
                            <th>ID</th>
                            <th>Title</th>
                            <th>Subject</th>
                            <th>Marks</th>
                            <th>Passing</th>
                            <th>Duration</th>
                            <th>Start</th>
                            <th>End</th>
                            <th>Attempts</th>
                            <th>Created</th>
                            <th>Status</th>
                            <th>Actions</th>
                        </tr>
                    </thead>

                    <tbody>

                        <%
                            try {
                                Class.forName("com.mysql.cj.jdbc.Driver");
                                Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/exam", "root", "");

                                PreparedStatement ps = con.prepareStatement("SELECT * FROM examcreate ORDER BY id DESC");
                                ResultSet rs = ps.executeQuery();

                                while (rs.next()) {
                        %>

                        <tr>
                            <td><%=rs.getInt("id")%></td>
                            <td><%=rs.getString("title")%></td>
                            <td><%=rs.getString("subject")%></td>
                            <td><%=rs.getInt("total_marks")%></td>
                            <td><%=rs.getInt("passing_marks")%></td>
                            <td><%=rs.getInt("duration")%> min</td>
                            <td><%=rs.getString("start_dt")%></td>
                            <td><%=rs.getString("end_dt")%></td>
                            <td><%=rs.getInt("max_attempts")%></td>
                            <td><%=rs.getString("create_at")%></td>

                            <td>
                                <span class="badge <%=rs.getString("status").equals("Active") ? "badge-active" : "badge-inactive"%>">
                                    <%=rs.getString("status")%>
                                </span>
                            </td>

                            <td>
                                <button class="btn btn-sm btn-warning"><i class="fa fa-edit"></i></button>
                                <button class="btn btn-sm btn-danger"><i class="fa fa-trash"></i></button>
                            </td>

                        </tr>

                        <%
                                }
                                con.close();
                            } catch (Exception e) {
                                out.println("Error: " + e.getMessage());
                            }
                        %>

                    </tbody>
                </table>
            </div>
        </div>

        <div class="modal fade" id="examModal">
            <div class="modal-dialog modal-lg modal-dialog-centered">
                <div class="modal-content rounded-4 border-0">

                    <div class="modal-header bg-primary text-white">
                        <h5>Create New Exam</h5>
                        <button class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
                    </div>

                    <form action="/ExamPortal/CreateExamServlet" method="post">
                        <div class="modal-body">

                            <div class="row g-3">

                                <div class="col-md-6">
                                    <label>Title</label>
                                    <input type="text" name="title" class="form-control" required>
                                </div>

                                <div class="col-md-6">
                                    <label>Subject</label>
                                    <input type="text" name="subject" class="form-control" required>
                                </div>

                                <div class="col-md-4">
                                    <label>Total Marks</label>
                                    <input type="number" name="total_marks" class="form-control" required>
                                </div>

                                <div class="col-md-4">
                                    <label>Passing Marks</label>
                                    <input type="number" name="passing_marks" class="form-control" required>
                                </div>

                                <div class="col-md-4">
                                    <label>Duration</label>
                                    <input type="number" name="duration" class="form-control" required>
                                </div>

                                <div class="col-md-6">
                                    <label>Start</label>
                                    <input type="datetime-local" name="start_time" class="form-control" required>
                                </div>

                                <div class="col-md-6">
                                    <label>End</label>
                                    <input type="datetime-local" name="end_time" class="form-control" required>
                                </div>

                                <div class="col-md-6">
                                    <label>Status</label>
                                    <select name="status" class="form-select">
                                        <option>Active</option>
                                        <option>Inactive</option>
                                    </select>
                                </div>

                                <div class="col-md-6">
                                    <label>Max Attempts</label>
                                    <input type="number" name="max_attempts" class="form-control">
                                </div>

                            </div>
                        </div>

                        <div class="modal-footer">
                            <button class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                            <button class="btn btn-success">Create Exam</button>
                        </div>
                    </form>

                </div>
            </div>
        </div>

        <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>

        <script src="https://cdn.datatables.net/1.13.6/js/jquery.dataTables.min.js"></script>
        <script src="https://cdn.datatables.net/1.13.6/js/dataTables.bootstrap5.min.js"></script>

        <script src="https://cdn.datatables.net/buttons/2.4.1/js/dataTables.buttons.min.js"></script>
        <script src="https://cdn.datatables.net/buttons/2.4.1/js/buttons.bootstrap5.min.js"></script>

        <script src="https://cdnjs.cloudflare.com/ajax/libs/jszip/3.10.1/jszip.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/pdfmake/0.2.7/pdfmake.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/pdfmake/0.2.7/vfs_fonts.js"></script>

        <script src="https://cdn.datatables.net/buttons/2.4.1/js/buttons.html5.min.js"></script>
        <script src="https://cdn.datatables.net/buttons/2.4.1/js/buttons.print.min.js"></script>

        <script>
            $(document).ready(function () {
                $('#examTable').DataTable({
                    responsive: true,
                    pageLength: 5,
                    lengthMenu: [5, 10, 25, 50],
                    dom: 'Bfrtip',
                    buttons: [
                        {extend: 'copy', className: 'btn btn-secondary btn-sm'},
                        {extend: 'excel', className: 'btn btn-success btn-sm'},
                        {extend: 'pdf', className: 'btn btn-danger btn-sm'},
                        {extend: 'print', className: 'btn btn-primary btn-sm'}
                    ]
                });
            });

            const p = new URLSearchParams(window.location.search);
            if (p.get("success"))
                document.getElementById("msg").innerHTML =
                        `<div class="alert alert-success text-center">Exam Created Successfully</div>`;
        </script>

    </body>
</html>