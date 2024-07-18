<%@ page import="dao.ProductDAO" %>
<%@ page import="database.DBConnect" %>
<%@ page import="dao.OrderDAO" %>
<%@ page import="dao.UserDAO" %>
<%@ page import="java.util.List" %>
<%@ page import="dao.AddressDAO" %>
<%@ page import="model.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page isELIgnored = "false" %>
<%
    User user = (User) session.getAttribute("success");
    ProductDAO dao = new ProductDAO(DBConnect.getConnection());
    List<OrderDetail> list = (List<OrderDetail>) session.getAttribute("orderDetail");
    OrderDAO orderDAO = new OrderDAO(DBConnect.getConnection());
    AddressDAO addressDAO = new AddressDAO(DBConnect.getConnection());


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
                            <p>Thêm sản phẩm</p>
                        </a>
                    </li>
                    <li class="nav-item">
                        <a href="list-products.jsp" class="nav-link">
                            <i class="bi bi-box-seam"></i>
                            <p>Quản lí sản phẩm</p>
                        </a>
                    </li>
                    <li class="nav-item">
                        <a href="warehouse.jsp" class="nav-link">
                            <i class="bi bi-boxes"></i>
                            <p>Quản lí kho</p>
                        </a>
                    </li>
                    <li class="nav-item">
                        <a href="revenueYear.jsp" class="nav-link">
                            <i class="bi bi-bar-chart-line"></i>
                            <p>Thống kê doanh số</p>
                        </a>
                    </li>

                    <%-- Conditionally render user management link based on isAdmin value --%>
                    <% String isAdmin = user.getIsAdmin(); %>
                    <li class="nav-item">
                        <% if ("0".equals(isAdmin)) { %>
                        <a href="list-user.jsp" class="nav-link">
                            <i class="bi bi-person"></i>
                            <p>Quản lí người dùng</p>
                        </a>
                        <% } else if ("3".equals(isAdmin)) { %>
                        <a href="list_user_customer.jsp" class="nav-link">
                            <i class="bi bi-person"></i>
                            <p>Quản lí người dùng</p>
                        </a>
                        <% } %>
                    </li>

                    <%-- Other menu items --%>
                    <li class="nav-item">
                        <a href="list-oders.jsp" class="nav-link">
                            <i class="bi bi-basket"></i>
                            <p>Quản lí đơn hàng</p>
                        </a>
                    </li>

                    <%-- Hide specific menu items if isAdmin is 3 --%>
                    <% if (!"3".equals(isAdmin)) { %>
                    <li class="nav-item">
                        <a href="edit_role.jsp" class="nav-link">
                            <i class="bi bi-person"></i>
                            <p>Quản lí quyền hạn</p>
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
            <h3 class="text-center text-dark pb-3 display-4 font-weight-normal" >Chi tiết đơn hàng</h3>
            <table id="dataTable" class="table table-striped text-center  ">
                <thead class="bg-dark">
                <tr class="text-light">
                    <th>STT</th>
                    <th>Sản phẩm</th>
                    <th>Số lượng</th>
                    <th>Tổng tiền</th>
                </tr>
                </thead>
                <tbody class="bg-light text-dark">
                <%
                    int count = 0;
                    for(OrderDetail o: list) {
                        Product p = dao.getProductById(o.getProductId());
                        count ++;
                %>
                <tr class='text-center text-dark font-weight-normal  '>
                    <td><%=count%></td>
                    <td><img width="50" height="50" class='cart_img' src='../DataWeb/<%=p.getImage()%>'> <%=" "%><%=p.getTitle()%></td>
                    <td><%=o.getQuantity()%></td>
                    <td><%=o.getQuantity() * Double.valueOf(p.getPrice())%><%=" Đồng"%></td>
                </tr>
                <%}%>
                </tbody>
            </table>

        </section>
    </div>
    <script>
        new DataTable('#dataTable', {
            language: {
                processing: "Đang tải dữ liệu",
                search: "Tìm kiếm",
                lengthMenu: "Điều chỉnh số lượng bản ghi trên 1 trang _MENU_ ",
                info: "Bản ghi từ _START_ đến _END_ Tổng công _TOTAL_ bản ghi",
                loadingRecords: "",
                zeroRecords: "Không có tìm kiếm phù hợp",
                emptyTable: "Không có dữ liệu",
                paginate: {
                    first: "Trang đầu",
                    previous: "Trang trước",
                    next: "Trang sau",
                    last: "Trang cuối"
                },
                aria: {
                    sortAscending: "sắp xếp tăng dần",
                    sortDescending: "sắp xếp giảm dần",
                }
            },
        });
    </script>

</div>

<!-- REQUIRED SCRIPTS -->
<script src="https://code.jquery.com/jquery-3.7.1.js"></script>
<script src="https://cdn.datatables.net/2.0.5/js/dataTables.js"></script>
<link href="https://cdn.datatables.net/2.0.5/css/dataTables.dataTables.css" rel="stylesheet">
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