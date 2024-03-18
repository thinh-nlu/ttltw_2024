<%@page import="model.Product" %>
<%@page import="java.text.SimpleDateFormat" %>
<%@page import="model.Feedback" %>
<%@page import="database.DBConnect" %>
<%@page import="dao.FeedbackDAO" %>
<%@ page import="model.User" %>
<%@ page import="cart.CartProduct" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page isELIgnored="false" %>
<style>
    .profile-image {
        width: 50px;
        height: 50px;
        border-radius: 50%;
        object-fit: cover;
    }

</style>

<%
    CartProduct cartProduct = (CartProduct) session.getAttribute("cart");
    if (cartProduct == null) cartProduct = new CartProduct();
    User user = (User) session.getAttribute("success");

    FeedbackDAO feedbackDAO = new FeedbackDAO(DBConnect.getConnection());
    SimpleDateFormat format = new SimpleDateFormat("dd/MM/yyyy");
%>

<%
    Product p1 = (Product) session.getAttribute("productDetail");
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
    <link rel="shortcut icon" href="images/favicon.ico" type="image/x-icon">
    <link rel="apple-touch-icon" href="images/apple-touch-icon.png">

    <!-- Bootstrap CSS -->
    <link rel="stylesheet" href="css/bootstrap.min.css">
    <!-- Site CSS -->
    <link rel="stylesheet" href="css/style.css">
    <!-- Responsive CSS -->
    <link rel="stylesheet" href="css/responsive.css">
    <!-- Custom CSS -->
    <link rel="stylesheet" href="css/custom.css">
    <link rel="stylesheet" href="./asset/bootstrap-icons-1.11.1/bootstrap-icons.css">

    <!--[if lt IE 9]>
    <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
    <script src="https://oss.maxcdn.com/libs/respond.js/1.4.2/respond.min.js"></script>
    <![endif]-->

</head>

<body>
<div class="main-top">
    <div class="container-fluid">
        <div class="row">
            <div class="col-lg-6 col-md-6 col-sm-12 col-xs-12">
                <div class="our-link">
                    <ul>
                        <li><a href="tien_ich/my-account.jsp"><i class="fa fa-user s_color"></i> Tài khoản của tôi</a>
                        </li>
                        <li><a href="contact-us.jsp"><i class="fas fa-headset"></i> Liên hệ </a></li>
                    </ul>
                </div>
            </div>
            <div class="col-lg-6 col-md-6 col-sm-12 col-xs-12">
                <div class="login-register">
                    <ul>
                        <% if (user != null) { %>
                        <% if (!user.getIsAdmin().equals("0")) { %>
                        <li><a href="tien_ich/my-account.jsp">Xin chào <%=user.getName()%></a></li>
                        <li><a href="${pageContext.request.contextPath}/logout">Đăng Xuất</a></li>
                        <%} else {%>
                        <li><p>Xin chào <%= user.getName() %></p></li>
                        <li><a href="admin/admin.jsp">Trang Quản Lí</a></li>
                        <li><a href="${pageContext.request.contextPath}/logout">Đăng Xuất</a></li>
                        <%}%>
                        <% } else { %>
                        <li><a href="account/registration.jsp">Đăng Kí</a></li>
                        <li><a href="account/login.jsp">Đăng Nhập</a></li>
                        <% } %>
                    </ul>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- Start Main Top -->
<header class="main-header">
    <!-- Start Navigation -->
    <nav class="navbar navbar-expand-lg navbar-light bg-light navbar-default bootsnav">
        <div class="container">
            <!-- Start Header Navigation -->
            <div class="navbar-header">
                <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbar-menu"
                        aria-controls="navbars-rs-food" aria-expanded="false" aria-label="Toggle navigation">
                    <i class="fa fa-bars"></i>
                </button>
                <a class="navbar-brand " href="index.jsp"><img src="images/logo1.png" class="logo "
                                                               style="width: 200px;height: 108px" alt=""></a>
            </div>
            <!-- End Header Navigation -->

            <!-- Collect the nav links, forms, and other content for toggling -->
            <div class="collapse navbar-collapse" id="navbar-menu">
                <ul class="nav navbar-nav ml-auto" data-in="fadeInDown" data-out="fadeOutUp">
                    <li class="nav-item"><a class="nav-link" href="index.jsp">Trang chủ</a></li>
                    <li class="nav-item"><a class="nav-link" href="about.jsp">Giới thiệu</a></li>
                    <li class="dropdown">
                        <a href="#" class="nav-link dropdown-toggle" data-toggle="dropdown">Tiện ích <i
                                class="bi bi-list "></i></a>
                        <ul class="dropdown-menu">
                            <li><a href="tien_ich/cart.jsp">Giỏ Hàng</a></li>
                            <li><a href="tien_ich/address.jsp">Địa chỉ</a></li>
                            <li><a href="tien_ich/checkout.jsp">Thanh Toán</a></li>
                            <li><a href="tien_ich/my-account.jsp">Tài Khoản</a></li>
                            <li><a href="tien_ich/wishlist.jsp">Yêu thích</a></li>
                        </ul>
                    </li>
                    <li class="nav-item active"><a class="nav-link" href="gallery.jsp">Cửa Hàng</a></li>
                    <li class="nav-item"><a class="nav-link" href="contact-us.jsp">Liên Hệ</a></li>
                </ul>
                <li class="nav-item">
                    <form method="post" action="${pageContext.request.contextPath}/searchProduct">
                        <div class="input-group rounded">
                            <input type="search" class="form-control rounded" placeholder="Tìm kiếm sản phẩm"
                                   aria-label="Search" aria-describedby="search-addon" id="keyword" name="keyword">
                            <input type="submit" value="Tìm kiếm" class="btn btn-outline-success"
                                   name="search_data_product">
                        </div>
                    </form>

                </li>
            </div>
            <!-- /.navbar-collapse -->

            <!-- Start Atribute Navigation -->
            <div class="attr-nav">
                <ul>
                    <li class="side-menu"><a href="tien_ich/cart.jsp">
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
                        <a href="#" class="photo"><img src="images/img-pro-01.jpg" class="cart-thumb" alt=""/></a>
                        <h6><a href="#">Delica omtantur </a></h6>
                        <p>1x - <span class="price">$80.00</span></p>
                    </li>
                    <li>
                        <a href="#" class="photo"><img src="images/img-pro-02.jpg" class="cart-thumb" alt=""/></a>
                        <h6><a href="#">Omnes ocurreret</a></h6>
                        <p>1x - <span class="price">$60.00</span></p>
                    </li>
                    <li>
                        <a href="#" class="photo"><img src="images/img-pro-03.jpg" class="cart-thumb" alt=""/></a>
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

                <ul class="breadcrumb">
                    <li class="breadcrumb-item"><a href="#">Trang chủ</a></li>
                    <li class="breadcrumb-item active">Dịch vụ</li>
                </ul>
            </div>
        </div>
    </div>
</div>
<!-- End All Title Box -->

<!-- Start Shop Detail  -->
<div class="shop-detail-box-main">
    <div class="container">
        <div class="row">
            <div class="col-xl-5 col-lg-5 col-md-6">
                <div id="carousel-example-1" class="single-product-slider carousel slide" data-ride="carousel">
                    <div class="carousel-inner" role="listbox">
                        <div class="carousel-item active"><img class="d-block w-100"
                                                               src="${pageContext.request.contextPath }/DataWeb/<%=p1.getImage()%>"
                                                               alt="First slide"></div>
                        <div class="carousel-item"><img class="d-block w-100"
                                                        src="${pageContext.request.contextPath }/DataWeb/<%=p1.getImage()%>"
                                                        alt="Second slide"></div>
                        <div class="carousel-item"><img class="d-block w-100"
                                                        src="${pageContext.request.contextPath }/DataWeb/<%=p1.getImage()%>"
                                                        alt="Third slide"></div>
                    </div>
                </div>
            </div>
            <div class="col-xl-7 col-lg-7 col-md-6">
                <div class="single-product-details">
                    <h2><%=p1.getTitle()%>
                    </h2>
                    <h5><%=p1.getPrice() + "/" + p1.getUnitPrice() + p1.getUnit()%> VND</h5>
                    <p class="available-stock"><span> Có sẵn <%=p1.getQuantity()%></span>
                    <p>
                    <h4>Miêu tả sản phẩm:</h4>
                    <p><%=p1.getDescription()%>
                    </p>
                    <div class="price-box-bar">
                        <div class="cart-and-bay-btn">
                            <a class="btn hvr-hover"
                               href="${pageContext.request.contextPath}/add_cart?id=<%= p1.getId() %>"><i
                                    class="fas fa-heart"></i> Mua ngay</a>
                        </div>
                    </div>

                    <div class="add-to-btn">
                        <div class="add-comp">
                            <a class="btn hvr-hover"
                               href="${pageContext.request.contextPath}/add_wishlist?productId=<%= p1.getId() %>"><i
                                    class="fas fa-heart"></i> Thêm vào danh sách yêu thích</a>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <div class="row my-lg-3">

            <div class="card-header">
                <h2>Đánh giá sản phẩm</h2>
            </div>
            <div class="card-body">
                <% if (!feedbackDAO.getTop3Feedback(p1.getId()).isEmpty()) { %>
                <% for (Feedback feedback : feedbackDAO.getTop3Feedback(p1.getId())) { %>
                <div class="media mb-3">
                    <div class="mr-2">
                        <img src="images/profile.jpg" class="profile-image">
                        <h4 class="text-center"><%= feedback.getName() %>
                        </h4>
                    </div>

                    <div class="media-body">
                        <p><%= feedback.getMessage() %>
                        </p>
                        <small class="text-muted">Được đăng vào <%= format.format(feedback.getCreated()) %>
                        </small>
                    </div>
                </div>
                <hr>
                <% } %>
                <% } else { %>
                <p>Chưa có đánh giá nào cho sản phẩm này.</p>
                <% } %>
            </div>

        </div>
        <%
            String success = (String) session.getAttribute("msgFeedback");
            session.removeAttribute("msgFeedback");
        %>

        <%if (success != null) {%>
        <script>
            alert('<%= success %>');
        </script>
        <% } %>
        <h2>Đánh giá sản phẩm</h2>
        <form id="form" method="post" action="${pageContext.request.contextPath }/userComment?id=<%=p1.getId()%>">
            <div class="row">
                <div class="col-md-12">
                    <div class="form-group">
                        <input type="text" class="form-control" id="name" name="name" placeholder="Họ và Tên" required
                               data-error="Nhập họ tên của bạn">

                    </div>
                </div>
                <div class="col-md-12">
                    <div class="form-group">
                        <input type="email" placeholder="Email" id="email" class="form-control" name="email" required
                               data-error="Vui lòng nhập email">

                    </div>
                </div>
                <div class="col-md-12">
                    <div class="form-group">
                        <textarea class="form-control" id="message" name="message" placeholder="Phản hồi của bạn"
                                  rows="4" data-error="Điền phản hồi của bạn" required></textarea>

                    </div>
                    <div class="submit-button text-center">
                        <button class="btn hvr-hover" id="submit" type="submit">Gửi</button>
                        <div id="msgSubmit" class="h3 text-center hidden"></div>
                        <div class="clearfix"></div>
                    </div>
                </div>
            </div>
        </form>

    </div>
</div>
<!-- End Cart -->

<!-- Start Instagram Feed  -->
<div class="instagram-box">
    <div class="main-instagram owl-carousel owl-theme">
        <div class="item">
            <div class="ins-inner-box">
                <img src="images/instagram-img-01.jpg" alt=""/>
                <div class="hov-in">
                    <a href="#"><i class="fab fa-instagram"></i></a>
                </div>
            </div>
        </div>
        <div class="item">
            <div class="ins-inner-box">
                <img src="images/instagram-img-02.jpg" alt=""/>
                <div class="hov-in">
                    <a href="#"><i class="fab fa-instagram"></i></a>
                </div>
            </div>
        </div>
        <div class="item">
            <div class="ins-inner-box">
                <img src="images/instagram-img-03.jpg" alt=""/>
                <div class="hov-in">
                    <a href="#"><i class="fab fa-instagram"></i></a>
                </div>
            </div>
        </div>
        <div class="item">
            <div class="ins-inner-box">
                <img src="images/instagram-img-04.jpg" alt=""/>
                <div class="hov-in">
                    <a href="#"><i class="fab fa-instagram"></i></a>
                </div>
            </div>
        </div>
        <div class="item">
            <div class="ins-inner-box">
                <img src="images/instagram-img-05.jpg" alt=""/>
                <div class="hov-in">
                    <a href="#"><i class="fab fa-instagram"></i></a>
                </div>
            </div>
        </div>
        <div class="item">
            <div class="ins-inner-box">
                <img src="images/instagram-img-06.jpg" alt=""/>
                <div class="hov-in">
                    <a href="#"><i class="fab fa-instagram"></i></a>
                </div>
            </div>
        </div>
        <div class="item">
            <div class="ins-inner-box">
                <img src="images/instagram-img-07.jpg" alt=""/>
                <div class="hov-in">
                    <a href="#"><i class="fab fa-instagram"></i></a>
                </div>
            </div>
        </div>
        <div class="item">
            <div class="ins-inner-box">
                <img src="images/instagram-img-08.jpg" alt=""/>
                <div class="hov-in">
                    <a href="#"><i class="fab fa-instagram"></i></a>
                </div>
            </div>
        </div>
        <div class="item">
            <div class="ins-inner-box">
                <img src="images/instagram-img-09.jpg" alt=""/>
                <div class="hov-in">
                    <a href="#"><i class="fab fa-instagram"></i></a>
                </div>
            </div>
        </div>
        <div class="item">
            <div class="ins-inner-box">
                <img src="images/instagram-img-05.jpg" alt=""/>
                <div class="hov-in">
                    <a href="#"><i class="fab fa-instagram"></i></a>
                </div>
            </div>
        </div>
    </div>
</div>
<!-- End Instagram Feed  -->


<!-- Start Footer  -->
<div class="footer-main">
    <div class="container">
        <div class="row">
            <div class="col-lg-4 col-md-12 col-sm-12">
                <div class="footer-top-box">
                    <h3>Thời gian kinh doan</h3>
                    <ul class="list-time">
                        <li>Thứ hai- Thứ sáu: 08.00 đến 17.00</li>
                        <li>Thứ bảy: 10.00 đến 20.00</li>
                        <li>Chủ nhật: <span>Đóng cửa</span></li>
                    </ul>
                </div>
            </div>
            <div class="col-lg-4 col-md-12 col-sm-12">
                <div class="footer-top-box">
                    <h3>Bản tin</h3>
                    <form class="newsletter-box">
                        <div class="form-group">
                            <input class="" type="email" name="Email" placeholder="Địa chỉ E-mail*"/>
                            <i class="fa fa-envelope"></i>
                        </div>
                        <button class="btn hvr-hover" type="submit">Gửi</button>
                    </form>
                </div>
            </div>
            <div class="col-lg-4 col-md-12 col-sm-12">
                <div class="footer-top-box">
                    <h3>Các trang truyền thông</h3>
                    <ul>
                        <li><a href="#"><i class="fab fa-facebook" aria-hidden="true"></i></a></li>
                        <li><a href="#"><i class="fab fa-twitter" aria-hidden="true"></i></a></li>
                        <li><a href="#"><i class="fab fa-linkedin" aria-hidden="true"></i></a></li>
                        <li><a href="#"><i class="fab fa-google-plus" aria-hidden="true"></i></a></li>
                        <li><a href="#"><i class="fa fa-rss" aria-hidden="true"></i></a></li>
                        <li><a href="#"><i class="fab fa-pinterest-p" aria-hidden="true"></i></a></li>
                        <li><a href="#"><i class="fab fa-whatsapp" aria-hidden="true"></i></a></li>
                    </ul>
                </div>
            </div>
        </div>
        <hr>
        <div class="row">
            <div class="col-lg-4 col-md-12 col-sm-12">
                <div class="footer-widget">
                    <h4>Freshshop</h4>
                    <p>Ở đây chất lượng được đặt lên hàng đầu </p>
                    <p>Sức khỏe khách hàng là ưu tiên của chúng tôi </p>
                </div>
            </div>
            <div class="col-lg-4 col-md-12 col-sm-12">
                <div class="footer-link">
                    <h4>Thông tin</h4>
                    <ul>
                        <li><a href="#">Liên hệ chúng tôi</a></li>
                        <li><a href="#">Dịch vụ chăm sóc khách hàng </a></li>
                        <li><a href="#">Our Sitemap</a></li>
                        <li><a href="#">Điều khoản và điều kiện</a></li>
                        <li><a href="#">Chính sách bảo mật</a></li>
                        <li><a href="#">Thông tin giao hàng</a></li>
                    </ul>
                </div>
            </div>
            <div class="col-lg-4 col-md-12 col-sm-12">
                <div class="footer-link-contact">
                    <h4>Liên hệ với chúng tôi</h4>
                    <ul>
                        <li>
                            <p><i class="fas fa-map-marker-alt"></i>Địa chỉ: 47 đường số 17 <br>Phường Linh Trung<br>
                                Thành phố Thủ Đức</p>
                        </li>
                        <li>
                            <p><i class="fas fa-phone-square"></i>Liện hệ: <a href="tel:+1-888705770"></a></p>
                        </li>
                        <li>
                            <p><i class="fas fa-envelope"></i>Email: <a href="mailto:contactinfo@gmail.com"></a></p>
                        </li>
                    </ul>
                </div>
            </div>
        </div>
    </div>
</div>
<!-- End Footer  -->


<a href="#" id="back-to-top" title="Back to top" style="display: none;">&uarr;</a>

<!-- ALL JS FILES -->
<script src="js/jquery-3.2.1.min.js"></script>
<script src="js/popper.min.js"></script>
<script src="js/bootstrap.min.js"></script>
<!-- ALL PLUGINS -->
<script src="js/jquery.superslides.min.js"></script>
<script src="js/bootstrap-select.js"></script>
<script src="js/inewsticker.js"></script>
<script src="js/bootsnav.js."></script>
<script src="js/images-loded.min.js"></script>
<script src="js/isotope.min.js"></script>
<script src="js/owl.carousel.min.js"></script>
<script src="js/baguetteBox.min.js"></script>
<script src="js/form-validator.min.js"></script>
<script src="js/contact-form-script.js"></script>
<script src="js/custom.js"></script>
</body>

</html>