<%@ page import="model.User" %>
<%@ page import="dao.ProductDAO" %>
<%@ page import="database.DBConnect" %>
<%@ page import="dao.OrderDAO" %>
<%@ page import="dao.UserDAO" %>
<%@ page import="model.Product" %>
<%@ page import="java.util.List" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page isELIgnored = "false" %>
<%

    String spageid = request.getParameter("page");
    int pageid = (spageid != null && !spageid.isEmpty()) ? Integer.parseInt(spageid) : 1;
    int totalPerPage =16;
    if(pageid==1){}
    else{
        pageid=pageid-1;
        pageid=pageid* totalPerPage +1;
    }
    ProductDAO dao = new ProductDAO(DBConnect.getConnection());
    List<Product> list = dao.getRecords(pageid, totalPerPage);
    List<Product> allList = dao.getAllProduct();
    double totalProducts = allList.size();
    User user = (User) session.getAttribute("success");
    String updateProductMes = (String) session.getAttribute("updateProductMes");
    if(updateProductMes == null) updateProductMes = "";

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
    <script src="https://code.jquery.com/jquery-3.7.1.js"></script>
    <script src="https://cdn.datatables.net/2.0.5/js/dataTables.js"></script>
    <link href="https://cdn.datatables.net/2.0.5/css/dataTables.dataTables.css" rel="stylesheet">
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
                <div class="row mb-2">
                    <div class="col-sm-6">
                        <h1 class="m-0">TRANG QUẢN LÍ</h1>
                    </div>
                </div>
            </div>
        </div>
        <section class="content">
            <h3 class="text-center text-dark pb-3 display-4 font-weight-normal" >Tất cả sản phẩm</h3>
            <%
                if(updateProductMes.equals("Cập nhật sản phẩm thành công")) {
            %>
            <h2 class="text-center text-success"><%=updateProductMes%></h2>
            <%}else{%>
            <h2 class="text-center text-danger"><%=updateProductMes%></h2>
            <%}
                session.removeAttribute("updateProductMes");
            %>
            <div class="px-lg-5 pt-xl-1">
                <table id="dataTable" class="table table-striped text-center ">
                    <thead class="bg-dark">
                    <tr class="text-light">
                        <th>ID</th>
                        <th>Tên sản phẩm </th>
                        <th>Hình ảnh sản phẩm </th>
                        <th>Giá</th>
                        <th>Đơn giá</th>
                        <th>Chỉnh sửa</th>
                        <th>Xóa</th>
                    </tr>
                    </thead>
                    <tbody class="bg-light text-dark">
                    <%
                        for (Product p: allList) {
                            if (p!=null) {
                    %>
                    <tr class='text-center text-dark font-weight-normal  '>
                        <td><%=p.getId()%></td>
                        <td><%=p.getTitle()%></td>
                        <td><img width="50" height="50" class='cart_img' src='../DataWeb/<%=p.getImage()%>'></td>

                        <td><%=p.getPrice()%></td>
                        <td><%=p.getPrice()+"/"+p.getUnitPrice()+p.getUnit()%></td>
                        <td><a href="edit_products.jsp?id=<%=p.getId()%>" class='text-dark'><i class=" bi bi-pencil-square"> </i></a></td>
                        <td><a href="../delete?id=<%=p.getId()%>" class='text-dark'><i class="bi bi-trash"></i></a></td>
                        <%
                                }
                            }
                        %>
                    </tr>

                    </tbody>
                </table>

            </div>
        </section>
    </div>

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
