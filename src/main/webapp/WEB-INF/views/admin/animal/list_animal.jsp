<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="/common/taglib.jsp"%>
<c:url var="urlImg" value="/template/web/img/animal/"></c:url>

<div class="content-wrapper">
	<div class="page-header">
		<h3 class="page-title">
			<span class="page-title-icon bg-gradient-primary text-white me-2">
				<i class="mdi mdi-crosshairs-gps"></i>
			</span> Danh Sách Động Vật
		</h3>
		<nav aria-label="breadcrumb">
			<ul class="breadcrumb">
				<li class="breadcrumb-item active" aria-current="page"><i
						class="mdi mdi-timetable"></i> <span></span></li>
			</ul>
		</nav>
	</div>

	<div class="row">
		<!-- Form chọn loài và chuồng -->
		<div class="col-lg-3 col-md-6 col-sm-12 mb-3">
			<div class="form-group">
				<label for="speciesSelect">Chọn Loài</label>
				<select id="speciesSelect" class="form-control">
					<option value="">--Chọn loài--</option>
					<c:forEach var="item" items="${species}">
						<option value="${item.id}"
								<c:if test="${param.speciesId == item.id}">
									selected="selected"
								</c:if>>${item.speciesName}</option>
					</c:forEach>
				</select>
			</div>
		</div>

		<div class="col-lg-3 col-md-6 col-sm-12 mb-3">
			<div class="form-group">
				<label for="cageSelect">Chọn Chuồng</label>
				<select id="cageSelect" class="form-control">
					<option value="">--Chọn Chuồng--</option>
					<c:forEach var="item" items="${cages}">
						<option value="${item.id }"
								<c:if test="${param.cageId == item.id}">
									selected="selected"
								</c:if>>${item.cageName}</option>
					</c:forEach>
				</select>
			</div>
		</div>
	</div>

	<div class="table-responsive">
		<table class="table-bordered table">
			<thead>
			<tr>
				<th style="font-weight: bold;">STT</th>
				<th style="font-weight: bold;">Tên</th>
				<th style="font-weight: bold;">Loài</th>
				<th style="font-weight: bold;">Hình Ảnh</th>
				<th style="font-weight: bold;">Phân Bố</th>
				<th style="font-weight: bold;">Nguồn Gốc</th> <!-- New header for origin -->
				<th style="font-weight: bold;">Ngày Nhập</th> <!-- New header for dateOfEntry -->
				<th style="font-weight: bold;">Tuổi</th> <!-- New header for animalAge -->
				<th style="font-weight: bold;">Hồ Sơ</th>
				<th style="font-weight: bold;">Trạng Thái</th>
				<th style="font-weight: bold;">Chức Năng</th>
				<th style="font-weight: bold;">Hồ Sơ & Chi Tiết</th>
			</tr>
			</thead>
			<tbody>
			<c:if test="${not empty animal}">
				<c:forEach var="item" items="${animal.listResult}">
					<tr>
						<td>${item.animalId}</td>
						<td>${item.animalName}</td>
						<td>${item.species.speciesName}</td>
						<td><img alt="" src="${urlImg}${item.animalImage}" style="width: 50px; height: auto;" /></td>
						<td>${item.animalAllocation}</td>
						<td>${item.origin}</td> <!-- New field for origin -->
						<td>${item.dateOfEntry}</td> <!-- New field for date of entry -->
						<td>${item.animalAge}</td> <!-- New field for animal age -->

						<!-- Medical Record Check -->
						<c:choose>
							<c:when test="${not empty medical.listResult}">
								<c:set var="hasRecord" value="false" />
								<!-- Kiểm tra hồ sơ y tế -->
								<c:forEach var="record" items="${medical.listResult}">
									<c:if test="${record.animal.animalId == item.animalId && !hasRecord}">
										<td style="color: green; font-weight: bold;">Đã có</td>
										<c:set var="hasRecord" value="true" />
									</c:if>
								</c:forEach>
								<!-- Nếu không tìm thấy bản ghi nào -->
								<c:if test="${!hasRecord}">
									<td style="color: red; font-weight: bold;">Chưa có</td>
								</c:if>
							</c:when>
							<c:otherwise>
								<td style="color: red; font-weight: bold;">Chưa có</td>
							</c:otherwise>
						</c:choose>


						<!-- Animal Status Toggle -->
						<td>
							<c:url var="updateStatus" value="/admin/animal/update-status">
								<c:param name="animalId" value="${item.animalId}" />
							</c:url>
							<c:choose>
								<c:when test="${item.animalStatus == 'HEALTHY'}">
									<a href="${updateStatus}">
										<i style="color: rgb(52, 211, 52); font-size: 30px" class="mdi mdi-heart"></i>
										<br/>
										Khỏe Mạnh
									</a>
								</c:when>
								<c:when test="${item.animalStatus == 'SICK'}">
									<a href="${updateStatus}">
										<i style="color: rgb(211, 52, 52); font-size: 30px" class="mdi mdi-alert-octagon"></i>
										<br/>
										Bệnh
									</a>
								</c:when>
								<c:when test="${item.animalStatus == 'IN_QUARANTINE'}">
									<a href="${updateStatus}">
										<i style="color: rgb(255, 165, 0); font-size: 30px" class="mdi mdi-alert"></i>
										<br/>
										Cách Ly
									</a>
								</c:when>
								<c:when test="${item.animalStatus == 'UNDER_TREATMENT'}">
									<a href="${updateStatus}">
										<i style="color: rgb(0, 0, 255); font-size: 30px" class="mdi mdi-hospital"></i>
										<br/>
										Đang Điều Trị
									</a>
								</c:when>
							</c:choose>
						</td>

						<!-- Action Buttons -->
						<td>
							<div>
								<!-- Delete Animal -->
								<c:url var="deleteAnimal" value="delete/${item.animalId}">
									<c:param name="animalId" value="${item.animalId}" />
								</c:url>
								<a href="${deleteAnimal}" class="delete-animal">
									<i class="mdi mdi-delete-forever" style="color: red; margin-right: 10px; font-size: 1.4rem"></i>
								</a>

								<!-- Edit Animal -->
								<c:url var="editAnimal" value="/admin/animal/edit">
									<c:param name="animalId" value="${item.animalId}" />
								</c:url>
								<a href="${editAnimal}">
									<i class="mdi mdi-open-in-new" style="color: green; margin-right: 10px; font-size: 1.2rem"></i>
								</a>

							</div>
						</td>

						<!-- Medical Record Actions -->
						<td>
							<div>
								<c:set var="hasMedicalRecord" value="false" />
								<c:forEach var="record" items="${medical.listResult}">
									<c:if test="${record.animal.animalId == item.animalId}">
										<c:set var="hasMedicalRecord" value="true" />
									</c:if>
								</c:forEach>

								<!-- URL chuyển hướng đến danh sách hồ sơ y tế -->
								<c:url var="medicalListUrl" value="${hasMedicalRecord ? '/admin/medical/list' : '/admin/medical/add'}">
									<c:param name="animalId" value="${item.animalId}" />
								</c:url>

								<!-- Nút xem danh sách hồ sơ y tế -->
								<a href="${medicalListUrl}" class="btn btn-info btn-sm" style="margin-right: 10px; min-width: 150px">
									<c:if test="${hasMedicalRecord}">
										Xem Hồ Sơ Y Tế
									</c:if>
									<c:if test="${!hasMedicalRecord}">
										Thêm Hồ Sơ Y Tế
									</c:if>
								</a>

								<br/>
								<!-- Detail View -->
								<c:url var="detailAnimal" value="/admin/animal/detail">
									<c:param name="id" value="${item.animalId}" />
								</c:url>
								<a href="${detailAnimal}" class="btn btn-info btn-sm" style="margin-top: 10px; min-width: 150px">
									Xem Chi Tiết
								</a>
							</div>
						</td>
					</tr>
				</c:forEach>
			</c:if>
			</tbody>
		</table>
	</div>
	<nav class="d-flex justify-content-center pt-4" aria-label="Page navigation">
		<ul class="pagination" id="pagination"></ul>
	</nav>

</div>

<script type="text/javascript">
<%-- Hien thi filter dong vat theo loai	--%>
	// Đặt giá trị đã chọn
	var speciesId = new URLSearchParams(window.location.search).get('speciesId');
	if (speciesId) {
		$('#speciesSelect').val(speciesId);
	}

	// Thay đổi giá trị khi người dùng chọn
	$(document).ready(function() {
		$('#speciesSelect').on('change', function() {
			var speciesId = $(this).val();
			var url = '/zooproject/admin/animal/list';

			if (speciesId) {
				url += '?speciesId=' + speciesId;
			}
			window.location.href = url;
		});
	});
</script>


<script type="text/javascript">
	<%-- Hien thi filter dong vat theo chuong	--%>
	var cageId = new URLSearchParams(window.location.search).get('cageId');
	if (cageId) {
		$('#cageSelect').val(cageId);
	}

	$(document).ready(function() {
		$('#cageSelect').on('change', function() {
			var cageId = $(this).val();
			var url = '/zooproject/admin/animal/list';

			if (cageId) {
				url += '?cageId=' + cageId;
			}
			window.location.href = url;
		});
	});
</script>


<script type="text/javascript">
	var totalPages = ${animal.totalPage};
	var currentPage = ${animal.page};
	var limit = ${animal.limit};
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
        		  window.location.href = "/zooproject/admin/animal/list?page=" + page + "&limit=" + limit;
				}
           }
       });
   });
   
   $(document).ready(function() {
       var deleteUrl;

       // Khi người dùng nhấn nút xóa
       $(".delete-animal").on("click", function(e) {
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
