
<%@page contentType="text/html" pageEncoding="UTF-8"%>

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
        <title>Admin Dashboard</title>

        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">

        <style>

            body{
                background:#f4f7fc;
                overflow-x:hidden;
            }

            /* SIDEBAR */
            .sidebar{
                height:100vh;
                background:#111827;
                color:white;
                position:fixed;
                width:240px;
                transition:.3s;
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
                background:#1f2937;
                color:#fff;
                padding-left:28px;
            }

            .sidebar a.active{
                background:#2563eb;
                color:white;
            }

            /* CONTENT AREA */
            .main{
                margin-left:240px;
                padding:20px;
            }

            /* TOP NAVBAR */
            .topbar{
                background:white;
                padding:15px 20px;
                border-radius:12px;
                box-shadow:0 3px 10px rgba(0,0,0,.05);
            }

            /* CARDS */
            .card-box{
                border:none;
                border-radius:16px;
                transition:.3s;
            }

            .card-box:hover{
                transform:translateY(-5px);
                box-shadow:0 10px 25px rgba(0,0,0,.1);
            }

            /* RESPONSIVE */
            @media(max-width:900px){

                .sidebar{
                    left:-240px;
                }

                .sidebar.show{
                    left:0;
                }

                .main{
                    margin-left:0;
                }

            }

        </style>
    </head>
    <body>


        <!-- SIDEBAR -->
        <div class="sidebar" id="sidebar">

            <h4><i class="fa-solid fa-graduation-cap"></i> Admin</h4>

            <a class="active" href="/ExamPortal/admin/AdminDashboard.jsp"><i class="fa fa-chart-line me-2"></i> Dashboard</a>
            <a href="#"><i class="fa fa-users me-2"></i> Students</a>
            <a href="#"><i class="fa fa-book me-2"></i> Exams</a>
            <a href="#"><i class="fa fa-question-circle me-2"></i> Questions</a>
            <a href="#"><i class="fa fa-chart-bar me-2"></i> Results</a>
            <a href="#"><i class="fa fa-gear me-2"></i> Settings</a>
            <a href="/ExamPortal/logoutServlet"><i class="fa fa-right-from-bracket me-2"></i> Logout</a>

        </div>


        <!-- MAIN CONTENT -->
        <div class="main">

            <!-- TOP BAR -->
            <div class="topbar d-flex justify-content-between align-items-center mb-4">

                <button class="btn btn-outline-primary d-md-none" onclick="toggleSidebar()">
                    <i class="fa fa-bars"></i>
                </button>

                <h5 class="mb-0 fw-bold">Dashboard</h5>

                <div>
                    <i class="fa fa-bell me-3"></i>
                    <i class="fa fa-user-circle"></i>
                </div>

            </div>


            <!-- STATS CARDS -->
            <div class="row g-4">

                <div class="col-md-3">
                    <div class="card card-box p-3">
                        <h6>Total Students</h6>
                        <h3 class="fw-bold text-primary">1,240</h3>
                    </div>
                </div>

                <div class="col-md-3">
                    <div class="card card-box p-3">
                        <h6>Total Exams</h6>
                        <h3 class="fw-bold text-success">52</h3>
                    </div>
                </div>

                <div class="col-md-3">
                    <div class="card card-box p-3">
                        <h6>Questions</h6>
                        <h3 class="fw-bold text-warning">3,400</h3>
                    </div>
                </div>

                <div class="col-md-3">
                    <div class="card card-box p-3">
                        <h6>Results Published</h6>
                        <h3 class="fw-bold text-danger">28</h3>
                    </div>
                </div>

            </div>


            <!-- TABLE SECTION -->
            <div class="card mt-5 p-4">

                <h5 class="mb-3">Recent Students</h5>

                <table class="table table-hover">

                    <thead class="table-light">
                        <tr>
                            <th>ID</th>
                            <th>Name</th>
                            <th>Email</th>
                            <th>Status</th>
                        </tr>
                    </thead>

                    <tbody>
                        <tr>
                            <td>1</td>
                            <td>Rahul</td>
                            <td>rahul@mail.com</td>
                            <td><span class="badge bg-success">Active</span></td>
                        </tr>

                        <tr>
                            <td>2</td>
                            <td>Aman</td>
                            <td>aman@mail.com</td>
                            <td><span class="badge bg-warning">Pending</span></td>
                        </tr>

                        <tr>
                            <td>3</td>
                            <td>Priya</td>
                            <td>priya@mail.com</td>
                            <td><span class="badge bg-danger">Blocked</span></td>
                        </tr>

                    </tbody>
                </table>

            </div>

        </div>


        <script>
            function toggleSidebar() {
                document.getElementById("sidebar").classList.toggle("show");
            }
        </script>

    </body>
</html>
