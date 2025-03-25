<%--
  Created by IntelliJ IDEA.
  User: hdhth
  Date: 12/10/2024
  Time: 11:40 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
</head>
<body>
<section class="opening-hours py-5">
    <div class="container text-center">
        <h1 class="mb-4">Giờ Mở Cửa</h1>
        <p class="lead">Chào mừng bạn đến với sở thú! Hãy kiểm tra giờ hoạt động của chúng tôi trước khi đến tham quan.</p>
    </div>
</section>

<section class="py-5">
    <div class="container">
        <div class="row justify-content-center">
            <div class="col-md-8">
                <div class="card">
                    <div class="card-header text-center">
                        <h2>Thời Gian Hoạt Động</h2>
                    </div>
                    <div class="card-body">
                        <table class="table table-bordered text-center">
                            <thead class="table-light">
                            <tr>
                                <th>Ngày</th>
                                <th>Giờ Mở Cửa</th>
                                <th>Giờ Đóng Cửa</th>
                            </tr>
                            </thead>
                            <tbody>
                            <tr>
                                <td>Thứ Hai - Thứ Sáu</td>
                                <td>8:00 sáng</td>
                                <td>6:00 tối</td>
                            </tr>
                            <tr>
                                <td>Thứ Bảy - Chủ Nhật</td>
                                <td>7:30 sáng</td>
                                <td>6:30 tối</td>
                            </tr>
                            <tr>
                                <td>Các Ngày Lễ</td>
                                <td>7:00 sáng</td>
                                <td>7:00 tối</td>
                            </tr>
                            </tbody>
                        </table>
                    </div>
                </div>
                <div class="text-center mt-4">
                    <p><strong>Lưu ý:</strong> Giờ mở cửa có thể thay đổi trong trường hợp thời tiết xấu hoặc bảo trì. Vui lòng kiểm tra trước khi đến.</p>
                    <a href="contact.html" class="btn button-main">Liên hệ với chúng tôi</a>
                </div>
            </div>
        </div>
    </div>
</section>

<!-- Experience Section -->
<section class="container py-5">
    <div class="row g-4">
        <!-- Card 1 -->
        <div class="col-md-4">
            <div class="card custom-card">
                <img src="${pageContext.request.contextPath}/template/web/assets/img/animal_banner/panda.jpg" class="card-img" alt="Panda">
                <div class="card-img-overlay text-white d-flex flex-column justify-content-center align-items-center">
                    <h2 class="custom-title">ONLINE<br>TICKETS</h2>
                    <p class="custom-subtitle">Save time and money</p>
                </div>
            </div>
        </div>

        <!-- Card 2 -->
        <div class="col-md-4">
            <div class="card custom-card">
                <img src="${pageContext.request.contextPath}/template/web/assets/img/animal_banner/otter.jpg" class="card-img" alt="Otter">
                <div class="card-img-overlay text-white d-flex flex-column justify-content-center align-items-center">
                    <h2 class="custom-title">LOTS TO<br>EXPERIENCE</h2>
                    <p class="custom-subtitle">An overview of the inhabitants</p>
                </div>
            </div>
        </div>

        <!-- Card 3 -->
        <div class="col-md-4">
            <div class="card custom-card">
                <img src="${pageContext.request.contextPath}/template/web/assets/img/animal_banner/mongoose.jpg" class="card-img" alt="Mongoose">
                <div class="card-img-overlay text-white d-flex flex-column justify-content-center align-items-center">
                    <h2 class="custom-title">BE<br>MINE!</h2>
                    <p class="custom-subtitle">Become an animal sponsor</p>
                </div>
            </div>
        </div>
    </div>
</section>

</body>
</html>
