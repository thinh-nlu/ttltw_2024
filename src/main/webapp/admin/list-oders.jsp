<%@ page import="model.User" %>
<%@ page import="cart.CartProduct" %>
<%@ page import="model.Order" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.List" %>
<%@ page import="dao.OrderDAO" %>
<%@ page import="database.DBConnect" %>
<%@ page import="dao.UserDAO" %>
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
<html lang="en" xmlns="http://www.w3.org/1999/html" xmlns="http://www.w3.org/1999/html">
<head>
  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">

  <!-- Mobile Metas -->
  <meta name="viewport" content="width=device-width, initial-scale=1">

  <!-- Site Metas -->
  <title>NongLamXanh</title>
  <meta name="keywords" content="">
  <meta name="description" content="">
  <meta name="author" content="">

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
  <link rel="stylesheet" href="../asset/bootstrap-icons-1.11.1/bootstrap-icons.css">
</head>
<body>
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
            <% if (!user.getIsAdmin().equals("0")) { %>
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
        <a class="navbar-brand" href="../index.jsp"><img src="../images/logo1.png" class="logo" style="width: 200px;height: 108px" alt=""></a>
      </div>
      <!-- End Header Navigation -->

      <!-- Collect the nav links, forms, and other content for toggling -->
      <div class="collapse navbar-collapse" id="navbar-menu">
        <ul class="nav navbar-nav ml-auto" data-in="fadeInDown" data-out="fadeOutUp">
          <li class="nav-item"><a class="nav-link" href="../index.jsp">Trang Chủ</a></li>
          <li class="nav-item"><a class="nav-link" href="../about.jsp">Giới Thiệu</a></li>
          <li class="dropdown active">
            <a href="#" class="nav-link dropdown-toggle" data-toggle="dropdown">Tiện ích <i class="bi bi-list "></i></a>
            <ul class="dropdown-menu">
              <li><a href="cart.jsp">Giỏ Hàng</a></li>
              <li><a href="address.jsp">Địa chỉ</a></li>
              <li><a href="checkout.jsp">Thanh toán</a></li>
              <li><a href="my-account.jsp">Tài Khoản</a></li>
              <li><a href="wishlist.jsp">Yêu thích</a></li>
            </ul>
          </li>
          <li class="nav-item"><a class="nav-link" href="../gallery.jsp">Cửa Hàng</a></li>
          <li class="nav-item"><a class="nav-link" href="../contact-us.jsp">Liên hệ </a></li>
        </ul>
        <li class="nav-item">
          <form method="post" action="../searchProduct">
            <div class="input-group rounded">
              <input type="search" class="form-control rounded" placeholder="Tìm kiếm sản phẩm" aria-label="Search" aria-describedby="search-addon" id="keyword" name="keyword">
              <input type="submit" value="Tìm kiếm" class="btn btn-outline-success" name="search_data_product">
            </div>
          </form>

        </li>
      </div>
      <!-- /.navbar-collapse -->

      <!-- Start Atribute Navigation -->
      <div class="attr-nav">
        <ul>
          <li class="side-menu"><a href="cart.jsp">
            <i class="fa fa-shopping-bag"></i>
            <span class="badge"><%=cartProduct.getTotal()%></span>
            <p>Giỏ hàng</p>
          </a></li>
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

<!-- Start Top Search -->
<div class="top-search">
  <div class="container">
    <div class="input-group">
      <span class="input-group-addon"><i class="fa fa-search"></i></span>
      <input type="text" class="form-control" placeholder="Search">
      <span class="input-group-addon close-search"><i class="fa fa-times"></i></span>
    </div>
  </div>
</div>
<!-- End Top Search -->

<div class="px-lg-5 pt-xl-5">
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
      <th>Trạng thái</th>
      <th>Chi tiết</th>
    </tr>
    </thead>
    <tbody class="bg-light text-dark">
    <%for(Order o: orderList) {
    %>
    <tr class='text-center text-dark font-weight-normal  '>
      <td><%=o.getId()%></td>
      <td><%=userDAO.getUserById(o.getUserId()).getName()%></td>
      <td><%=o.getAmountDue() + "VND"%></td>
      <td><%=o.getInvoiceNumber()%></td>
      <td><%=o.getOrderDate()%></td>
      <td><%=o.getOrderStatus().equals("complete") ? "Đã thanh toán" : "Đang chờ xử lý"%></td>
      <td><a href="../orderDetail?orderId=<%=o.getId()%>" class='text-dark'><i class="bi bi-arrow-right-circle"></i></a></td>
      <%
        }%>
    </tr>
    </tbody>
  </table>
  <%
    }
  %>
</div>

<!-- Start Footer  -->
<footer>
  <div id="container_footer"></div>
  <jsp:include page="../include/footer.jsp"/>
</footer>
<!-- End Footer  -->

<a href="#" id="back-to-top" title="Back to top" style="display: none;"><i class="bi-arrow-up-short"></i></a>

<!-- ALL JS FILES -->
<script src="../js/jquery-3.2.1.min.js"></script>
<script src="../js/popper.min.js"></script>
<script src="../js/bootstrap.min.js"></script>
<!-- ALL PLUGINS -->
<script src="../js/jquery.superslides.min.js"></script>
<script src="../js/bootstrap-select.js"></script>
<script src="../js/inewsticker.js"></script>
<script src="js/bootsnav.js."></script>
<script src="../js/images-loded.min.js"></script>
<script src="../js/isotope.min.js"></script>
<script src="../js/owl.carousel.min.js"></script>
<script src="../js/baguetteBox.min.js"></script>
<script src="../js/form-validator.min.js"></script>
<script src="../js/contact-form-script.js"></script>
<script src="../js/custom.js"></script>
</body>
</html>