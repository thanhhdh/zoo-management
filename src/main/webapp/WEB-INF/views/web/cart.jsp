
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="/common/taglib.jsp"%>
<c:url var="postURL" value="/them-ve"></c:url>

<!-- Bootstrap CSS -->
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css"
	rel="stylesheet">
<style>
body {
    background-color: #e2e4e7;
}
/* General table styling */
.table {
	background-color: #fff;
	border-radius: 10px;
	overflow: hidden;
	box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
	margin-bottom: 0;
}

.table thead th {
	background-color: #f8f9fa;
	color: #343a40;
	font-weight: bold;
}

.table tbody td {
	vertical-align: middle;
}

.cart-item-img img {
	width: 50px;
	height: 50px;
	object-fit: cover;
	border-radius: 5px;
}

.cart-item-name, .cart-item-price, .cart-item-qty {
	font-size: 1rem;
}

.cart-item-close a {
	color: #dc3545;
}

.cart-item-close a:hover {
	color: #c82333;
}

.cart-total {
	background-color: #f1f1f1;
	font-weight: bold;
}

.cart-total-price {
	font-size: 1.2rem;
	color: #28a745;
}

.btn-update-cart {
	width: 100px;
	text-align: center;
}

.check_out {
	margin-top: 10px;
}

.empty-cart img {
	display: block;
	margin: auto;
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

</style>

<div class="row gx-5 mt-5" style="margin: 0px">
  <div class="col-12 col-md-12 col-lg-3"></div>
	<div class="col-12 col-md-12 col-lg-6 mt-5 mb-5">
		<div class="card ">
			<img alt=""
				src="<c:url value='/template/web/assets/img/ticket/zoo_order_ticket_home.webp'/>">
			<div class="container mt-5 mb-3">
				<div class="card">
					<div class="card-body">
						<h5 class="card-title text-center">Giỏ hàng của bạn</h5>
						<table class="table">
							<thead>
								<tr>
									<th>Loại vé</th>
									<th>Giá</th>
									<th>SL</th>
									<th></th>
								</tr>
							</thead>
							<tbody id="loading-cart">
								<c:if test="${ not empty sessionScope.cart}">
									<c:set var="total" value="0" />
									<c:forEach var="item" items="${cart}">
										<c:set var="qty" value="${item.ticketQty }" />
										<c:set var="price" value="${item.ticketPrice }" />
										<c:set var="total" value="${ total + (qty * price) }" />

										<tr class="cart-items-info">

											<td class="cart-item-name">${item.ticketName }</td>
											<td class="cart-item-price"><fmt:formatNumber
													value="${item.ticketPrice}" pattern="#,###.##" /> đ</td>
											<td class="cart-item-qty"><input type="number"
												class="btn-update-cart" value="${item.ticketQty }"
												data-ticket_name="${item.ticketName}" min="1"></td>
											<td class="cart-item-close"><c:url var="deleteCart"
													value="/xoa-ve">
													<c:param name="nameTicket" value="${item.ticketName}" />
												</c:url> <a href="${ deleteCart}" class="btn btn-success text-white"> <i
													class="fa-regular fa-circle-xmark delete-cart"
													data-delete_id="${item.ticketName }"></i>X
											</a></td>
										</tr>
									</c:forEach>
									<tr class="cart-total">
										<td colspan="2">Tổng: <span
											style="color: #9c9c9c; font-size: 1rem; font-weight: 400">(Tạm
												tính)</span></td>
										<td colspan="3" id="load-price" class="cart-total-price">
											<fmt:formatNumber value="${total }" pattern="#,###.##" /> đ
										</td>
									</tr>
									<tr>
										<c:choose>
											<c:when test="${coupon.couponCondition == 1}">
												<td colspan="6">
													<p style="border-style: dotted;" class="btn btn-success text-white">
														<i class="fa-solid fa-tags"></i> ${coupon.couponCode } -<span>
															${coupon.couponNumber } %</span>
													</p> <c:set var="total_coupon"
														value="${total * coupon.couponNumber / 100 }" />

													<p id="total-coupon" >Tổng giảm:
													
														<fmt:formatNumber value="${total_coupon }"
															pattern="#,###.##" />
														đ
												
													</p>
												</td>
												<tr class="cart-total">
													<td colspan="2" class="cart-total-title">Tổng sau
														giảm: <span
														style="color: #9c9c9c; font-size: 1rem; font-weight: 400"></span>
													</td>
													<td colspan="4" id="load-total" class="cart-total-price">
														<fmt:formatNumber value="${total - total_coupon }"
															pattern="#,###.##" /> đ
													</td>
												</tr>
											</c:when>
										</c:choose>
									<tr>
										<c:choose>
											<c:when test="${coupon.couponCondition == 2}">
												<td colspan="6">
													<p style="border-style: dotted;" class="btn btn-success text-white">
														<i class="fa-solid fa-tags"></i> ${coupon.couponCode } -<span>
															<fmt:formatNumber value="${coupon.couponNumber }"
																pattern="#,###.##" /> đ
														</span>
													</p> <c:set var="total_coupon"
														value="${total - coupon.couponNumber}" />

												</td>

												<tr class="cart-total">
													<td colspan="2" class="cart-total-title">Tổng sau
														giảm: <span
														style="color: #9c9c9c; font-size: 1rem; font-weight: 400"></span>
													</td>
													<td colspan="4" id="load-total" class="cart-total-price">
														<fmt:formatNumber value="${total_coupon }"
															pattern="#,###.##" /> đ
													</td>
												</tr>
											</c:when>
										</c:choose>
									</tr>
									<tr>
										<td colspan="5" class="text-center"><c:url var="checkOut"
												value="/thu-tuc-thanh-toan" /> <a
											class="btn btn-success check_out w-100 p-2"
											href="${checkOut }">Thanh toán</a></td>
									</tr>
									<tr>
										<td colspan="6" class="text-center"><s:form
												modelAttribute="coupon" action="/zooproject/kiem-tra-ma-giam"
												method="post" enctype="multipart/form-data">
												<div class="input-group mb-3">
													<span class="input-group-text" id="basic-addon1"><i
														class="fa-solid fa-ticket"></i></span> <input type="text"
														class="form-control" name="couponCode"
														placeholder="Nhập mã giảm giá">
													<button type="submit" class="btn btn-success">Tính</button>
												</div>
											</s:form></td>
									</tr>
								</c:if>
								<c:if test="${empty sessionScope.cart}">
									<tr class="empty-cart">
										<td colspan="5"><img
											src="https://bizweb.dktcdn.net/100/368/281/themes/739953/assets/empty-cart.png?1661855650057"
											width="310px" alt="Empty Cart"></td>
									</tr>
								</c:if>
							</tbody>
						</table>
					</div>
				</div>
			</div>
		</div>
	</div>
	<div class="col-12 col-md-12 col-lg-3"></div>
</div>

<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script>
        $('.btn-update-cart').on('click', function() {
            var ticket_name = $(this).data('ticket_name');
            var ticket_qty = $(this).val();
            var url = '/zooproject/cap-nhat-gio-hang?ticket_name=' +
                encodeURIComponent(ticket_name) + "&ticket_qty=" +
                ticket_qty;
            $.ajax({
                url: url,
                method: 'GET',
                success: function(data) {
                    var data_price = data.price;
                    var total = data.total;
                    var coupon_price = data.coupon_price;

                    // Định dạng số sử dụng hàm toLocaleString()
                    var formattedPrice = parseFloat(data_price).toLocaleString('vi-VN', {
                        style: 'currency',
                        currency: 'VND'
                    });
                    var totalFormatted = parseFloat(total).toLocaleString('vi-VN', {
                        style: 'currency',
                        currency: 'VND'
                    });
                    var couponPriceFormatted = parseFloat(coupon_price).toLocaleString('vi-VN', {
                        style: 'currency',
                        currency: 'VND'
                    });
                    $('#load-price').html('<p>' + formattedPrice + '</p>');
                    $('#load-total').html('<p>' + totalFormatted + '</p>');
                    $('#total-coupon').html('<p>Tổng giảm: ' + couponPriceFormatted + '</p>');
                },
                error: function(data) {
                    alert("Fix Bug Huhu :<");
                },
            });
        });
    </script>

<!-- Bootstrap JS -->
<script
	src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js"></script>
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.min.js"></script>
<script type="text/javascript">
	$(document).ready(function() {
		<c:if test="${not empty message}">
			var message = "${message.message}";
			var type = "${message.type}";
			message_toastr(type, message, "Thông Báo");
		</c:if>
	});
</script>
