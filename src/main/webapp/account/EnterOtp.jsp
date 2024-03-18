<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>

  <link
          href="//maxcdn.bootstrapcdn.com/bootstrap/3.3.0/css/bootstrap.min.css"
          rel="stylesheet" id="bootstrap-css">
  <script
          src="//maxcdn.bootstrapcdn.com/bootstrap/3.3.0/js/bootstrap.min.js"></script>
  <script src="//code.jquery.com/jquery-1.11.1.min.js"></script>
  <!------ Include the above in your HEAD tag ---------->

  <link rel="stylesheet"
        href="https://maxcdn.bootstrapcdn.com/font-awesome/4.5.0/css/font-awesome.min.css">

  <style type="text/css">
    .form-gap {
      padding-top: 70px;
    }
  </style>
</head>

<body>
<div class="form-gap"></div>
<div class="container">
  <div class="row">
    <div class="col-md-4 col-md-offset-4">
      <div class="panel panel-default">
        <div class="panel-body">
          <div class="text-center">
            <h3>
              <i class="fa fa-lock fa-4x"></i>
            </h3>
            <h2 class="text-center">Nhập mã OTP</h2>


            <div class="panel-body">

              <form id="register-form" action="ValidateOtp" role="form" autocomplete="off"
                    class="form" method="post">

                <div class="form-group">
                  <div class="input-group">
											<span class="input-group-addon"><i
                                                    class="glyphicon glyphicon-envelope color-blue"></i></span> <input
                          id="opt" name="otp" placeholder="Nhập mã OTP"
                          class="form-control" type="number" required="required">
                  </div>
                </div>
                <c:if test="${not empty messagesended}">
                  <p class="text-center text-success">${messagesended}</p>
                  <c:remove var="success" scope="session"/>
                </c:if>
                <c:if test="${not empty message}">
                  <p class="text-center text-danger">${message}</p>
                  <c:remove var="failed" scope="session"/>
                </c:if>
                <div class="form-group">
                  <input name="recover-submit"
                         class="btn btn-lg btn-primary btn-block"
                         value="Khôi phục mật khẩu" type="submit">
                </div>

                <input type="hidden" class="hide" name="token" id="token"
                       value="">
              </form>

            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
</div>
</body>
</html>