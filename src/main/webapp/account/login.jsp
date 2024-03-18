<%@ page import="model.User" %>
<%@ page import="cart.CartProduct" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page isELIgnored = "false" %>
<%
	CartProduct cartProduct = (CartProduct) session.getAttribute("cart");
	if(cartProduct == null) cartProduct = new CartProduct();
	User user = (User) session.getAttribute("success");
	String failedMessage = (String) session.getAttribute("failed");
	Cookie[] cookies = request.getCookies();
	String username = "";
	String password = "";
	String remember = "";
%>

<!DOCTYPE html>
<html lang="en">
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
					<li class="nav-item active"><a class="nav-link" href="../index.jsp">Trang Chủ</a></li>
					<li class="nav-item"><a class="nav-link" href="../about.jsp">Giới Thiệu</a></li>
					<li class="dropdown">
						<a href="#" class="nav-link dropdown-toggle" data-toggle="dropdown">Tiện ích <i class="bi bi-list "></i></a>
						<ul class="dropdown-menu">
							<li><a href="../tien_ich/cart.jsp">Giỏ Hàng</a></li>
							<li><a href="../tien_ich/address.jsp">Địa chỉ</a></li>
							<li><a href="../tien_ich/checkout.jsp">Thanh Toán</a></li>
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
					<li class="side-menu">
						<a href="#">
							<i class="fa fa-shopping-bag"></i>
							<span class="badge"><%=cartProduct.getTotal()%></span>
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

<div class="main ">
	<!-- Sign up form -->
	<section class="signin">
		<div class="container">
			<div class="signin-content">
				<div class="row justify-content-center">
					<div class="signin-form">
						<h2 class="form-title mt-2">Đăng Nhập</h2>
						<%
							if(failedMessage!=null) {
						%>
						<h2 class="text-danger text-center"><%=failedMessage%></h2>
						<%}
							session.removeAttribute("failed");
						%>
						<form method="post" action="../login" class="mt-3" id="formLogin">
							<div class="form-col md-3">
								<%
									if(cookies!=null) {
										for (Cookie c : cookies) {
											if ("cookieUser".equals(c.getName())) {
												username = c.getValue();
											} else if ("cookiePass".equals(c.getName())) {
												password = c.getValue();
											} else if ("cookieRem".equals(c.getName())) {
												remember = c.getValue();
											}
										}
									}
								%>

								<div class="form-group">
									<label for="name" class="mb-0">Tên Đăng Nhập</label>
									<input type="text" class="form-control" id="name" name="name" value="<%=username%>" placeholder="" >
								</div>
								<div class="form-group">
									<label for = "password" class="mb-0">Mật Khẩu</label>
									<input type="password" class="form-control" id="password" name="password" value="<%=password%>" placeholder="" >
								</div>
								<div>
									<div class="form-check mb-3">
									<input class="form-check-input" type="checkbox"  id="remember" name="remember" value="ON"
									>
									<label class="form-check-label" for="remember">
										Lưu Mật Khẩu
									</label>
									<a href="forgotPassword.jsp" class="ml-5">Quên mật khẩu</a>

								</div>
								</div>
							</div>
							<div class="mb-2">
								<button type="submit" class="btn hvr-hover ">Đăng Nhập</button>

								<p>Bạn chưa có tài khoản? <a href="registration.jsp">Đăng Ký Ngay</a></p>
								<h4 class="">Hoặc đăng nhập bằng :
									<a href="https://www.facebook.com/dialog/oauth?client_id=390038746860422&redirect_uri=http://localhost:8080/cuoiki_war_exploded/login_facebook" class="btn btn-primary btn-sm"><i class=" bi-facebook bg-primary align-content-center"></i></a>
									<a href="https://accounts.google.com/o/oauth2/auth?scope=profile email&redirect_uri=http://localhost:8080/cuoiki_war_exploded/loginGoogle&response_type=code&client_id=257156793950-querl7dnqmaq9cjfa1ou89sslsa6cof0.apps.googleusercontent.com&approval_prompt=force" class="btn btn-danger btn-sm">
										<i class="bi-google bg-danger align-content-center"></i></a>

								</h4>

							</div>



						</form>
					</div>
				</div>
			</div>
		</div>
	</section>
</div>
<jsp:include page="../include/footer.jsp"/>
<!-- End Footer  -->
<!-- JS -->
<!-- All JS Files -->
<script src="../js/jquery-3.2.1.min.js"></script>
<script src="../js/popper.min.js"></script>
<script src="../js/bootstrap.min.js"></script>
<!-- All Plugins -->
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
