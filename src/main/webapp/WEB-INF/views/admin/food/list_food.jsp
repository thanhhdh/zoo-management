<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="/common/taglib.jsp"%>

<c:url var="apiURL" value="/api/species"></c:url>

<div class="content-wrapper">
	<div class="page-header">
		<h3 class="page-title">
			<span class="page-title-icon bg-gradient-primary text-white me-2">
				<i class="mdi mdi-crosshairs-gps"></i>
			</span> Thức Ăn Trong Kho
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
							<th style="font-weight: bold;">#ID</th>
							<th style="font-weight: bold;">Tên</th>
							<th style="font-weight: bold;">Số Lượng</th>
							<th style="font-weight: bold;">Tình Trạng</th>
							<th style="font-weight: bold;">NSX</th>
							<th style="font-weight: bold;">HSD</th>
							<th style="font-weight: bold;">Thao Tác</th>
						</tr>
					</thead>
					<tbody>
						<c:if test="${not empty foods}">
							<c:forEach var="item" items="${foods.listResult}">
								<tr>
									<td>${item.foodId}</td>
									<td style="max-width: 150px; word-wrap: break-word;">${item.foodName}</td>
									<td style="max-width: 200px; word-wrap: break-word;">${item.foodQuantity}</td>
									
										<c:choose>
											<c:when test="${item.foodQuantity == 0}">
								            	<td style="color: red; font-weight: bold; max-width: 200px;">Cần Nhập Hàng</td>
								        	</c:when>
											<c:otherwise>
								            	<td style="color: green; font-weight: bold;">Còn Hàng</td>
								        	</c:otherwise>
										</c:choose>
										
									
									<td style="max-width: 150px; word-wrap: break-word;">${item.expirationStart}</td>
									<td style="max-width: 150px; word-wrap: break-word;">${item.expirationEnd}</td>
									<%-- <c:choose>
								        <c:when test="${item.supplier != null && not empty item.supplier.supplierName}">
								            ${item.supplier.supplierName}
								        </c:when>
								        <c:otherwise>
								            Không có dữ liệu
								        </c:otherwise>
								    </c:choose> --%>

									<td>
										<div style="display: flex;">
											<c:url var="deleteFood" value="/admin/food/delete">
												<c:param name="id" value="${item.foodId}" />
											</c:url>
											<a href="${deleteFood}" class="delete-food"> <i
												class="mdi mdi-delete-forever"
												style="color: red; margin-right: 10px; font-size: 1.2rem"></i>
											</a>
											<c:url var="editFood" value="/admin/food/edit">
												<c:param name="id" value="${item.foodId}" />
											</c:url>
											<a href="${editFood}"> <i class="mdi mdi-open-in-new"
												style="color: green; margin-right: 10px; font-size: 1.2rem"></i>
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
    var totalPages = ${foods.totalPage};
    var currentPage = ${foods.page};
    var limit = ${foods.limit};
    var page = 1;

    $(function () {
        window.pagObj = $('#pagination').twbsPagination({
            totalPages: totalPages,
            visiblePages: 3,
            startPage: currentPage,
            first: 'Đầu',
            prev: 'Trước',
            next: 'Tiếp',
            last: 'Cuối',
            onPageClick: function (event, page) {
                if (currentPage != page) {
                    window.location.href = "/zooproject/admin/food/list?page=" + page + "&limit=" + limit;
                }
            }
        });
    });

    $(document).ready(function() {
        var deleteUrl;

        // Khi người dùng nhấn nút xóa
        $(".delete-food").on("click", function(e) {
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

.modal-body i {
	font-size: 4rem; /* Tăng kích thước biểu tượng */
	color: #FFA500; /* Màu cam cho biểu tượng cảnh báo */
}

.modal-footer .btn-danger {
	background-color: #dc3545;
	color: white;
}

.modal-footer .btn-secondary {
	background-color: #6c757d;
	color: white;
}

.modal-footer .btn {
	min-width: 120px; /* Đảm bảo nút có kích thước đủ lớn */
}

.modal-body {
	padding-top: 20px;
	padding-bottom: 10px;
}

.modal-title {
	font-weight: bold;
}
</style>
