<%@ page import="cart.CartProduct" %>
<%@ page import="java.util.Map" %>
<%@ page import="cart.Cart" %>
<%@ page import="java.util.List" %>
<%@ page import="model.*" %>
<%@ page import="dao.OrderDetailDAO" %>
<%@ page import="database.DBConnect" %>
<%@ page import="dao.ProductDAO" %>
<%@ page import="java.util.ArrayList" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page isELIgnored = "false" %>
<%
    CartProduct cartProduct = (CartProduct) session.getAttribute("cart");
    if(cartProduct == null) cartProduct = new CartProduct();
    OrderDetailDAO dao = new OrderDetailDAO(DBConnect.getConnection());
    ProductDAO productDAO = new ProductDAO(DBConnect.getConnection());
    User user = (User) session.getAttribute("success");
    Order order = (Order) session.getAttribute("createOrder");
    List<OrderDetail> orderDetails = new ArrayList<>();
    String messageBuyProduct = (String) session.getAttribute("buyProductMessage");
%>
<!DOCTYPE html>
<html lang="en">
<!-- Basic -->

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

    <!--[if lt IE 9]>
    <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
    <script src="https://oss.maxcdn.com/libs/respond.js/1.4.2/respond.min.js"></script>
    <![endif]-->

</head>

<body>
<div id="container_header"></div>
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
                        <% if (!user.getIsAdmin().equals("0")&&!user.getIsAdmin().equals("3")) { %>
                        <li><a href="../tien_ich/my-account.jsp">Xin chào <%=user.getName()%></a></li>
                        <li><a href="${pageContext.request.contextPath}/logout">Đăng Xuất</a></li>
                        <%}else{%>
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
    <%
        if(messageBuyProduct!=null) {
    %>
    <script>
        alert(<%=messageBuyProduct%>)
    </script>
    <%}
        session.removeAttribute("messageBuyProduct");
    %>
    <%
        if(user == null || order == null) {
    %>
    <script>
        alert("Hãy bắt đầu mua sắm")
        window.location.href = "../gallery.jsp";
    </script>
    <%
        }else{
         orderDetails = dao.getDetailOfOrder(order.getId());
    %>
    <!-- Start Navigation -->
    <nav class="navbar navbar-expand-lg navbar-light bg-light navbar-default bootsnav">
        <div class="container">
            <!-- Start Header Navigation -->
            <div class="navbar-header">
                <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbar-menu" aria-controls="navbars-rs-food" aria-expanded="false" aria-label="Toggle navigation">
                    <i class="fa fa-bars"></i>
                </button>
                <a class="navbar-brand" href="../index.jsp"><img src="../images/logo.png" class="logo" alt=""></a>
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
                            <li><a href="List-address.jsp">Địa chỉ</a></li>
                            <li><a href="checkout.jsp">Thanh toán</a></li>
                            <li><a href="my-account.jsp">Tài Khoản</a></li>
                        </ul>
                    </li>
                    <li class="nav-item"><a class="nav-link" href="../gallery.jsp">Cửa Hàng</a></li>
                    <li class="nav-item"><a class="nav-link" href="../contact-us.jsp">Liên Hệ</a></li>
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
                        <p>Giỏ Hàng</p>
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

<!-- Start All Title Box -->
<div class="all-title-box">
    <div class="container">
        <div class="row">
            <div class="col-lg-12">
                <h2>Thanh Toán</h2>
                <ul class="breadcrumb">
                    <li class="breadcrumb-item"><a href="../gallery.jsp">Cửa Hàng</a></li>
                    <li class="breadcrumb-item active">Thanh Toán</li>
                </ul>
            </div>
        </div>
    </div>
</div>
<!-- End All Title Box -->

<!-- Start Cart  -->
<div class="cart-box-main">
    <div class="container">
        <div class="row">
            <div class="col-sm-6 col-lg-6 mb-3">
                <div class="row">
                    <div class="col-md-12 col-lg-12">
                    </div>
                    <div class="col-md-12 col-lg-12">
                        <div class="order-box">
                            <div class="title-left">
                                <h3>Đơn hàng của bạn</h3>
                                <h4>Số hóa đơn: <%=order.getInvoiceNumber()%></h4>
                            </div>
                            <div class="rounded p-2 bg-light">
                                <%
                                    for (OrderDetail o: orderDetails) {
                                        Product p = productDAO.getProductById(o.getProductId());
                                %>
                                <div class="media mb-2 border-bottom">
                                    <div class="media-body"> <%=p.getTitle()%>
                                            <div class="small text-muted"><%=p.getPrice()%><span class="mx-2">|</span><%=o.getQuantity()%> <span class="mx-2">|</span><%=String.valueOf(Double.parseDouble(p.getPrice()) * o.getQuantity())%></div>
                                    </div>
                                </div>
                                <%
                                    }
                                %>
                            </div>
                            <%
                                double totalPrice = cartProduct.totalPriceAllProduct();
                                double percent = 5.0;
                                double tax = (totalPrice / 100) * percent;
                            %>
                            <div class="d-flex">
                                <div class="ml-auto font-weight-bold">Tổng tiền</div>
                            </div>
                            <hr class="my-1">
                            <div class="d-flex">
                                <h4>Tổng</h4>
                                <div class="ml-auto font-weight-bold"> <%= totalPrice + "đ"%> </div>
                            </div>
                            <div class="d-flex">
                                <h4>Thuế</h4>
                                <div class="ml-auto font-weight-bold"> <%= tax+"đ"%> </div>
                            </div>
                            <div class="d-flex gr-total">
                                <h5>Tổng tền thanh toán</h5>
                                <div class="ml-auto h5"> <%=totalPrice + tax  + "đ"%> </div>
                            </div>
                            <hr> </div>
                    </div>
                    <div class="col-12 d-flex shopping-box"> <a href="../buy_product?order_id=<%=order.getId()%>" class="ml-auto btn hvr-hover">Thanh toán</a> </div>
                </div>
            </div>
        </div>
        <%}%>
    </div>
</div>
<!-- End Cart -->

<!-- Start Instagram Feed  -->
<div class="instagram-box">
    <div class="main-instagram owl-carousel owl-theme">
        <div class="item">
            <div class="ins-inner-box">
                <img src="../images/instagram-img-01.jpg" alt="" />
                <div class="hov-in">
                    <a href="#"><i class="fab fa-instagram"></i></a>
                </div>
            </div>
        </div>
        <div class="item">
            <div class="ins-inner-box">
                <img src="../images/instagram-img-02.jpg" alt="" />
                <div class="hov-in">
                    <a href="#"><i class="fab fa-instagram"></i></a>
                </div>
            </div>
        </div>
        <div class="item">
            <div class="ins-inner-box">
                <img src="../images/instagram-img-03.jpg" alt="" />
                <div class="hov-in">
                    <a href="#"><i class="fab fa-instagram"></i></a>
                </div>
            </div>
        </div>
        <div class="item">
            <div class="ins-inner-box">
                <img src="../images/instagram-img-04.jpg" alt="" />
                <div class="hov-in">
                    <a href="#"><i class="fab fa-instagram"></i></a>
                </div>
            </div>
        </div>
        <div class="item">
            <div class="ins-inner-box">
                <img src="../images/instagram-img-05.jpg" alt="" />
                <div class="hov-in">
                    <a href="#"><i class="fab fa-instagram"></i></a>
                </div>
            </div>
        </div>
        <div class="item">
            <div class="ins-inner-box">
                <img src="../images/instagram-img-06.jpg" alt="" />
                <div class="hov-in">
                    <a href="#"><i class="fab fa-instagram"></i></a>
                </div>
            </div>
        </div>
        <div class="item">
            <div class="ins-inner-box">
                <img src="../images/instagram-img-07.jpg" alt="" />
                <div class="hov-in">
                    <a href="#"><i class="fab fa-instagram"></i></a>
                </div>
            </div>
        </div>
        <div class="item">
            <div class="ins-inner-box">
                <img src="../images/instagram-img-08.jpg" alt="" />
                <div class="hov-in">
                    <a href="#"><i class="fab fa-instagram"></i></a>
                </div>
            </div>
        </div>
        <div class="item">
            <div class="ins-inner-box">
                <img src="../images/instagram-img-09.jpg" alt="" />
                <div class="hov-in">
                    <a href="#"><i class="fab fa-instagram"></i></a>
                </div>
            </div>
        </div>
        <div class="item">
            <div class="ins-inner-box">
                <img src="../images/instagram-img-05.jpg" alt="" />
                <div class="hov-in">
                    <a href="#"><i class="fab fa-instagram"></i></a>
                </div>
            </div>
        </div>
    </div>
</div>
<!-- End Instagram Feed  -->


<!-- Start Footer  -->
<footer>
    <div id="container_footer"></div>
    <jsp:include page="../include/footer.jsp"/>
</footer>
<!-- End Footer  -->

<!-- Start copyright  -->
<div class="footer-copyright">
    <p class="footer-company">All Rights Reserved. &copy; 2018 <a href="#">ThewayShop</a> Design By :
        <a href="https://html.design/">html design</a></p>
</div>
<!-- End copyright  -->

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