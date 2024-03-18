<%@ page import="model.User" %>
<%@ page import="java.util.List" %>
<%@ page import="dao.UserDAO" %>
<%@ page import="database.DBConnect" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page isELIgnored = "false" %>
<%
  User user = (User) session.getAttribute("success");
  UserDAO dao = new UserDAO(DBConnect.getConnection());
  String spageid = request.getParameter("page");
  int pageid = (spageid != null && !spageid.isEmpty()) ? Integer.parseInt(spageid) : 1;
  int totalPerPage =16;
  int activePage = pageid;
  int previousPage = pageid-1;
  int nextPage = pageid+1;
  if(pageid==1){}
  else{
    pageid=pageid-1;
    pageid=pageid* totalPerPage +1;
  }
  List<User> users = dao.getRecords(pageid, totalPerPage);
  List<User> allList = dao.getAllUser();
  double totalProducts = allList.size();
  int totalPage = (int) Math.ceil(totalProducts /totalPerPage);
  String isActive = "";
%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>NongLamXanh</title>
  <link rel="stylesheet" href="../asset/bootstrap-icons-1.11.1/bootstrap-icons.css">
  <!-- Site Icons -->
  <link rel="shortcut icon" href="../images/favicon.ico" type="image/x-icon">
  <link rel="apple-touch-icon" href="../images/apple-touch-icon.png">

  <!-- Bootstrap CSS -->
  <link rel="stylesheet" href="../css/bootstrap.min.css">
  <!-- Site CSS -->
  <link rel="stylesheet" href="../css/style.css">
  <!-- Responsive CSS -->
  <link rel="stylesheet" href="../css/responsive.css">
  <!-- Custom CSS -->
  <link rel="stylesheet" href="../css/custom.css">

  <!--[if lt IE 9]>
  <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
  <script src="https://oss.maxcdn.com/libs/respond.js/1.4.2/respond.min.js"></script>
  <![endif]-->

</head>
<body class="">
<!-- Start Main Top -->
<div class="main-top">
  <div class="container-fluid">
    <div class="row">
      <div class="col-lg-6 col-md-6 col-sm-12 col-xs-12">
        <div class="our-link">
          <ul>
            <li><a href="../tien_ich/my-account.jsp"><i class="fa fa-user s_color"></i> Tài khoản của tôi</a></li>
            <li><a href="../contact-us.jsp"><i class="fas fa-headset"></i> Liên hệ </a></li>
          </ul>
        </div>
      </div>
      <div class="col-lg-6 col-md-6 col-sm-12 col-xs-12">
        <div class="login-register">
          <ul>
            <% if (user != null) { %>
            <% if (user.getIsAdmin().equals("1")) { %>
            <li><a href="../tien_ich/my-account.jsp">Xin chào <%=user.getName()%></a></li>
            <li><a href="${pageContext.request.contextPath}/logout">Đăng Xuất</a></li>
            <%} else {%>
            <li><p>Xin chào <%= user.getName() %></p></li>
            <li><a href="../admin/admin.jsp">Trang Quản Lí</a></li>
            <li><a href="${pageContext.request.contextPath}/logout">Đăng Xuất</a></li>
            <%}%>
            <% } else { %>
            <li><a href="../account/registration.jsp">Đăng Kí</a></li>
            <li><a href="../account/login.jsp">Đăng Nhập</a></li>
            <% } %>
          </ul>
        </div>
      </div>
    </div>
  </div>
</div>
<!-- End Main Top -->
<!-- Start Main Top -->
<header class="main-header">
  <!-- Start Navigation -->
  <nav class="navbar navbar-expand-lg navbar-light bg-light navbar-default bootsnav">
    <div class="container">
      <!-- Start Header Navigation -->
      <div class="navbar-header">
        <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbar-menu" aria-controls="navbars-rs-food" aria-expanded="false" aria-label="Toggle navigation">
          <i class="fa fa-bars"></i>
        </button>
        <a class="navbar-brand " href="../index.jsp"><img src="../images/logo1.png" class="logo " style="width: 200px;height: 108px" alt="" ></a>
      </div>
      <!-- End Header Navigation -->

      <!-- Collect the nav links, forms, and other content for toggling -->
      <div class="collapse navbar-collapse" id="navbar-menu">
        <ul class="nav navbar-nav ml-auto" data-in="fadeInDown" data-out="fadeOutUp">
          <li class="nav-item active"><a class="nav-link" href="../index.jsp">Trang Chủ</a></li>
          <li class="nav-item"><a class="nav-link" href="../about.jsp">Giới Thiệu</a></li>
          <li class="dropdown">
            <a href="#" class="nav-link dropdown-toggle arrow" data-toggle="dropdown">Tiện Ích</a>
            <ul class="dropdown-menu">
              <li><a href="../tien_ich/cart.jsp">Giỏ Hàng</a></li>
              <li><a href="../tien_ich/address.jsp">Thanh Toán</a></li>
              <li><a href="../tien_ich/my-account.jsp">Tài Khoản</a></li>
              <li><a href="../tien_ich/wishlist.jsp">Yêu thích</a></li>
            </ul>
          </li>
          <li class="nav-item"><a class="nav-link" href="../gallery.jsp">Cửa Hàng</a></li>
          <li class="nav-item"><a class="nav-link" href="../contact-us.jsp">Liên Hệ</a></li>
        </ul>
      </div>
      <!-- /.navbar-collapse -->

      <!-- Start Atribute Navigation -->
      <div class="attr-nav">
        <ul>
          <li class="search"><a href="#"><i class="fa fa-search"></i></a></li>
          <li class="side-menu">
            <a href="#">
              <i class="fa fa-shopping-bag"></i>
              <span class="badge">0</span>
              <p>Giỏ Hàng</p>
            </a>
          </li>
        </ul>
      </div>
      <!-- End Atribute Navigation -->
    </div>
    <!-- Start Side Menu -->
    <div class="side">
      <a href="#" class="close-side"><i class="fa fa-times"></i></a>
      <li class="cart-box">
        <ul class="cart-list">
          <li>
            <a href="#" class="photo"><img src="../images/img-pro-01.jpg" class="cart-thumb" alt="" /></a>
            <h6><a href="#">Delica omtantur </a></h6>
            <p>1x - <span class="price">$80.00</span></p>
          </li>
          <li>
            <a href="#" class="photo"><img src="../images/img-pro-02.jpg" class="cart-thumb" alt="" /></a>
            <h6><a href="#">Omnes ocurreret</a></h6>
            <p>1x - <span class="price">$60.00</span></p>
          </li>
          <li>
            <a href="#" class="photo"><img src="../images/img-pro-03.jpg" class="cart-thumb" alt="" /></a>
            <h6><a href="#">Agam facilisis</a></h6>
            <p>1x - <span class="price">$40.00</span></p>
          </li>
          <li class="total">
            <a href="#" class="btn btn-default hvr-hover btn-cart">VIEW CART</a>
            <span class="float-right"><strong>Total</strong>: $180.00</span>
          </li>
        </ul>
      </li>
    </div>
    <!-- End Side Menu -->
  </nav>
  <!-- End Navigation -->
</header>
<!-- End Main Top -->
<h3 class="text-center text-dark pb-3 display-4 font-weight-normal" >Danh sách khách hàng</h3>
<div class="px-lg-5 pt-xl-5 mb-5">
  <c:if test="${not empty deleteSuccess}">
    <p class="text-center text-success">${deleteSuccess}</p>
    <c:remove var="deleteSuccess" scope="session"/>
  </c:if>
  <c:if test="${not empty deleteFailed}">
    <p class="text-center text-danger">${deleteFailed}</p>
    <c:remove var="deleteFailed" scope="session"/>
  </c:if>
  <form method="post" action="../blockUser">
    <table class="table table-striped text-center ">
      <thead class="bg-dark">
      <tr class="text-light">
        <th>ID</th>
        <th>Tên Người Dùng </th>
        <th>Email </th>
        <th>Số Điện Thoại</th>
        <th>Xóa</th>
        <th>Trạng Thai</th>
      </tr>
      </thead>
      <tbody class="bg-light text-dark">
      <%
        if(!users.isEmpty()) {
          for (User u: users) {
            isActive = u.getIsActive();
            int id = u.getId();
      %>
      <tr class='text-center text-dark font-weight-normal  '>
        <td><%=id%></td>
        <td><%=u.getName()%></td>
        <td><%=u.getEmail()%></td>
        <td><%=u.getContact()%></td>
        <td><a href="../deleteUser?id=<%=id%>" class='text-dark'><i class="bi bi-trash"></i></a></td>
        <td>
          <%
            if(isActive.equals("1")) {
          %>
          <!-- Nút Active -->
          <a class="btn btn-success" href="../blockUser?id=<%=id%>" >
            <i class="bi bi-check-circle"></i> Đang Hoạt Động
          </a>
          <%
            } else {
          %>
                  <!-- Nút Block -->
                  <a class="btn btn-danger" href="../blockUser?id=<%=id%>">
                    <i class="bi bi-x-circle"></i> Chặn
                  </a>
          <%}%>
        </td>


      </tr>
      <%
          }
        }
      %>
      </tbody>
    </table>
  </form>
  <nav aria-label="...">
    <ul class="pagination pb-5 justify-content-center">
      <li class="page-item  <%= (activePage==1)?"disabled":"enable"%>">
        <a class="page-link" href="list-user.jsp?page=<%= previousPage %>" aria-label="Previous">
          <i class="bi-arrow-left"></i>
        </a>
      </li>
      <% for (int i = 1; i <= totalPage; i++) { %>
      <li class="page-item <%= (i == activePage) ? "active" : "" %>">
        <a class="page-link" href="list-user.jsp?page=<%= i %>"><%= i %></a>
      </li>
      <% } %>
      <li class="page-item <%= (activePage==totalPage)?"disabled":"enable"%>">
        <a class="page-link" href="list-user.jsp?page=<%= nextPage %>" aria-label="Next">
          <i class="bi-arrow-right"></i>
        </a>
      </li>
    </ul>

  </nav>
</div>
</body>
</html>