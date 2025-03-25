<%--
  Created by IntelliJ IDEA.
  User: hdhth
  Date: 12/10/2024
  Time: 10:16 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@include file="/common/taglib.jsp"%>
<c:url var="urlImg" value="/template/web/img/animal/"></c:url>
<html>
<head>
  <title>Title</title>
</head>
<body>
<!-- Question Submission Section -->
<section class="container py-5">
  <h3 class="text-center mb-4">Câu Hỏi Thường Gặp</h3>
  <div class="accordion" id="faqAccordion">
    <div class="accordion-item">
      <h2 class="accordion-header" id="heading-0">
        <button class="accordion-button" type="button" data-bs-toggle="collapse"
                data-bs-target="#collapse-0" aria-expanded="true" aria-controls="collapse-0">
          Giờ mở cửa của sở thú là khi nào?
        </button>
      </h2>
      <div id="collapse-0" class="accordion-collapse collapse show"
           aria-labelledby="heading-0" data-bs-parent="#faqAccordion">
        <div class="accordion-body">
          <p>Sở thú mở cửa hàng ngày từ 8:00 sáng đến 6:00 tối.</p>
        </div>
      </div>
    </div>
    <div class="accordion-item">
      <h2 class="accordion-header" id="heading-1">
        <button class="accordion-button" type="button" data-bs-toggle="collapse"
                data-bs-target="#collapse-1" aria-expanded="false" aria-controls="collapse-1">
          Tôi có thể mang theo thức ăn vào sở thú không?
        </button>
      </h2>
      <div id="collapse-1" class="accordion-collapse collapse"
           aria-labelledby="heading-1" data-bs-parent="#faqAccordion">
        <div class="accordion-body">
          <p>Có, bạn có thể mang theo thức ăn, nhưng không được phép chia sẻ thức ăn với động vật.</p>
        </div>
      </div>
    </div>
    <div class="accordion-item">
      <h2 class="accordion-header" id="heading-2">
        <button class="accordion-button" type="button" data-bs-toggle="collapse"
                data-bs-target="#collapse-2" aria-expanded="false" aria-controls="collapse-2">
          Sở thú có cung cấp dịch vụ hướng dẫn tham quan không?
        </button>
      </h2>
      <div id="collapse-2" class="accordion-collapse collapse"
           aria-labelledby="heading-2" data-bs-parent="#faqAccordion">
        <div class="accordion-body">
          <p>Có, sở thú có cung cấp dịch vụ hướng dẫn tham quan. Vui lòng liên hệ nhân viên để biết thêm chi tiết.</p>
        </div>
      </div>
    </div>
    <div class="accordion-item">
      <h2 class="accordion-header" id="heading-3">
        <button class="accordion-button" type="button" data-bs-toggle="collapse"
                data-bs-target="#collapse-3" aria-expanded="false" aria-controls="collapse-3">
          Sở thú có chỗ đậu xe không?
        </button>
      </h2>
      <div id="collapse-3" class="accordion-collapse collapse"
           aria-labelledby="heading-3" data-bs-parent="#faqAccordion">
        <div class="accordion-body">
          <p>Có, sở thú cung cấp bãi đậu xe miễn phí cho khách tham quan.</p>
        </div>
      </div>
    </div>
  </div>
</section>


<section class="py-5" style="background-color: #f9f9f9;">
  <div class="container py-5">
    <h1 class="text-center mb-4">
      Bạn có bất kỳ câu hỏi nào?
    </h1>
    <p class="text-center ">
      Đừng ngần ngại liên hệ nhé!
    </p>
    <div class="row justify-content-center">
      <div class="col-md-8">
        <form action="${pageContext.request.contextPath}/cau-hoi" method="post">
          <div class="mb-3">
            <label for="name" class="form-label">Họ và tên</label>
            <input type="text" class="form-control" id="name" name="name" placeholder="Nhập họ và tên của bạn" required>
          </div>
          <div class="mb-3">
            <label for="email" class="form-label">Email của bạn</label>
            <input type="email" class="form-control" id="email" name="email" placeholder="Nhập email của bạn" required>
          </div>
          <div class="mb-3">
            <label for="content" class="form-label">Câu hỏi của bạn</label>
            <textarea class="form-control" id="content" name="content" rows="5" placeholder="Nhập câu hỏi của bạn ở đây..." required></textarea>
          </div>
          <div class="text-center">
            <button type="submit" class="btn button-main">Gửi câu hỏi</button>
          </div>
        </form>
      </div>
    </div>
  </div>
</section>

<script type="text/javascript">
  $(document).ready(function() {
    <c:if test="${not empty message}">
    var message = "${message.message}";
    var type = "${message.type}";
    message_toastr(type, message, "Thông Báo");
    </c:if>
  });
</script>

</body>
</html>
