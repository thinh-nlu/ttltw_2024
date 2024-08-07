<%@ page import="database.DBConnect" %>
<%@ page import="java.util.List" %>
<%@ page import="cart.CartProduct" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="model.*" %>
<%@ page import="dao.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page isELIgnored = "false" %>
<%
    CartProduct cartProduct = (CartProduct) session.getAttribute("cart");
    if(cartProduct == null) cartProduct = new CartProduct();
    User user = (User) session.getAttribute("success");
    List<Order> orderList = new ArrayList<>();
    List<Order> oderPaidList = new ArrayList<>();
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
            <h3 class="text-center text-dark pb-3 display-4 font-weight-normal" >Tất cả đơn hàng</h3>
            <%
                if(orderList.isEmpty()) {
            %>
            <h2 class="text-center text-danger">Không có đơn hàng nào</h2>
            <%}else{%>
            <table id="dataTable" class="table table-striped text-center  ">
                <thead class="bg-dark">
                <tr class="text-light">
                    <th>STT</th>
                    <th>Tên Khách Hàng</th>
                    <th>Tổng tiền</th>
                    <th>Hoá đơn</th>
                    <th>Thời gian</th>
                    <th>Địa chỉ</th>
                    <th>Thanh toán</th>
                    <th>Trạng thái</th>
                    <th>Chi tiết</th>
                    <th>
                        <button id="select-all" class="btn btn-primary btn-sm ml-2">Chọn tất cả</button>
                        <button id="elete-ordersd" class="btn btn-danger btn-sm ml-2">Xóa</button>
                    </th>

                </tr>
                </thead>
                <tbody class="bg-light text-dark">

                <%for(Order o: orderList) {
                    Address address = dao.getAddressByOrderId(o.getId());
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
                    <td class="hoverable"><%= address.getAddress()%></td>
                    <td class="hoverable"><%= o.getOrderStatus() %></td>
                    <td class="hoverable"><%= o.getAddressShipStatus() %>
                        <%if(!o.getAddressShipStatus().equals("Đơn hàng đã được huỷ")&&!o.getAddressShipStatus().equals("Đã vận chuyển")) {%>
                        <a href="../changeStatus?orderId=<%=o.getId()%>">
                            <button class="btn <%= buttonClass %> cancel-order"><%=status%></button></a>
                        <%}%>
                    </td>
                    <td class="hoverable"><a href="../orderDetailAdmin?orderId=<%= o.getId() %>" class='text-dark'><i class="bi bi-arrow-right-circle"></i></a></td>
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
    <script>
        document.addEventListener('DOMContentLoaded', function() {
            let table = new DataTable('#dataTable', {
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
                columnDefs: [
                    { orderable: false, targets: -1 } // Tắt sắp xếp cho cột cuối cùng
                ]
            });

            function updateSelectAllButtonState() {
                const checkboxes = table.$('.order-checkbox');
                const selectAllButton = document.getElementById('select-all');

                let allChecked = Array.from(checkboxes).every(checkbox => checkbox.checked);
                selectAllButton.textContent = allChecked ? 'Bỏ chọn tất cả' : 'Chọn tất cả';
            }

            document.getElementById('select-all').addEventListener('click', function() {
                const checkboxes = table.$('.order-checkbox');
                const allChecked = Array.from(checkboxes).every(checkbox => checkbox.checked);
                checkboxes.each(function() {
                    this.checked = !allChecked;
                });
                updateSelectAllButtonState();
            });

            document.getElementById('delete-orders').addEventListener('click', function() {
                const selectedOrderIds = Array.from(table.$('.order-checkbox:checked')).map(checkbox => checkbox.value);

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

            table.on('draw', function() {
                updateSelectAllButtonState();

                document.querySelectorAll('.order-checkbox').forEach(checkbox => {
                    checkbox.addEventListener('change', updateSelectAllButtonState);
                });
            });

            updateSelectAllButtonState();
        });
    </script>

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
