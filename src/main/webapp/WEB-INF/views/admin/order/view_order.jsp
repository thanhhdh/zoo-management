<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/common/taglib.jsp"%>

<div class="content-wrapper">
	<div class="page-header">
		<h3 class="page-title">
			<span class="page-title-icon bg-gradient-primary text-white me-2">
				<i class="mdi mdi-crosshairs-gps"></i>
			</span> Đơn Đặt Vé
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
				<div style="display: flex;justify-content: space-between">
					<div class="card-title col-sm-9">Danh Sách Đơn Đặt Vé</div>
					<div class="col-sm-3">
						<div class="input-group">
							<input id="search" type="text" class="form-control" name="search"
								   placeholder="Tìm Kiếm Mã Đơn Hàng">
							<button type="button" class="btn-md btn-inverse-success btn-icon">
								<i class="mdi mdi-account-search"></i>
							</button>
						</div>
					</div>
				</div>
				<table style="margin-top:20px" id="load_table_order" class="table table-bordered">
					<thead>
						<tr>
							<th style="font-weight: bold;">STT</th>
							<th style="font-weight: bold;">Mã đơn hàng</th>
							<th style="font-weight: bold;">Tên người đặt</th>
							<th style="font-weight: bold;">Hình thức thanh toán</th>
							<th style="font-weight: bold;">Thời gian đặt</th>
							<th style="font-weight: bold;">Trạng thái</th>
							<th style="font-weight: bold;">Chức năng</th>
						</tr>
					</thead>
					<tbody>
					<%
						int i = 1;
					%>
				<c:if test="${not empty orders.listResult}">
					<c:forEach var="item" items="${orders.listResult}">
						<tr class="table">
							<td style="max-width: 150px; word-wrap: break-word;" ><%=i++%></td>
							<td style="max-width: 150px; word-wrap: break-word;">${item.orderCode}</td>
							<td style="max-width: 150px; word-wrap: break-word;">
								<c:choose>
									<c:when test="${item.customerId.customerId == 0}">
										Khách vãng lai
									</c:when>
									<c:otherwise>
										${item.customerId.customerName}
									</c:otherwise>
								</c:choose>
							</td>



							<td style="max-width: 150px; word-wrap: break-word;">
								<c:choose>
									<c:when test="${item.paymentId.paymentMethod == 1}">Thanh toán trực tiếp</c:when>
									<c:when test="${item.paymentId.paymentMethod == 2}">Thanh toán trực tuyến</c:when>
								</c:choose>
							</td>

							<td style="max-width: 150px; word-wrap: break-word;">${item.createdAt}</td>

							<!-- Order Status -->
							<td style="max-width: 150px; word-wrap: break-word;">
								<c:choose>
									<c:when test="${item.orderStatus == 'PENDING'}">
										<span class="badge bg-primary">Đang chờ</span>
									</c:when>
									<%--									<c:when test="${item.orderStatus == 'PROCESSING'}">Đang xử lý</c:when>--%>
									<c:when test="${item.orderStatus == 'COMPLETED'}">
										<span class="badge bg-success">Đã xác nhận</span>
									</c:when>
									<c:when test="${item.orderStatus == 'CANCELLED'}">
										<span class="badge bg-danger">Đã hủy</span>
									</c:when>
								</c:choose>
							</td>

							<td style="display: flex; flex-direction: column" >
								<c:url var="viewOrderDetail" value="/admin/order/view-order-detail">
									<c:param name="order_code" value="${item.orderCode}" />
								</c:url>
								<c:url var="cancelOrder" value="/admin/order/cancel-order">
									<c:param name="order_code" value="${item.orderCode}" />
								</c:url>
								<c:url var="confirmOrder" value="/admin/order/confirm-order">
									<c:param name="order_code" value="${item.orderCode}" />
								</c:url>

								<a href="${viewOrderDetail}" class="btn btn-gradient-info btn-sm mb-2">
									<i class="mdi mdi-eye"></i> Xem đơn
								</a>

								<c:choose>
									<c:when test="${item.orderStatus == 'PENDING'}">
										<a href="${confirmOrder}" class="btn btn-gradient-success btn-sm mb-2">
											<i class="mdi mdi-check-circle-outline"></i> Xác nhận
										</a>

										<a href="${cancelOrder}" class="btn btn-gradient-danger btn-sm mb-2">
											<i class="mdi mdi-close-circle-outline"></i> Hủy đơn
										</a>
									</c:when>
								</c:choose>
							</td>
						</tr>
					</c:forEach>
				</c:if>
					<c:if test="${empty orders.listResult}">
						<tr>
							<td colspan="7" class="text-center">Không tìm thấy kết quả nào.</td>
						</tr>
					</c:if>
					</tbody>
				</table>
				<nav class="d-flex justify-content-center pt-4" aria-label="Page navigation">
					<ul class="pagination" id="pagination"></ul>
				</nav>
			</div>
		</div>
	</div>
</div>

<script type="text/javascript">
var totalPages = ${orders.totalPage};
var currentPage = ${orders.page};
var limit = ${orders.limit};
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
    		  window.location.href = "/zooproject/admin/order/view-order?page=" + page + "&limit=" + limit;
			}
       }
   });
});

$(document).ready(function() {
	$('#search').on('keyup', function() {
		performSearch(); // Gọi hàm tìm kiếm khi gõ phím
	});

	$('.btn-inverse-success').on('click', function() {
		performSearch(); // Gọi hàm tìm kiếm khi nhấn nút tìm kiếm
	});

	function performSearch() {
		var keyword = $('#search').val();
		$.ajax({
			url: '/zooproject/admin/order/search',
			method: 'GET',
			data: { keyword: keyword },
			success: function(response) {
				// Tạo một phần tử tạm để chứa toàn bộ trang trả về từ server
				var tempDiv = $('<div>').html(response);

				// Chỉ lấy phần bảng từ `#load_table_order` trong trang trả về
				var tableContent = tempDiv.find('#load_table_order').html();

				// Cập nhật phần bảng trên trang hiện tại
				$('#load_table_order').html(tableContent);
			},
			error: function() {
				alert("Đã xảy ra lỗi khi tìm kiếm.");
			}
		});
	}

});

</script>
<style>
	table th, table td {
		text-align: center;
		vertical-align: middle;
	}
	table td {
		white-space: nowrap;
		overflow: hidden;
		text-overflow: ellipsis;
	}


</style>




