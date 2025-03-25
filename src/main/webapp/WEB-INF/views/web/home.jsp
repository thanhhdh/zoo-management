<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@include file="/common/taglib.jsp"%>
<c:url var="urlImg" value="/template/web/img/animal/"></c:url>
<c:url var="ticket" value="/dat-ve" />
<c:url var="question" value="/cau-hoi"/>
<c:url var="opening" value="/gio-mo-cua"/>

<html>
<head>
    <title>Home | Zoo</title>
</head>
<body>
<div id="scrollTarget">

    <div class="hero-section text-center">
        <h1 class="display-1">Chào mừng đến với Zoo</h1>
        <p class="lead">Cùng khám phá thế giới hoang dã!</p>
        <button id="scrollButton" class="button-main">Khám phá ngay</button>
    </div>

    <div class="container my-4">
        <div class="toolbar__wrapper">
            <div class="toolbar">
                <!-- Opening Hours -->
                <div class="toolbar__item">
                    <div class="toolbar__title">GIỜ MỞ CỬA</div>
                    <div class="toolbar__content">
                        <div class="toolbar__subheading" id="current-date">Hằng ngày</div>
                        <div class="toolbar__time">9:00 - 16:30</div>
                    </div>
                    <div class="toolbar__link-wrap">
                        <a href="${opening}" class="btn btn-warning">Tất cả giờ mở cửa</a>
                    </div>
                </div>
                <div class="divider"></div>

                <!-- FAQ -->
                <div class="toolbar__item">
                    <div class="toolbar__title">FAQ</div>
                    <div class="toolbar__content">
                        <div class="toolbar__tile-image">
                            <img style="" src="${pageContext.request.contextPath}/template/web/assets/img/icon/faq_12385034.png">
                        </div>
                    </div>
                    <div class="toolbar__link-wrap">
                        <a href="${question}" class="btn btn-warning">Câu hỏi thường gặp</a>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <section class="section__welcome">
        <div class="container my-4">
            <div class="desc__title text-center">
                <h1>chào mừng đến với ZOO</h1>
                <p>Không chỉ là vườn thú lâu đời nhất và được ghé thăm nhiều nhất cả nước, nơi đây còn là nơi có nhiều loài động vật đa dạng nhất trong số các vườn thú trên cả nước!</p>
            </div>
        </div>
    </section>

    <section class="section__about">
        <div class="container my-4">
            <div class="teaser__content-wrapper">
                <h4>Về sở thú</h4>
                <div class="teaser-text">
                    <p>Sở thú của chúng tôi là nơi hội tụ của hàng trăm loài động vật từ khắp nơi trên thế giới. Với sứ mệnh bảo tồn, giáo dục và giải trí, chúng tôi không chỉ mang đến cơ hội khám phá thế giới hoang dã mà còn giúp bạn hiểu hơn về vai trò quan trọng của việc bảo vệ thiên nhiên.</p>
                </div>
                <div class="teaser-button">
                    <button class="button-main">
                        <a class="">Về chúng tôi</a>
                    </button>
                </div>
            </div>
        </div>
    </section>

    <section class="section__ticket">
        <div class="container grid-card">
            <div class="card-grid__header">
                <h4>Vé</h4>
                <button class="button-main">
                    <a href="${ticket}">Xem tất cả giá</a>
                </button>
            </div>
            <div class="card-grid__cards">
                <!-- Card 1 -->
                <div class="card-grid__card">
                    <img src="${pageContext.request.contextPath}/template/web/assets/img/animal_banner/tonka.jpg" alt="Animal 1">
                    <button class="card-button"><a href="${ticket}">MUA VÉ</a></button>
                </div>
                <!-- Card 2 -->
                <div class="card-grid__card">
                    <img src="${pageContext.request.contextPath}/template/web/assets/img/animal_banner/ivan-cujic.jpg" alt="Animal 2">
                    <button class="card-button"><a href="${ticket}">TÌM HIỂU THÊM</a></button>
                </div>
            </div>
        </div>
    </section>

    <!-- Animal Section -->
    <section class="section__animals">
        <div id="scrollTarget" class="text-center">
            <div class="container">
                <h2 class="display-4 mb-4 animals__title">Đa dạng các loài động vật</h2>
                <p class="mb-5">7 lớp với hơn 1000 cá thể gồm hàng chục loài động vật quý hiếm...</p>
                <div id="animalsCarousel" class="carousel slide" data-bs-ride="carousel">
                    <div class="carousel-inner">
                        <c:if test="${not empty animals}">
                            <c:forEach var="animal" items="${animals}" varStatus="status">
                                <c:if test="${status.index % 4 == 0}">
                                    <div class="carousel-item ${status.first ? 'active' : ''}">
                                    <div class="row g-4">
                                </c:if>
                                <div class="col-md-3">
                                    <div class="card animal-card">
                                        <img src="${urlImg}${animal.animalImage}" class="card-img-top" alt="${animal.animalName}">
                                        <div class="card-body text-center">
                                            <h5 class="card-title">${animal.animalName}</h5>
                                            <p class="card-text">Loài: ${animal.species.speciesName}</p>
                                        </div>
                                    </div>
                                </div>
                                <c:if test="${(status.index + 1) % 4 == 0 || status.last}">
                                    </div>
                                    </div>
                                </c:if>
                            </c:forEach>
                        </c:if>
                        <c:if test="${empty animals}">
                            <div class="carousel-item active">
                                <p class="text-center">Không có động vật nào để hiển thị.</p>
                            </div>
                        </c:if>
                    </div>
                    <button class="carousel-control-prev" type="button" data-bs-target="#animalsCarousel" data-bs-slide="prev">
                        <span class="carousel-control-prev-icon" aria-hidden="true"></span>
                        <span class="visually-hidden">Previous</span>
                    </button>
                    <button class="carousel-control-next" type="button" data-bs-target="#animalsCarousel" data-bs-slide="next">
                        <span class="carousel-control-next-icon" aria-hidden="true"></span>
                        <span class="visually-hidden">Next</span>
                    </button>
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
                        <h2 class="custom-title">mua vé<br>trực tuyến</h2>
                        <p class="custom-subtitle">Tiết kiệm thời gian và tiền bạc</p>
                    </div>
                </div>
            </div>

            <!-- Card 2 -->
            <div class="col-md-4">
                <div class="card custom-card">
                    <img src="${pageContext.request.contextPath}/template/web/assets/img/animal_banner/otter.jpg" class="card-img" alt="Otter">
                    <div class="card-img-overlay text-white d-flex flex-column justify-content-center align-items-center">
                        <h2 class="custom-title">NHIỀU ĐIỀU ĐỂ<br>TRẢI NGHIỆM</h2>
                        <p class="custom-subtitle">Tổng quan về mô trường sống</p>
                    </div>
                </div>
            </div>

            <!-- Card 3 -->
            <div class="col-md-4">
                <div class="card custom-card">
                    <img src="${pageContext.request.contextPath}/template/web/assets/img/animal_banner/mongoose.jpg" class="card-img" alt="Mongoose">
                    <div class="card-img-overlay text-white d-flex flex-column justify-content-center align-items-center">
                        <h2 class="custom-title">Hãy cùng <br>đồng hành!</h2>
                        <p class="custom-subtitle">Trở thành nhà tài trợ động vật</p>
                    </div>
                </div>
            </div>
        </div>
    </section>


</div>


<script>
    window.addEventListener('scroll', function () {
        const navbar = document.getElementById('navbar');
        if (!navbar) return; // Dừng nếu không có phần tử 'navbar'

        const scrollTarget = document.getElementById('scrollTarget');
        const scrollTargetPosition = scrollTarget.offsetTop;

        if (window.scrollY >= scrollTargetPosition) {
            navbar.classList.add('fixed-top');
        } else {
            navbar.classList.remove('fixed-top');
        }
    });

</script>
<script>
    // JavaScript to scroll to target on button click
    document.getElementById('scrollButton').addEventListener('click', function () {
        const scrollTarget = document.getElementById('scrollTarget');
        if (!scrollTarget) return; // Dừng nếu không tìm thấy phần tử
        scrollTarget.scrollIntoView({ behavior: 'smooth' });
    });

</script>

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
