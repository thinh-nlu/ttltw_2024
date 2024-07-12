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
    int sumUser = dao2.getUserCount();
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
            </div>
        </div>
        <section class="content">
            <div class="container mt-3">
                <h1 class="text-center">Thêm sản phẩm</h1>
                <!-- form -->
                <form action="../add_product" method="post" enctype="multipart/form-data">
                    <!-- title -->
                    <div class="form-outline mb-4 w-50 m-auto">
                        <label for="product_title" class="form-label">Tên sản phẩm</label>
                        <input type="text" name="product_title" id="product_title" class="form-control"
                               placeholder="Nhập sản phẩm" autocomplete="off" required="required">
                    </div>

                    <div class="form-outline mb-4 w-50 m-auto">
                        <label for="unit" class="form-label">Đơn vị</label>
                        <select class="form-control" id="unit" name="unit" required="required">
                            <option value="kg">Kg</option>
                            <option value="g">g</option>
                        </select>

                    </div>
                    <!-- price -->
                    <div class="form-outline mb-4 w-50 m-auto">
                        <label for="product_price" class="form-label">Giá sản phẩm</label>
                        <input type="number" name="product_price" id="product_price" class="form-control"
                               placeholder="Nhập giá sản phẩm" autocomplete="off" required="required">
                    </div>
                    <!-- keywords -->
                    <div class="form-outline mb-4 w-50 m-auto">
                        <label for="product_keyword" class="form-label">Từ khóa</label>
                        <input type="text" name="product_keyword" id="product_keyword" class="form-control"
                               placeholder="Nhập từ khóa" autocomplete="off" required="required">
                    </div>

                    <div class="form-outline mb-4 w-50 m-auto">
                        <label for="quantity" class="form-label">Số lượng</label>
                        <input type="number" name="quantity" id="quantity" class="form-control"
                               placeholder="Nhập số lượng" autocomplete="off" required="required">
                    </div>

                    <div class="form-outline mb-4 w-50 m-auto">
                        <label for="product_category" class="form-label">Loại</label>
                        <select class="form-control" id="product_category" name="product_category" required="required">
                            <option value="rau">Rau</option>
                            <option value="cu">Củ</option>
                            <option value="hat">Hạt</option>
                            <option value="qua">Quả</option>
                        </select>
                    </div>

                    <!-- image -->
                    <div class="form-outline mb-4 w-50 m-auto">
                        <label for="product_image" class="form-label">Hình ảnh sản phẩm</label>
                        <input type="file" name="product_image" id="product_image" class="form-control"
                               required="required">
                    </div>

                    <div class="form-outline mb-4 w-50 m-auto">
                        <label for="unit_price" class="form-label">Đơn Giá</label>
                        <input type="number" name="unit_price" id="unit_price" class="form-control"
                               required="required">
                    </div>

                    <div class="form-outline mb-4 w-50 m-auto">
                        <label for="product_descrip" class="form-label">Mô tả sản phẩm</label>
                        <input type="text" name="product_descrip" id="product_descrip" class="form-control"
                               required="required">
                    </div>


                    <!-- submit button -->
                    <div class="form-outline mb-4 w-50 m-auto pt-2">
                        <input type="submit" name="insert_product" class="btn btn-info mb-3 px-3" value="Thêm sản phẩm">
                    </div>
                </form>
            </div>


        </section>
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
