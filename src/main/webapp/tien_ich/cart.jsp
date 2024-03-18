<%@ page import="model.User" %>
<%@ page import="cart.CartProduct" %>
<%@ page import="cart.Cart" %>
<%@ page import="java.util.Map" %>
<%@ page import="model.Product" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page isELIgnored = "false" %>
<%
    User user = (User) session.getAttribute("success");
    CartProduct cartProduct = (CartProduct) session.getAttribute("cart");
    if(cartProduct == null) cartProduct = new CartProduct();
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
    <style>
        .profile-image {
            width: 70px;
            height: 70px;
            border-radius: 50%;
            object-fit: cover;
        }
    </style>
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
                    <a class="navbar-brand" href="../index.jsp"><img src="../images/logo.png" class="logo" alt=""></a>
                </div>
                <!-- End Header Navigation -->

                <!-- Collect the nav links, forms, and other content for toggling -->
                <div class="collapse navbar-collapse" id="navbar-menu">
                    <ul class="nav navbar-nav ml-auto" data-in="fadeInDown" data-out="fadeOutUp">
                        <li class="nav-item"><a class="nav-link" href="../index.jsp">Trang chủ</a></li>
                        <li class="nav-item"><a class="nav-link" href="../about.jsp">Giới thiệu</a></li>
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
                        <li class="side-menu"><a href="../tien_ich/cart.jsp">
						<i class="fa fa-shopping-bag"></i>
                            <span class="badge"><%= cartProduct.getTotal()%></span>
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
                    <h2>Giỏ Hàng</h2>
                    <ul class="breadcrumb">
                        <li class="breadcrumb-item"><a href="#">Trang chủ</a></li>
                        <li class="breadcrumb-item active">Giỏ Hàng</li>
                    </ul>
                </div>
            </div>
        </div>
    </div>
    <!-- End All Title Box -->
    <!-- Start Cart  -->
    <div class="cart-box-main">
        <div class="container">
            <%
                if(cartProduct.getData().isEmpty()) {
            %>
            <h2 class="text-center text-danger">Chưa có sản phẩm nào trong giỏ hàng</h2>
            <%}else{%>
            <div class="row">
                <div class="col-lg-12">
                    <div class="table-main table-responsive">
                        <table class="table">
                            <thead>
                            <tr>
                                <th>Hình ảnh</th>
                                <th>Tên sản phẩm</th>
                                <th>Giá</th>
                                <th>Số lượng</th>
                                <th>Tổng giá</th>
                                <th>Cập nhật</th>
                                <th>Loại bỏ</th>
                            </tr>
                            </thead>
                            <tbody>
                            <%
                                for (Map.Entry<Integer, Cart> entry: cartProduct.getData().entrySet()) {
                                    Product product = entry.getValue().getProduct();
                                    int quantity = entry.getValue().getQuantity();
                                    double totalPrice = Double.parseDouble(product.getPrice()) * Double.valueOf(quantity);
                            %>
                            <tr>
                                <form method="post" action="../update_quantity">
                                <input type="hidden" name="id" value="<%=product.getId()%>"/>
                                <td class="thumbnail-img">
                                    <img class="profile-image" src="../DataWeb/<%=product.getImage()%>" alt="Image" />
                                </td>
                                <td class="name-pr">
                                    <%=product.getTitle()%>
                                </td>
                                <td class="price-pr">
                                    <p><%=product.getPrice()%></p>
                                </td>
                                <td class="quantity-box"><input type="number" id="quantity" name="quantity" size="4" value="<%=entry.getValue().getQuantity()%>" min="0" step="1" class="c-input-text qty text"></td>
                                <td class="total-pr">
                                    <p><%=totalPrice%></p>
                                </td>
                                <td class="remove-pr">
                                    <button type="submit" class="border-0">
                                        <i class="bi bi-file-arrow-up-fill"></i>
                                    </button>
                                </td>
                                <td class="remove-pr">
                                    <a href="../deleteCartProduct?id=<%=product.getId()%>">
                                        <i class="bi bi-file-arrow-up-fill"></i>
                                    </a>
                                </td>
                                </form>
                            </tr>
                            <%}%>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
            <div class="row my-5">
                <div class="col-lg-8 col-sm-12"></div>
                <div class="col-lg-4 col-sm-12">
                    <div class="order-box">
                        <%
                            double totalPrice = cartProduct.totalPriceAllProduct();
                            double percent = 5.0;
                            double tax = (totalPrice / 100) * percent;
                        %>
                        <div class="d-flex">
                            <h4>Tổng giá tiền</h4>
                            <div class="ml-auto font-weight-bold"> <%=totalPrice + "đ"%> </div>
                        </div>
                        <hr class="my-1">
                        <div class="d-flex">
                            <h4>Thuế</h4>
                            <div class="ml-auto font-weight-bold"> <%= tax+"đ"%> </div>
                        </div>
                        <div class="d-flex">
                            <h4>Phí giao hàng</h4>
                            <div class="ml-auto font-weight-bold"> Miễn Phí </div>
                        </div>
                        <hr>
                        <div class="d-flex gr-total">
                            <h5>Thành tiền</h5>
                            <div class="ml-auto h5"> <%=totalPrice + tax  + "đ"%> </div>
                        </div>
                        <hr> </div>
                </div>
                <%
                    if(user != null) {
                %>
                <div class="col-12 d-flex shopping-box"><a href="address.jsp" class="ml-auto btn hvr-hover">Thanh Toán</a> </div>
                <%
                    } else {
                %>
                <div class="col-12 d-flex shopping-box"><a href="../account/login.jsp" onclick="showAlert()" class="ml-auto btn hvr-hover">Thanh Toán</a> </div>
                <script>
                    function showAlert() {
                        alert("Bạn cần đăng nhập trước khi thanh toán!");
                    }
                </script>
                <%}
                }
                %>
            </div>
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