<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="/common/taglib.jsp"%>
<c:url var="apiURL" value="/api/species"></c:url>

<div class="content-wrapper">
	<div class="page-header">
		<h3 class="page-title">
			<span class="page-title-icon bg-gradient-primary text-white me-2">
				<i class="mdi mdi-crosshairs-gps"></i>
			</span> Liệt Kê Loài
		</h3>
		<nav aria-label="breadcrumb">
			<ul class="breadcrumb">
				<li class="breadcrumb-item active" aria-current="page"><i class="mdi mdi-timetable"></i> <span></span></li>
			</ul>
		</nav>
	</div>
	
	<div class="col-md-12 grid-margin stretch-card">
		<div class="card">
			<div class="card-body">
				<table class="table-bordered table">
					<thead>
						<tr>
							<th style="font-weight: bold;">STT</th>
							<th style="font-weight: bold;">Tên loài</th>
							<th style="font-weight: bold;">Mô Tả</th>
							<th style="font-weight: bold;">Hình ảnh</th>
							<th style="font-weight: bold;">Phân Bố</th>
							<th style="font-weight: bold;">Sinh Sản</th>
							<th style="font-weight: bold;">Hiển Thị</th>
							<th style="font-weight: bold;">Thao Tác</th>
						</tr>
					</thead>
					<c:url var="urlImg" value="/template/web/img/species/"></c:url>
					<tbody>
						<c:if test="${not empty species}">
							<c:forEach var="item" items="${species.listResult}">
								<tr>
									<td>${item.id}</td>
									<td style="max-width: 150px; word-wrap: break-word;">${item.speciesName}</td>
									<td style="max-width: 200px; word-wrap: break-word; overflow: hidden; text-overflow: ellipsis;">${item.specieDesc}</td>
									<td>
										<img style="object-fit: cover; width: 40px; height: 20px;" src="${urlImg}${item.speciesImage}" alt=""/>
									</td>
									<td style="max-width: 150px; word-wrap: break-word;">${item.speciesAllocation}</td>
									<td style="max-width: 150px; word-wrap: break-word;">${item.speciesReproduction}</td>
									<c:url var="updateStatus"
											value="/admin/species/update-status">
											<c:param name="speciesId" value="${item.id}" />
										</c:url>
									<td>
										<c:choose>
											<c:when test="${item.speciesStatus == 1}">
												<a href="${updateStatus }"> 
													<i style="color: rgb(52, 211, 52); font-size: 30px" class="mdi mdi-toggle-switch"></i>
												</a>
											</c:when>

											<c:when test="${item.speciesStatus == 0}">
												<a href="${ updateStatus}">
													<i style="color: rgb(196, 203, 196); font-size: 30px" class="mdi mdi-toggle-switch-off"></i>
												</a>
											</c:when>
										</c:choose>
									
									</td>
									<td>
										<div style="display: flex;">
											<c:url var="deleteSpecies" value="delete/${item.id}">
												<c:param name="id" value="${item.id}" />
											</c:url>
											<a href="${deleteSpecies}" class="delete-species">
												<i class="mdi mdi mdi-delete-forever" style="color: red; margin-right: 10px; font-size: 1.2rem"></i>
											</a>
											<c:url var="editSpecies" value="/admin/species/edit">
												<c:param name="id" value="${item.id}" />
											</c:url>
											<a href="${editSpecies}">
												<i class="mdi mdi-open-in-new" style="color: green; margin-right: 10px; font-size: 1.2rem"></i>
											</a>
											<c:url var="detailSpecies" value="detail">
												<c:param name="id" value="${item.id}" />
											</c:url>
											<a href="${detailSpecies}" class="delete-category">
												<i class="mdi mdi-pencil-box" style="font-size: 1.2rem"></i>
											</a>
										</div>
									</td>
									
								</tr>
							</c:forEach>
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
	var totalPages = ${species.totalPage};
	var currentPage = ${species.page};
	var limit = ${species.limit};
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
        		  window.location.href = "/zooproject/admin/species/list?page=" + page + "&limit=" + limit;
				}
           }
       });
   });
   
   $(document).ready(function() {
       var deleteUrl;

       // Khi người dùng nhấn nút xóa
       $(".delete-species").on("click", function(e) {
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
