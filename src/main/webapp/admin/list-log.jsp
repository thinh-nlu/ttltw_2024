<%@ page import="model.User" %>
<%@ page import="dao.ProductDAO" %>
<%@ page import="database.DBConnect" %>
<%@ page import="dao.OrderDAO" %>
<%@ page import="dao.UserDAO" %>
<%@ page import="model.Product" %>
<%@ page import="java.util.List" %>
<%@ page import="model.Log" %>
<%@ page import="dao.LogDAO" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page isELIgnored = "false" %>
<%
    LogDAO logDAO  = new LogDAO(DBConnect.getConnection());
    List<Log> logList = logDAO.getAllLogs();
    User user = (User) session.getAttribute("success");

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
            <h3 class="text-center text-dark pb-3 display-4 font-weight-normal" >Tất cả Log</h3>
            <div class="pl-4">
                <select class="form-select " aria-label="" onchange="redirectToSelectedPage(this)">
                    <option selected>Tất cả Log</option>
                    <option value="list-log-employee.jsp" >Log của nhân viên</option>
                    <option value="list-log-customer.jsp" >Log của khách hàng</option>
                </select>
            </div>
            <div class="pt-2 pl-4">
                <button type="button" class="btn btn-danger" onclick="deleteAllLogs()">Xóa tất cả log</button>

            </div>

            <div class="px-lg-5 pt-xl-1">
                <table id="dataTable" class="table table-striped text-center ">
                    <thead class="bg-dark">
                    <tr class="text-light">
                        <th>ID</th>
                        <th>Cấp độ</th>
                        <th>Nguồn</th>
                        <th>ID tài khoản</th>
                        <th>IP</th>
                        <th>Nội Dung</th>
                        <th>Thời gian</th>
                        <th colspan="1">
                           <button id="select-all" class="btn btn-primary btn-sm ml-2">Chọn tất cả</button>
                        </th>
                        <th>
                            <button id="delete-logs" class="btn btn-danger btn-sm ml-2">Xóa</button>
                        </th>
                    </tr>
                    </thead>
                    <tbody class="bg-light text-dark">
                    <%
                        for (Log l : logList) {
                            if (l != null) {
                    %>
                    <tr class='text-center text-dark font-weight-normal'>
                        <td><%= l.getId() %></td>
                        <%
                            String levelClass = "";
                            String levelText = "";
                            switch (l.getLevel()) {
                                case 0:
                                    levelClass = "text-info";
                                    levelText = "THÔNG TIN";
                                    break;
                                case 1:
                                    levelClass = "text-secondary";
                                    levelText = "CẢNH BÁO";
                                    break;
                                case 2:
                                    levelClass = "text-warning";
                                    levelText = "NGUY HIỂM";
                                    break;
                                case 3:
                                    levelClass = "text-danger";
                                    levelText = "BÁO ĐỘNG";
                                    break;
                                default:
                                    levelClass = "text-dark";
                                    levelText = "KHÔNG XÁC ĐỊNH";
                                    break;
                            }
                        %>
                        <td class="<%= levelClass %>"><%= levelText %></td>
                        <td><%= l.getSrc() %></td>
                        <td><%= l.getUserId() %></td>
                        <td><%= l.getIp() %></td>
                        <td><%= l.getContent() %></td>
                        <td><%= l.getCreatAt() %></td>
                        <td><a class='text-dark hover' onclick="deleteLog(<%= l.getId() %>)"><i class="bi bi-trash"></i></a></td>
                        <td colspan="2">
                            <div class="form-check justify-content-center text-center">
                                <input class="form-check-input order-checkbox" type="checkbox" name="orderCheckbox" value="<%=l.getId()%>" id="<%=l.getId()%>">
                            </div>
                        </td>
                    </tr>
                    <%
                            }
                        }
                    %>
                    </tbody>
                </table>
                <script>
                    function deleteAllLogs() {
                        Swal.fire({
                            title: 'Xác nhận xóa',
                            text: "Bạn có chắc chắn muốn xóa tất cả log?",
                            icon: 'warning',
                            showCancelButton: true,
                            confirmButtonColor: '#3085d6',
                            cancelButtonColor: '#d33',
                            confirmButtonText: 'Xác nhận',
                            cancelButtonText: 'Hủy bỏ'
                        }).then((result) => {
                            if (result.isConfirmed) {
                                fetch('${pageContext.request.contextPath}/deleteAllLogs', {
                                    method: 'POST'
                                })
                                    .then(response => {
                                        if (response.ok) {
                                            Swal.fire(
                                                'Đã xóa!',
                                                'Tất cả log đã được xóa.',
                                                'success'
                                            ).then(() => {
                                                location.reload();
                                            });
                                        } else {
                                            console.log("Có lỗi xảy ra khi xóa tất cả log");
                                            Swal.fire(
                                                'Lỗi!',
                                                'Xảy ra lỗi khi xóa log.',
                                                'error'
                                            );
                                        }
                                    })
                                    .catch(err => {
                                        console.error("Lỗi khi gửi yêu cầu xóa tất cả log: " + err);
                                        Swal.fire(
                                            'Lỗi!',
                                            'Đã xảy ra lỗi khi gửi yêu cầu.',
                                            'error'
                                        );
                                    });
                            }
                        });
                    }
                    function deleteLog(id) {
                        $.ajax({
                            url: "${pageContext.request.contextPath}/RemoveLogAdmin",
                            type: "GET",
                            data: {
                                id: id
                            },
                            success: function () {
                                $("#logRow" + id).remove();
                                location.reload();// Xóa dòng log khỏi bảng sau khi xóa thành công
                            },
                            error: function () {
                                alert("Đã xảy ra lỗi khi xóa log.");
                            }
                        });
                    }
                    function redirectToSelectedPage(select) {
                        var selectedOption = select.value;
                        if (selectedOption) {
                            window.location.href = selectedOption;
                        }
                    }
                    // new DataTable('#dataTable', {
                    //     language: {
                    //         processing: "Đang tải dữ liệu",
                    //         search: "Tìm kiếm",
                    //         lengthMenu: "Điều chỉnh số lượng bản ghi trên 1 trang _MENU_ ",
                    //         info: "Bản ghi từ _START_ đến _END_ Tổng công _TOTAL_ bản ghi",
                    //         loadingRecords: "",
                    //         zeroRecords: "Không có tìm kiếm phù hợp",
                    //         emptyTable: "Không có dữ liệu",
                    //         paginate: {
                    //             first: "Trang đầu",
                    //             previous: "Trang trước",
                    //             next: "Trang sau",
                    //             last: "Trang cuối"
                    //         },
                    //         aria: {
                    //             sortAscending: "sắp xếp tăng dần",
                    //             sortDescending: "sắp xếp giảm dần",
                    //         }
                    //     },
                    //     columnDefs: [
                    //         { orderable: false, targets: [ 7, 8] } // Chỉ định các cột cần tắt sắp xếp, chỉ số cột bắt đầu từ 0
                    //     ],
                    //     layout: {
                    //         bottomEnd: {
                    //             paging: {
                    //                 boundaryNumbers: false
                    //             }
                    //         }
                    //     }
                    // });
                </script>
                <script>
                    document.addEventListener('DOMContentLoaded', function() {
                        const selectAllButton = document.getElementById('select-all');
                        const deleteOrdersButton = document.getElementById('delete-logs');
                        const dataTable = new DataTable('#dataTable', {
                            language: {
                                processing: "Đang tải dữ liệu",
                                search: "Tìm kiếm",
                                lengthMenu: "Điều chỉnh số lượng bản ghi trên 1 trang _MENU_ ",
                                info: "Bản ghi từ _START_ đến _END_ Tổng cộng _TOTAL_ bản ghi",
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
                                { orderable: false, targets: [0, 7, 8] } // Chỉ định các cột cần tắt sắp xếp, chỉ số cột bắt đầu từ 0
                            ],
                            layout: {
                                bottomEnd: {
                                    paging: {
                                        boundaryNumbers: false
                                    }
                                }
                            }
                        });

                        selectAllButton.addEventListener('click', function() {
                            const allCheckboxes = dataTable.$('.order-checkbox');
                            const allChecked = Array.from(allCheckboxes).every(checkbox => checkbox.checked);
                            allCheckboxes.each(function() {
                                this.checked = !allChecked;
                            });
                        });

                        deleteOrdersButton.addEventListener('click', function() {
                            const selectedOrderIds = Array.from(dataTable.$('.order-checkbox:checked'))
                                .map(checkbox => checkbox.value);

                            if (selectedOrderIds.length > 0) {
                                if (confirm('Bạn có chắc chắn muốn xóa log này không?')) {
                                    const form = document.createElement('form');
                                    form.method = 'GET';
                                    form.action = '${pageContext.request.contextPath}/RemoveLogAdmin';

                                    selectedOrderIds.forEach(orderId => {
                                        const input = document.createElement('input');
                                        input.type = 'hidden';
                                        input.name = 'id';
                                        input.value = orderId;
                                        form.appendChild(input);
                                    });

                                    document.body.appendChild(form);
                                    form.submit();
                                }
                            } else {
                                alert('Vui lòng chọn ít nhất một log để xóa.');
                            }
                        });
                    });
                </script>






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
