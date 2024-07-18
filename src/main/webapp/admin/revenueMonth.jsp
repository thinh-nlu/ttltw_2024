

<%@ page import="model.User" %>
<%@ page import="dao.ProductDAO" %>
<%@ page import="database.DBConnect" %>
<%@ page import="dao.OrderDAO" %>
<%@ page import="dao.UserDAO" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page isELIgnored = "false" %>
<%
    User user = (User) session.getAttribute("success");
    ProductDAO dao = new ProductDAO(DBConnect.getConnection());
    OrderDAO dao1 = new OrderDAO(DBConnect.getConnection());
    UserDAO dao2 = new UserDAO(DBConnect.getConnection());



%>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Nông Lâm Xanh</title>

    <!-- Google Font: Source Sans Pro -->
    <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Source+Sans+Pro:300,400,400i,700&display=fallback">
    <!-- Font Awesome Icons -->
    <link rel="stylesheet" href="../css/all.css">

    <link rel="stylesheet" href="../css/all.min.css">
    <!-- overlayScrollbars -->
    <link rel="stylesheet" href="../css/OverlayScrollbars.min.css">
    <!-- Theme style -->
    <link rel="stylesheet" href="../css/adminlte.min.css">
    <link rel="stylesheet" href="../asset/bootstrap-icons-1.11.1/bootstrap-icons.css">
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
</head>

<body class="hold-transition lightblue-mode sidebar-mini layout-fixed layout-navbar-fixed layout-footer-fixed">
<div class="wrapper">


    <nav class="main-header navbar navbar-expand navbar-white navbar-light">
        <!-- Left navbar links -->
        <ul class="navbar-nav">
            <li class="nav-item">
                <a class="nav-link" data-widget="pushmenu" href="#" role="button"><i class="fas fa-bars"></i></a>
            </li>
            <li class="nav-item d-none d-sm-inline-block">
                <a href="../index.jsp" class="nav-link">Trang chủ</a>
            </li>

        </ul>

        <!-- Right navbar links -->
        <ul class="navbar-nav ml-auto">
            <!-- Navbar Search -->
            <li class="nav-item">
                <a class="nav-link" data-widget="navbar-search" href="#" role="button">
                    <i class="fas fa-search"></i>
                </a>
                <div class="navbar-search-block">
                    <form class="form-inline">
                        <div class="input-group input-group-sm">
                            <input class="form-control form-control-navbar" type="search" placeholder="Tìm kiếm" aria-label="Search">
                            <div class="input-group-append">
                                <button class="btn btn-navbar" type="submit">
                                    <i class="fas fa-search"></i>
                                </button>
                                <button class="btn btn-navbar" type="button" data-widget="navbar-search">
                                    <i class="fas fa-times"></i>
                                </button>
                            </div>
                        </div>
                    </form>
                </div>
            </li>

            <li class="nav-item dropdown">
                <a class="nav-link" data-toggle="dropdown" href="#">
                    <i class="far fa-comments"></i>
                    <span class="badge badge-danger navbar-badge">3</span>
                </a>
            </li>

            <li class="nav-item dropdown">
                <a class="nav-link" data-toggle="dropdown" href="#">
                    <i class="far fa-bell"></i>
                    <span class="badge badge-warning navbar-badge">15</span>
                </a>
            </li>
            <li class="nav-item">
                <a class="nav-link" data-widget="fullscreen" href="#" role="button">
                    <i class="fas fa-expand-arrows-alt"></i>
                </a>
            </li>

            <li class="nav-item d-none d-sm-inline-block">
                <a href="${pageContext.request.contextPath}/logout" class="nav-link">Đăng Xuất</a>
            </li>
        </ul>
    </nav>


    <aside class="main-sidebar sidebar-dark-primary elevation-4">


        <div class="sidebar">
            <div class="user-panel mt-3 pb-3 mb-3 d-flex">
                <div class="image">
                    <img src="https://secure.gravatar.com/avatar/02dce7358deff589577dfc8a60342636?s=256&d=mm&r=g" class="img-circle elevation-2" alt="User Image">
                </div>
                <div class="info">
                    <a href="#" class="d-block"><%= user.getName()%></a>
                </div>


            </div>




            <nav class="mt-2">
                <ul class="nav nav-pills nav-sidebar flex-column" data-widget="treeview" role="menu"
                    data-accordion="false">
                    <li class="nav-header"></li>
                    <li class="nav-item">
                        <a href="insert-product.jsp" class="nav-link">
                            <i class="bi bi-plus-square"></i>
                            <p>
                                Thêm sản phẩm
                            </p>
                        </a>
                    </li>
                    <li class="nav-item">
                        <a href="list-products.jsp" class="nav-link">
                            <i class="bi bi-box-seam"></i>
                            <p>Quản lí sản phẩm </p>
                        </a>
                    </li>
                    <li class="nav-item">
                        <a href="revenueYear.jsp" class="nav-link">
                            <i class="bi bi-bar-chart-line"></i>
                            <p>Thống kê doanh số</p>
                        </a>
                    </li>

                    <li class="nav-item">
                        <a href="list-user.jsp" class="nav-link">
                            <i class="bi bi-person"></i>
                            <p>Quản lí người dùng</p>
                        </a>
                    </li>

                    <li class="nav-item">
                        <a href="list-oders.jsp" class="nav-link">
                            <i class="bi bi-basket"></i>
                            <p>Quản lí đơn hàng</p>
                        </a>
                    </li>
                    <li class="nav-item">
                        <a href="#" class="nav-link">
                            <i class="bi bi-person"></i>
                            <p>Giám sát đơn hàng</p>
                        </a>
                    </li>

                    <%-- Kiểm tra và ẩn menu nếu isAdmin là 3 --%>
                    <%   String isAdmin = user.getIsAdmin();
                        if (!isAdmin.equals("3")) { %>




                    <li class="nav-item">
                        <a href="edit_role.jsp" class="nav-link">
                            <i class="bi bi-person"></i>
                            <p>Quản lí quyền hạng</p>
                        </a>
                    </li>

                    <li class="nav-item">
                        <a href="list-employee.jsp" class="nav-link">
                            <i class="bi bi-person"></i>
                            <p>Quản lí nhân viên</p>
                        </a>
                    </li>

                    <li class="nav-item">
                        <a href="list-log.jsp" class="nav-link">
                            <i class="bi bi-clipboard2-data-fill"></i>
                            <p>Quản Lí Log</p>
                        </a>
                    </li>
                    <% } %>

                    <li class="nav-item">
                        <a href="list_discount.jsp" class="nav-link">
                            <i class="bi bi-person"></i>
                            <p>Khuyến mãi sản phẩm</p>
                        </a>
                    </li>


                </ul>
            </nav>
        </div>
    </aside>


    <div class="content-wrapper">
        <div class="content-header">
            <div class="container-fluid">
                <div class="row mb-2">
                    <div class="col-sm-6">
                        <h1 class="m-0">TRANG QUẢN LÍ</h1>
                    </div>
                </div>
            </div>
        </div>

        <section class="content">
            <ul class="nav nav-tabs pl-lg-5">
                <li class="nav-item">
                    <a class="nav-link " aria-current="page" href="revenueYear.jsp">Doanh thu tháng theo năm</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link active" href="revenueMonth.jsp">Doanh thu ngày theo tháng</a>
                </li>
            </ul>
            <div>
                <label for="monthSelect">Chọn tháng:</label>
                <select id="monthSelect" onchange="updateChart()">
                    <option value="1">Tháng 1</option>
                    <option value="2">Tháng 2</option>
                    <option value="3">Tháng 3</option>
                    <option value="4">Tháng 4</option>
                    <option value="5">Tháng 5</option>
                    <option value="6">Tháng 6</option>
                    <option value="7">Tháng 7</option>
                    <option value="8">Tháng 8</option>
                    <option value="9">Tháng 9</option>
                    <option value="10">Tháng 10</option>
                    <option value="11">Tháng 11</option>
                    <option value="12">Tháng 12</option>
                </select>
            </div>
            <div>
                <label for="yearSelect">Chọn năm:</label>
                <select id="yearSelect" onchange="updateChart()">
                    <option value="2022">2022</option>
                    <option value="2023">2023</option>
                    <option value="2024" selected>2024</option>
                </select>
            </div>
            <div style="width: 800px;"><canvas id="myChart"></canvas></div>
        </section>

        <script>
            var xValues = [];
            var yValues = [];
            var myChart = null; // Khai báo biến myChart để lưu trữ biểu đồ

            function updateChart() {
                var month = document.getElementById('monthSelect').value;
                var year = document.getElementById('yearSelect').value;

                fetch("../DailyRevenue?month="+month+"&year="+year)
                    .then(response => response.json())
                    .then(data => {
                        xValues = Object.keys(data); // Ngày trong tháng
                        yValues = Object.values(data); // Doanh thu tương ứng

                        if (myChart) {
                            myChart.destroy(); // Hủy biểu đồ cũ trước khi tạo biểu đồ mới
                        }

                        myChart = new Chart(document.getElementById('myChart'), {
                            type: "bar",
                            data: {
                                labels: xValues,
                                datasets: [{
                                    data: yValues,
                                    backgroundColor: "#80AF81"
                                }]
                            },
                            options: {
                                legend: { display: false },
                                title: {
                                    display: true,
                                    text: "Thống kê doanh thu các  ngày trong tháng"+" "+month+" trong năm " + year
                                }
                            }
                        });
                    })
                    .catch(error => console.error('Error fetching revenue data:', error));
            }

            document.addEventListener('DOMContentLoaded', (event) => {
                updateChart();
            });
        </script>
    </div>


</div>

<!-- REQUIRED SCRIPTS -->
<script src="../js/jquery.min.js"></script>
<script src="../js/bootstrap.bundle.min.js"></script>
<script src="../js/jquery.overlayScrollbars.min.js"></script>
<script src="../js/adminlte.js"></script>
<script src="../js/jquery.mousewheel.js"></script>
<script src="../js/raphael.min.js"></script>
<script src="../js/jquery.mapael.min.js"></script>
<script src="../js/usa_states.min.js"></script>
<script src="../js/Chart.min.js"></script>
<%--<script src="../js/demo.js"></script>--%>
<script src="../js/dashboard2.js"></script>
</body>

</html>
