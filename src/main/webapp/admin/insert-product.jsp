<%@ page import="model.User" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page isELIgnored = "false" %>
<%
    User user = (User) session.getAttribute("success");
    String addProduct = (String) session.getAttribute("addProduct");
    if(addProduct==null) addProduct = "";
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>NongLamXanh</title>
    <!-- Site Icons -->
    <link rel="shortcut icon" href="images/favicon.ico" type="image/x-icon">
    <link rel="apple-touch-icon" href="images/apple-touch-icon.png">

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
<!-- End Main Top -->/>
<!-- Start Main Top -->
<header class="main-header">
    <%
        if(addProduct.equals("Thêm sản phẩm thành công")) {
    %>
    <h2 class="text-center text-success"><%=addProduct%></h2>
    <%}else{%>
    <h2 class="text-center text-danger"><%=addProduct%></h2>
    <%
        }
        session.removeAttribute("addProduct");
    %>
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
                        <a href="#" class="photo"><img src="images/img-pro-01.jpg" class="cart-thumb" alt="" /></a>
                        <h6><a href="#">Delica omtantur </a></h6>
                        <p>1x - <span class="price">$80.00</span></p>
                    </li>
                    <li>
                        <a href="#" class="photo"><img src="images/img-pro-02.jpg" class="cart-thumb" alt="" /></a>
                        <h6><a href="#">Omnes ocurreret</a></h6>
                        <p>1x - <span class="price">$60.00</span></p>
                    </li>
                    <li>
                        <a href="#" class="photo"><img src="images/img-pro-03.jpg" class="cart-thumb" alt="" /></a>
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
</body>
</html>