<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<!doctype html>

<html>
<head>
    <meta charset='utf-8'>
    <meta name='viewport' content='width=device-width, initial-scale=1'>
    <title>NongLamXanh</title>
    <link
            href='https://stackpath.bootstrapcdn.com/bootstrap/4.1.1/css/bootstrap.min.css'
            rel='stylesheet'>
    <link href='' rel='stylesheet'>
    <script type='text/javascript'
            src='https://cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js'></script>
    <style>
        body {
            background-position: center;
            background-color: #eee;
            background-repeat: no-repeat;
            background-size: cover;
            color: #505050;
            font-family: "Rubik", Helvetica, Arial, sans-serif;
            font-size: 14px;
            font-weight: normal;
            line-height: 1.5;
            text-transform: none
        }
        .forgot {
            background-color: #fff;
            padding: 12px;
            border: 1px solid #dfdfdf
        }
        .padding-bottom-3x {
            padding-bottom: 72px !important
        }
        .card-footer {
            background-color: #fff
        }
        .btn {
            font-size: 13px
        }
        .form-control:focus {
            color: #495057;
            background-color: #fff;
            border-color: #76b7e9;
            outline: 0;
            box-shadow: 0 0 0 0px #28a745
        }
    </style>
</head>
<body oncontextmenu='return false' class='snippet-body'>
<div class="container padding-bottom-3x mb-2 mt-5">
    <div class="row justify-content-center">
        <div class="col-lg-8 col-md-10">
            <div class="forgot">
                <h2>Bạn Quên Mật Khẩu?</h2>
                <p>Phục hồi mật khẩu của bạn với 3 bước đơn giản. Điều này sẽ giúp bảo mật mật khẩu của bạn.</p>
                <ol class="list-unstyled">
                    <li><span class="text-primary text-medium">1. </span>Nhập Email của bạn ở phía dưới.</li>
                    <li><span class="text-primary text-medium">2. </span>Chúng tôi sẽ gửi một mã OTP đến Email của bạn.</li>
                    <li><span class="text-primary text-medium">3. </span>Nhập mã OTP vào trang tiếp theo.</li>
                </ol>
            </div>
            <form class="card mt-4" action="/cuoiki_war_exploded/forgotPassword" method="POST">

                <div class="card-body">
                    <div class="form-group">
                        <label for="email-for-pass">Nhập Email của bạn.</label> <input
                            class="form-control" type="text" name="email" id="email-for-pass" required=""><small
                            class="form-text text-muted">Nhập địa chỉ email đã đăng ký. Sau đó chúng tôi sẽ
                        gửi 1 mã OTP đến địa chỉ này.</small>
                    </div>
                </div>
                <c:if test="${not empty emailfail}">
                    <p class="text-center text-danger">${emailfail}</p>
                    <c:remove var="failed" scope="session"/>
                </c:if>
                <div class="card-footer">
                    <button class="btn btn-success" type="submit">Đổi mật khẩu mới</button>
                    <div class="row justify-content-center">

                        <a href="${pageContext.request.contextPath}/index.jsp"
                           class="text-bg-secondary">Trở về trang đăng nhập</a>

                    </div>
                </div>
            </form>
        </div>
    </div>
</div>
<script type='text/javascript'
        src='https://stackpath.bootstrapcdn.com/bootstrap/4.1.1/js/bootstrap.bundle.min.js'></script>
<script type='text/javascript' src=''></script>
<script type='text/javascript' src=''></script>
<script type='text/Javascript'></script>
</body>
</html>
