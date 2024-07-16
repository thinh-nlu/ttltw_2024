<%@ page import="model.User" %>
<%@ page import="dao.ProductDAO" %>
<%@ page import="database.DBConnect" %>
<%@ page import="dao.OrderDAO" %>
<%@ page import="dao.UserDAO" %>
<%@ page import="model.Product" %>
<%@ page import="java.util.List" %>
<%@ page import="model.Log" %>
<%@ page import="dao.LogDAO" %>
<%@ page import="cart.CartProduct" %>
<%@ page import="model.Order" %>
<%@ page import="java.util.ArrayList" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page isELIgnored = "false" %>
<%
    CartProduct cartProduct = (CartProduct) session.getAttribute("cart");
    if(cartProduct == null) cartProduct = new CartProduct();
    User user = (User) session.getAttribute("success");
    List<Order> orderList = new ArrayList<>();
    OrderDAO dao = new OrderDAO(DBConnect.getConnection());
    UserDAO userDAO = new UserDAO(DBConnect.getConnection());
    if(user!=null) orderList = dao.getAllOrder();

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
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@10"></script>
</head>
<style>
    .form-check {
        display: flex;
        align-items: center;
        justify-content: center;
    }

    .form-check-input {
        margin: 0;
        width: 18px;
        height: 18px;
    }

    #delete-orders {
        margin-left: 10px;
    }

    .hoverable:hover {
        background-color: #f1f1f1;
        cursor: pointer;
    }

    .table td, .table th {
        vertical-align: middle;
        text-align: center;
        padding: 10px;
    }

    .d-flex {
        display: flex;
        align-items: center;
        justify-content: flex-end;
        padding: 0 10px;
        width: 100%;
        gap: 10px;
    }

    #delete-orders {
        white-space: nowrap;
    }

    .btn-warning {
        background-color: #ffc107;
        border-color: #ffc107;
        color: #fff;
    }

    .btn-success {
        background-color: #28a745;
        border-color: #28a745;
        color: #fff;
    }

    .form-check-input {
        width: 18px;
        height: 18px;
        margin-left: auto;
    }

</style>
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
            <h3 class="text-center text-dark pb-3 display-4 font-weight-normal" >Tất cả đơn hàng</h3>
            <%
                if(orderList.isEmpty()) {
            %>
            <h2 class="text-center text-danger">Không có đơn hàng nào</h2>
            <%}else{%>
            <table class="table table-striped text-center  ">
                <thead class="bg-dark">
                <tr class="text-light">
                    <th>STT</th>
                    <th>Tên Khách Hàng</th>
                    <th>Tổng tiền</th>
                    <th>Hoá đơn</th>
                    <th>Thời gian</th>
                    <th>Thanh toán</th>
                    <th>Trạng thái</th>
                    <th>Chi tiết</th>
                    <th>
                        <button id="select-all" class="btn btn-primary btn-sm ml-2">Chọn tất cả</button>
                        <button id="delete-orders" class="btn btn-danger btn-sm ml-2">Xóa</button>
                    </th>

                </tr>
                </thead>
                <tbody class="bg-light text-dark">

                <%for(Order o: orderList) {
                    String status = null;
                    String buttonClass = "";
                    if (o.getAddressShipStatus().equals("Chờ xác nhận")){
                        status = "➞ vận chuyển";
                        buttonClass = "btn-warning";
                    } else if (o.getAddressShipStatus().equals("Đang vận chuyển")) {
                        status = "➞ đã vận chuyển";
                        buttonClass = "btn-success";
                    }
                %>

                <tr class='text-center text-dark font-weight-normal  '>
                    <td><%= o.getId() %></td>
                    <td class="hoverable"><%= (userDAO.getUserById(o.getUserId()) != null) ? userDAO.getUserById(o.getUserId()).getName() : "Không xác định" %></td>
                    <td class="hoverable"><%= o.getAmountDue() + " VND" %></td>
                    <td class="hoverable"><%= o.getInvoiceNumber() %></td>
                    <td class="hoverable"><%= o.getOrderDate() %></td>
                    <td class="hoverable"><%= o.getOrderStatus() %></td>
                    <td class="hoverable"><%= o.getAddressShipStatus() %>
                        <%if(!o.getAddressShipStatus().equals("Đơn hàng đã được huỷ")&&!o.getAddressShipStatus().equals("Đã vận chuyển")) {%>
                        <a href="../changeStatus?orderId=<%=o.getId()%>">
                            <button class="btn <%= buttonClass %> cancel-order"><%=status%></button></a>
                        <%}%>
                    </td>
                    <td class="hoverable"><a href="../orderDetail?orderId=<%= o.getId() %>" class='text-dark'><i class="bi bi-arrow-right-circle"></i></a></td>
                    <td>
                        <div class="form-check">
                            <input class="form-check-input order-checkbox" type="checkbox" name="orderCheckbox" value="<%= o.getId() %>" id="order<%= o.getId() %>">
                        </div>
                    </td>
                    <%
                        }%>
                </tr>
                </tbody>
            </table>

            <%
                }
            %>
        </section>
    </div>

</div>


<!-- REQUIRED SCRIPTS -->
<script>
    document.addEventListener('DOMContentLoaded', function() {
        const selectAllButton = document.getElementById('select-all');
        const deleteOrdersButton = document.getElementById('delete-orders');
        const checkboxes = document.querySelectorAll('.order-checkbox');

        selectAllButton.addEventListener('click', function() {
            checkboxes.forEach(checkbox => {
                checkbox.checked = !checkbox.checked;
            });
        });

        deleteOrdersButton.addEventListener('click', function() {
            const selectedOrderIds = Array.from(checkboxes)
                .filter(checkbox => checkbox.checked)
                .map(checkbox => checkbox.value);

            if (selectedOrderIds.length > 0) {
                if (confirm('Bạn có chắc chắn muốn xóa các hóa đơn này không?')) {
                    const form = document.createElement('form');
                    form.method = 'POST';
                    form.action = '${pageContext.request.contextPath}/deleteOrders';

                    selectedOrderIds.forEach(orderId => {
                        const input = document.createElement('input');
                        input.type = 'hidden';
                        input.name = 'orderIds';
                        input.value = orderId;
                        form.appendChild(input);
                    });

                    document.body.appendChild(form);
                    form.submit();
                }
            } else {
                alert('Vui lòng chọn ít nhất một đơn hàng để xóa.');
            }
        });
    });
</script>

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
