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
  <h1 class="text-center">Cập nhật sản phẩm</h1>
  <c:if test = "${not empty successUpdate}">
    <p class="text-center text-success">${successUpdate}</p>
    <c:remove var="successUpdate" scope="session"/>
  </c:if>

  <c:if test = "${not empty failedUpdate}">
    <p class="text-center text-danger">${failedUpdate}</p>
    <c:remove var="failedUpdate" scope="session"/>
  </c:if>
  <!-- form -->
  <%
      if(product!=null) {
        switch (product.getCategoryId()) {
          case "rau": category = "Rau";
          break;
          case "cu": category = "Củ";
            break;
          case "qua": category = "Quả";
            break;
          case "hat": category = "Hạt";
            break;
          default: category = "Rau";
        }
  %>

  <form action="../edit_product" method="post" enctype="multipart/form-data">
    <input type="hidden" name="id" id="id" value="<%=product.getId()%>">
    <!-- title -->
    <div class="form-outline mb-4 w-50 m-auto">
      <label for="product_title" class="form-label">Tên sản phẩm</label>
      <input type="text" name="product_title" id="product_title" class="form-control"
             placeholder="Nhập sản phẩm" autocomplete="off" required="required"
      value="<%=product.getTitle()%>">
    </div>

    <div class="form-outline mb-4 w-50 m-auto">
      <label for="unit" class="form-label">Đơn vị</label>
      <select class="form-control" id="unit" name="unit" required="required">
        <option value="<%=product.getUnit()%>"><%=product.getUnit()%></option>
        <option value="kg">Kg</option>
        <option value="g">g</option>
      </select>

    </div>
    <!-- price -->
    <div class="form-outline mb-4 w-50 m-auto">
      <label for="product_price" class="form-label">Giá sản phẩm</label>
      <input type="number" name="product_price" id="product_price" class="form-control"
             placeholder="Nhập giá sản phẩm" autocomplete="off" required="required" value="<%=product.getPrice()%>">
    </div>
    <!-- keywords -->
    <div class="form-outline mb-4 w-50 m-auto">
      <label for="product_keyword" class="form-label">Từ khóa</label>
      <input type="text" name="product_keyword" id="product_keyword" class="form-control"
             placeholder="Nhập từ khóa" autocomplete="off" required="required" value="<%=product.getKeyword()%>">
    </div>

    <div class="form-outline mb-4 w-50 m-auto">
      <label for="quantity" class="form-label">Số lượng</label>
      <input type="number" name="quantity" id="quantity" class="form-control"
             placeholder="Nhập số lượng" autocomplete="off" required="required" value="<%=product.getQuantity()%>">
    </div>

    <div class="form-outline mb-4 w-50 m-auto">
      <label for="product_category" class="form-label">Loại</label>
      <select class="form-control" id="product_category" name="product_category" required="required">
        <option value="<%=product.getCategoryId()%>"><%=category%></option>
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
             required="required" value="=<%=product.getImage()%>">
      <img src="../DataWeb/<%=product.getImage()%>" class="img-fluid" alt="Image">
    </div>

    <div class="form-outline mb-4 w-50 m-auto">
      <label for="unit_price" class="form-label">Đơn Giá</label>
      <input type="number" name="unit_price" id="unit_price" class="form-control"
             required="required" value="<%=product.getUnitPrice()%>">
    </div>


    <!-- submit button -->
    <div class="form-outline mb-4 w-50 m-auto pt-2">
      <input type="submit" name="insert_product" class="btn btn-info mb-3 px-3" value="Chỉnh sửa">
    </div>
  </form>
  <%
    }
  %>
</div>
</body>
</html>