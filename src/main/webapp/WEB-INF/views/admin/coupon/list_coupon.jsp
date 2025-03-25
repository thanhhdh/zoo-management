<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/common/taglib.jsp"%>

<%@ page import="java.text.SimpleDateFormat, java.util.Date"%>

<c:set var="currentDate" value="<%=new java.util.Date()%>" />
<fmt:formatDate pattern="yyyy/MM/dd" value="${currentDate}"
	var="formattedDate" />


<div class="content-wrapper">
	<div class="page-header">
		<h3 class="page-title">
			<span class="page-title-icon bg-gradient-primary text-white me-2">
				<i class="mdi mdi-crosshairs-gps"></i>
			</span> Liệt Kê Mã Giảm
		</h3>
		<nav aria-label="breadcrumb">
			<ul class="breadcrumb">
				<li class="breadcrumb-item active" aria-current="page"><i
					class="mdi mdi-timetable"></i> <span></span></li>
			</ul>
		</nav>
	</div>
	<div class="col-md-12 grid-margin stretch-card">
		<div class="card">
			<div class="card-body">
				<table class="table-bordered table">
					<thead>
						<tr>
							<th style="font-weight: bold;">Tên Mã Giảm Giá</th>
							<th style="font-weight: bold;">Mã Giảm Giá</th>
							<th style="font-weight: bold;">Số Lượng</th>
							<th style="font-weight: bold;">Số Giảm</th>
							<th style="font-weight: bold;">Tình Trạng</th>
							<th style="font-weight: bold;">Ngày Bắt Đầu</th>
							<th style="font-weight: bold;">Ngày Kết Thúc</th>
							<th style="font-weight: bold;">Chức Năng</th>
						</tr>
					</thead>
					<tbody>
						<c:if test="${not empty coupons}">
							<c:forEach var="item" items="${coupons.listResult }">
								<c:set var="currentDates" value="${currentDate }" />
								<tr>
									<td>${item.couponName}</td>
									<td>${item.couponCode}</td>
									<td>${item.couponQty}</td>

									<c:choose>
										<c:when test="${item.couponCondition == 1}">
											<td>${item.couponNumber}%</td>
										</c:when>
										<c:when test="${item.couponCondition == 2}">

											<td><fmt:formatNumber value="${item.couponNumber}"
													pattern="#,###.##" /> đ</td>
										</c:when>
									</c:choose>
									<c:choose>
										<c:when test="${item.couponEnd >= formattedDate}">
											<td style="color: green; font-weight: bold;">Còn hạn</td>
										</c:when>
										<c:when test="${item.couponStart <= formattedDate}">
											<td style="color: red; font-weight: bold;">Hết hạn</td>

										</c:when>
									</c:choose>
									<td>${item.couponStart}</td>
									<td>${item.couponEnd}</td>

									<td>
										<div>

											<c:url var="deleteCoupon" value="delete/${item.couponId}">
												<c:param name="couponId" value="${item.couponId}" />
											</c:url>
											<a href="${deleteCoupon}" class="delete-coupon">
												<i class="mdi mdi-delete-forever" style="color: red; margin-right: 10px; font-size: 1.4rem"></i>
											</a>


											<c:url var="editCoupon" value="update">
												<c:param name="couponId" value="${item.couponId}" />
											</c:url>
											<a href="${editCoupon }"> <i class="mdi mdi-open-in-new"
																		 style="color: green; font-size: 1.2rem"></i>
											</a>
										</div>
									</td>
								</tr>
							</c:forEach>
						</c:if>
					</tbody>
				</table>
				<nav class="d-flex justify-content-center pt-4"
					aria-label="Page navigation">
					<ul class="pagination" id="pagination"></ul>
				</nav>
			</div>
		</div>
	</div>
</div>

<script type="text/javascript">
	var totalPages = ${coupons.totalPage};
	var currentPage = ${coupons.page};
	var limit = ${coupons.limit};
	var page = 1;
   $(function () {
       window.pagObj = $('#pagination').twbsPagination({
           totalPages: totalPages,
           visiblePages: 3,
           startPage: currentPage,
           first:'Đầu',
           prev:'Trước',
           next:'Tiếp',
           last:'Cuối',
           onPageClick: function (event, page) {
        	   page = page;
        	   if (currentPage != page) {			
        		  window.location.href = "/zooproject/admin/coupon/list?page=" + page + "&limit=" + limit;
				}
           }
       });
   });

	$(document).ready(function() {
		var deleteUrl;

		// Khi người dùng nhấn nút xóa
		$(".delete-coupon").on("click", function(e) {
			e.preventDefault();
			deleteUrl = $(this).attr("href");
			$('#deleteModal').modal('show'); // Hiển thị modal
		});

		// Khi người dùng xác nhận xóa trong modal
		$("#confirmDelete").on("click", function() {
			window.location.href = deleteUrl; // Điều hướng đến URL xóa
		});
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

<style>
table th, table td {
	text-align: center;
	vertical-align: middle;
}

table td {
	max-width: 100px;
	white-space: nowrap;
	overflow: hidden;
	text-overflow: ellipsis;
}
</style>
