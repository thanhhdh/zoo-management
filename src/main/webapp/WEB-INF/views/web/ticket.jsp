<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/common/taglib.jsp"%>

<c:url var="postURL" value="/them-ve"></c:url>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
<style>

body {
    background-color: #f8f9fa;
    width: 100%;
}
.toast-success {
    background-color: #51a351 !important; /* Màu nền của thông báo thành công */
    color: white !important; /* Màu chữ */
}

.toast-error {
    background-color: #bd362f !important; /* Màu nền của thông báo lỗi */
    color: white !important;
}

.toast-info {
    background-color: #2f96b4 !important; /* Màu nền của thông báo thông tin */
    color: white !important;
}

.toast-warning {
    background-color: #f89406 !important; /* Màu nền của thông báo cảnh báo */
    color: white !important;
}


.grid-container {
	display: grid;
	grid-template-columns: 3fr 1fr;
	gap: 20px;
}

.grid-item-large {
	grid-row: span 2;
}

.grid-item img {
	width: 100%;
	height: auto;
	border-radius: 10px;
	object-fit: cover;
    box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
}

h3 {
    color: #343a40;
    font-weight: bold;
    margin-top: 20px;
}

.card {
    box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
    border: none;
}

.card-body {
    background-color: #ffffff;
    border-radius: 10px;
    padding: 20px;
}

.fs-6 {
    font-weight: bold;
    color: #495057;
}

.btn-outline-success {
    width: 100%;
    padding: 10px;
    border-radius: 8px;
}

.btn-outline-success:hover {
    background-color: #28a745;
    color: white;
}

.card-text {
    font-size: 1.2rem;
    color: #28a745;
    font-weight: bold;
}

</style>

<div class="text-center">
	<img alt="" src="<c:url value='/template/web/assets/img/ticket/zoo_order_ticket_home.webp'/>" style="width: 100%; border-radius: 10px; box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);">
</div>

<div class="container-md mt-10 mb-10">
	<h3>Đặt Vé Ngay !!!</h3>
		<div class="grid-container">
			<div class="grid-item grid-item-large">
				<img src="<c:url value='/template/web/assets/img/ticket/on0pfainphmohu8xjdop.webp'/>" alt="Large Image">
			</div>
			<!-- Top Right Image -->
			<div class="grid-item">
				<img src="<c:url value='/template/web/assets/img/ticket/s4lgrj0d5u81pes5doz0.webp'/>" alt="Small Image 1">
			</div>
			<!-- Bottom Right Image with Button -->
			<div class="grid-item">
				<img src="<c:url value='/template/web/assets/img/ticket/t2cl2ded987uufglcthj.webp'/>" alt="Small Image 2">
			</div>
		</div>
		<div class="row mt-4">
			<div class="col-lg-9">
				<div class="card">
					<div class="card-body">
						<div class="row">
							<div class="col-lg-10">
								<h5>Hiện tại sở thú áp dụng hai loại vé vào cổng là vé người lớn và vé trẻ em</h5>
								<ul>
									<li>Áp dụng cho quý khách cao từ 1.3m trở lên Vé trẻ em</li>
									<li>Áp dụng cho quý khách cao từ 1m đến dưới 1.3m (Trẻ em dưới 1m, đi kèm phụ huynh được miễn phí vé vào cổng)</li>
									<li>Quý khách mua vé Online, sau khi thanh toán thì mã QR Code sẽ được gởi đến EMAIL của bạn tức thì sau khi giao dịch được xác nhận thành công.</li>
								</ul>
							</div>
							<div class="col-lg-2">
								<img src="<c:url value='/template/web/assets/img/ticket/veeon5jzqyjccj5m3lkg.webp'/>" alt="Small Image 3" class="img-fluid rounded">
							</div>
						</div>
					</div>
				</div>
			</div>

			<div class="col-lg-3">
				<div class="card">
					<div class="card-body">
						<h5 class="fs-6">Vé cổng (cao từ 1m đến dưới 1.3m)</h5>
						<p class="card-text">40.000 đ</p>
						<s:form modelAttribute="ticket" action="${postURL }" enctype="multipart/form-data" method="POST">
							<input hidden name="ticketName" value="Vé cổng (cao từ 1m đến dưới 1.3m)" >
							<input hidden name="ticketQty" value="1" >
							<input hidden name="ticketPrice" value="40000" >
							<button type="submit" class="btn btn-outline-success">Thêm Vào Giỏ Hàng</button>
						</s:form>
					</div>
				</div>
				<div class="card mt-4">
					<div class="card-body">
						<h5 class="fs-6">Vé cổng (cao từ 1.3m trở lên)</h5>
						<p class="card-text">60.000 đ</p>
						<s:form modelAttribute="ticket" action="${postURL }" enctype="multipart/form-data" method="POST">
							<input hidden name="ticketName" value="Vé cổng (cao từ 1.3m trở lên)" >
							<input hidden name="ticketQty" value="1" >
							<input hidden name="ticketPrice" value="60000" >
							<button type="submit" class="btn btn-outline-success">Thêm Vào Giỏ Hàng</button>
						</s:form>
					</div>
				</div>
			</div>
		</div>
	</div>
	
<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.min.js"></script>
<script type="text/javascript">
	$(document).ready(function() {
		<c:if test="${not empty message}">
			var message = "${message.message}";
			var type = "${message.type}";
			message_toastr(type, message, "Thông Báo");
		</c:if>
	});
</script>


