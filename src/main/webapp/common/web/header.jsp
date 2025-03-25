<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/common/taglib.jsp"%>

<c:url var="ticket" value="/dat-ve" />
<c:url var="home" value="/trang-chu" />
<c:url var="animal" value="/dong-vat" />
<c:url var="cart" value="/gio-hang" />
<c:url var="about" value="/ve-chung-toi" />
<c:url var="question" value="/cau-hoi" />
<c:url var="login" value="/dang-nhap" />
<c:url var="logout" value="/dang-xuat" />
<c:url var="openning" value="/gio-mo-cua" />
<c:url var="rule" value="/quy-dinh" />

<style>

:root {
	--color-primary: #3c5724;
	--color-button: #f07300;

}

nav a {
	color: inherit; /* Giữ nguyên màu chữ */
	text-decoration: none; /* Xóa gạch dưới */
	transition: color 0.3s ease;
}

nav a:hover {
	color: #2e8b57; /* Màu khi hover */
}

nav li {
	display: inline-block;
}

/* Điều chỉnh cho icon giỏ hàng */
.shopping-bag {
	width: 26px;
	cursor: pointer;
}

.button-main {
	background-color: #3c5724;
	color: #fff;
	border: none;
	border-radius: 5px;
	padding: 10px 20px;
	font-size: 0.9rem;
	transition: background-color 0.3s ease;
}

.button-main a {
	text-decoration: none;
	color: #fff;
}

.button-main:hover {
	background-color: #436128;
}

/*Toolbar*/
.toolbar__wrapper {
}
.toolbar {
	position: relative;
	top: -120px;
	display: flex;
	flex-wrap: wrap;
	gap: 20px;
	background-color: #f8f9fa;
	padding: 20px;
	border-radius: 10px;
	border: 1px solid #e9ecef;
}
.toolbar__item {
	flex: 1;
	min-width: 250px;
	display: flex;
	flex-direction: column;
	justify-content: space-between;
}
.toolbar__item:first-child {
	margin-left: 10px;
}
.toolbar__item:last-child{
	margin-right: 10px;
}

.toolbar__title {
	font-size: 1rem;
	font-weight: bold;
	margin-bottom: 10px;
	text-transform: uppercase;
	color: var(--color-primary);

}
.toolbar__content {
	margin-bottom: 15px;
}
.toolbar__subheading {
	font-size: 1rem;
	font-weight: 500;
	margin-bottom: 5px;
}
.toolbar__time {
	font-size: 0.9rem;
	color: #495057;
	margin-bottom: 5px;
}
.toolbar__text {
	font-size: 0.85rem;
	color: #6c757d;
}
.toolbar__link-wrap {
	margin-top: auto;
}
.divider {
	width: 1px;
	background-color: #dee2e6;
	margin: 0 10px;
}
.toolbar__tile-image {
	border-radius: 5px;
	display: flex;
	justify-content: center;
	align-items: center;
	color: #6c757d;
}
.btn-warning {
	text-decoration: none;
	text-align: center;
	color: #fff;
	background-color: #f07300;
	width: 100%;
	border: none;

}
.btn-warning:hover {
	text-decoration: none;
	color: #fff;
	background-color: #f08000;
	width: 100%;
}

.desc__title {
	padding: 0 100px;
}

.desc__title h1 {
	font-size: 3.5rem;
	color: var(--color-primary);
}
.desc__title p {
	line-height: 1.75rem;
	letter-spacing: -.0125rem;
}

.animals__title{
	color: var(--color-primary);
}
.grid-card {
	padding: 100px 0;
}
.card-grid__cards {
	display: grid;
	grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
	gap: 20px;
}
.card-grid__card {
	position: relative;
	overflow: hidden;
	border-radius: 10px;
	box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
}
.card-grid__card img {
	width: 100%;
	height: 400px;
	display: block;
	border-radius: 10px;
}
.card-button {
	position: absolute;
	bottom: 20px;
	left: 50%;
	transform: translateX(-50%);
	background-color: #f07300;
	color: #fff;
	border: none;
	border-radius: 5px;
	padding: 10px 20px;
	text-transform: uppercase;
	font-size: 0.9rem;
	transition: background-color 0.3s ease;
}
.card-button a {
	text-decoration: none;
	color: #ffffff;
}

.card-button:hover {
	background-color: #f08000;
}

.section__welcome {
	margin-bottom: 130px;
}

.section__ticket {
	background-color: #80a55d;
}
.card-grid__header {
	display: flex;
	margin-bottom: 20px;
	align-items: center;
	justify-content: space-between;
}
.section__about {
	min-height: 500px;
	background: url("${pageContext.request.contextPath}/template/web/assets/img/animal_banner/ho.jpg");
	background-repeat: no-repeat;
	background-position: center;
}
.teaser__content-wrapper {
	background-image: unset !important;
	background-color: rgba(245, 240, 215, .75) !important;
	padding: 50px 33px;
	margin-top: 100px;
	max-width: 443px;
	border-radius: 8px;
	float: inline-end;
}

.teaser-button .button-main{
	background-color: var(--color-button);
}
.card-grid__header h4 {
	color: #ffffff;
}

.teaser__content-wrapper h4 {
	color: var(--color-primary);
}

.section__animals {
	margin: 100px 0 100px 0;
}

/*Carousel slider*/


.carousel .row {
	margin: 0 auto;
}

.carousel-control-prev,
.carousel-control-next {
	width: 50px;
	height: 50px;
	background-color: rgba(0, 0, 0, 0.5);
	border-radius: 50%;
	display: flex;
	justify-content: center;
	align-items: center;
	border: 2px solid #fff;
	position: absolute;
	top: 50%;
	transform: translateY(-50%);
	transition: background-color 0.3s ease, transform 0.3s ease;
	z-index: 1;
}

.carousel-control-prev:hover,
.carousel-control-next:hover {
	background-color: #fff;
	transform: scale(1.1);
}

.carousel-control-prev-icon,
.carousel-control-next-icon {
	filter: invert(1);
}

.carousel-control-prev {
	left: -60px; /* Adjust distance from the carousel */
}

.carousel-control-next {
	right: -60px; /* Adjust distance from the carousel */
}

/*end carousel slider*/

.custom-card {
	position: relative;
	overflow: hidden;
	border-radius: 15px;
}

.custom-card img {
	width: 410px;
	height: 280px;
	object-fit: cover;
	transition: transform 0.3s ease;
}

.custom-card:hover img {
	transform: scale(1.1); /* Hiệu ứng zoom */
}

.card-img-overlay {
	background: rgba(0, 0, 0, 0.4); /* Nền mờ */
	text-align: center;
	transition: background 0.3s ease;
}

.custom-card:hover .card-img-overlay {
	background: rgba(0, 0, 0, 0.6); /* Nền mờ đậm hơn khi hover */
}

.custom-title {
	font-family: "Comic Sans MS", cursive, sans-serif; /* Font phong cách chữ viết tay */
	font-size: 2rem;
	text-transform: uppercase;
}

.custom-subtitle {
	font-size: 1rem;
	font-weight: 300;
}





/*footer*/
footer ul li a {
	text-decoration: none;
	transition: color 0.3s ease;
}

footer ul li a:hover {
	color: #d4d4d4;
}
</style>

<header>
	<nav id="navbar" class="navbar navbar-expand-lg bg-white text-black shadow-lg">
		<div class="container">
			<a class="navbar-brand" href="${home}">
				<img src="${pageContext.request.contextPath}/template/web/assets/img/logo/zoo-logo.png" alt="logo" height="50">
			</a>

			<!-- Toggle button for mobile view -->
			<button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav"
					aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
				<span class="navbar-toggler-icon"></span>
			</button>

			<!-- Navbar Links -->
			<div class="collapse navbar-collapse" id="navbarNav">
				<ul class="navbar-nav ms-auto">
					<li class="nav-item">
						<a class="nav-link text-uppercase" href="${about}">Về Chúng Tôi</a>
					</li>
					<li class="nav-item">
						<a class="nav-link text-uppercase" href="${animal}">Động Vật</a>
					</li>
					<li class="nav-item">
						<a class="nav-link text-uppercase" href="${question}">Liên hệ</a>
					</li>
					<li class="nav-item">
						<a class="nav-link text-uppercase" href="${rule}">Quy định</a>
					</li>
					<li class="nav-item">
						<a class="nav-link text-uppercase" href="${ticket}">Vé</a>
					</li>
					<li class="nav-item">
						<a class="nav-link" href="${cart}">
							<img src="${pageContext.request.contextPath}/template/web/assets/img/icon/shopping-bag.png" alt="Giỏ Hàng" height="24">
						</a>
					</li>

					<!-- Kiểm tra đăng nhập -->
					<c:if test="${not empty sessionScope.customer}">
						<li class="nav-item">
							<a class="nav-link text-uppercase" href="${logout}">Đăng Xuất</a>
						</li>
					</c:if>
					<c:if test="${empty sessionScope.customer}">
						<li class="nav-item">
							<a class="nav-link text-uppercase" href="${login}">Đăng Nhập</a>
						</li>
					</c:if>
				</ul>
			</div>
		</div>
	</nav>
</header>

