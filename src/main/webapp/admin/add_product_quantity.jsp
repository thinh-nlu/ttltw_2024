<%@ page import="model.Product" %>
<%@ page import="dao.ProductDAO" %>
<%@ page import="database.DBConnect" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page isELIgnored = "false" %>
<%
    ProductDAO dao = new ProductDAO(DBConnect.getConnection());
    int id = 0;
    if (request.getParameter("id")!=null) {
        id = Integer.parseInt(request.getParameter("id"));
    }
    Product product = dao.getProductById(id);
    String category = "";
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>NongLamXanh</title>
    <link rel="stylesheet" href="../css/bootstrap.min.css">
</head>
<body>
<div class="container mt-3">
    <h1 class="text-center">Thêm sản phẩm</h1>

    <form action="../add_quantity_product" method="post">
        <input type="hidden" name="id" id="id" value="<%=product.getId()%>">
        <!-- title -->
        <div class="form-outline mb-4 w-50 m-auto">
            <h4>Tên sản phẩm</h4>
            <h6><%=product.getTitle()%></h6>
        </div>

        <div class="form-outline mb-4 w-50 m-auto">
            <label for="quantity" class="form-label">Số lượng</label>
            <input type="number" name="quantity" id="quantity" class="form-control"
                   placeholder="Nhập số lượng" autocomplete="off" required="required" value="">
        </div>

        <!-- image -->
        <div class="form-outline mb-4 w-50 m-auto">
            <img src="../DataWeb/<%=product.getImage()%>" class="img-fluid" alt="Image">
        </div>

        <!-- submit button -->
        <div class="form-outline mb-4 w-50 m-auto pt-2">
            <input type="submit" name="insert_product" class="btn btn-info mb-3 px-3" value="Chỉnh sửa">
        </div>
    </form>
</div>
</body>
</html>