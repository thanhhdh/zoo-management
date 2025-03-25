<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="/common/taglib.jsp"%>
<c:url var="urlImg" value="/template/web/img/animal/"></c:url>

<div class="content-wrapper">
	<!-- Tiêu đề trang -->
	<div class="page-header">
		<h3 class="page-title">
            <span class="page-title-icon bg-gradient-primary text-white me-2">
                <i class="mdi mdi-paw"></i>
            </span>
			Thông Tin Động Vật: ${animal.animalName} (STT: ${animal.animalId})
		</h3>
		<nav aria-label="breadcrumb">
			<ul class="breadcrumb">
				<li class="breadcrumb-item active" aria-current="page">
					<i class="mdi mdi-timetable"></i> Chi Tiết
				</li>
			</ul>
		</nav>
	</div>

	<!-- Chi tiết động vật -->
	<div class="col-md-12 grid-margin stretch-card">
		<div class="card">
			<div class="card-body">
				<h4 class="card-title">Thông Tin Chi Tiết</h4>
				<div class="row">
					<!-- Phần thông tin -->
					<div class="col-md-8">
						<p><strong>Tên Động Vật:</strong> ${animal.animalName}</p>
						<p><strong>Tên Loài:</strong> ${animal.species.speciesName}</p>
						<p><strong>Chuồng:</strong> ${animal.cage.cageName}</p>
						<p><strong>Thức Ăn:</strong> ${animal.food.foodName}</p>
						<p><strong>Tuổi:</strong> ${animal.animalAge}</p>
						<p><strong>Trạng Thái:</strong>
							<c:choose>
								<c:when test="${animal.animalStatus == 'HEALTHY'}">Khỏe Mạnh</c:when>
								<c:when test="${animal.animalStatus == 'SICK'}">Bệnh</c:when>
								<c:when test="${animal.animalStatus == 'IN_QUARANTINE'}">Cách Ly</c:when>
								<c:when test="${animal.animalStatus == 'UNDER_TREATMENT'}">Đang Điều Trị</c:when>
							</c:choose>
						</p>
						<p><strong>Sinh Sản:</strong> ${animal.animalReproduction}</p>
						<p><strong>Phân Bố:</strong> ${animal.animalAllocation}</p>
						<p><strong>Mô Tả:</strong> ${animal.animalDesc}</p>
						<p><strong>Sinh Thái:</strong> ${animal.animalEcological}</p>
						<p><strong>Nguồn Gốc:</strong> ${animal.origin}</p>
						<p><strong>Ngày Nhập Chuồng:</strong> ${animal.dateOfEntry}</p>
					</div>
					<!-- Phần hình ảnh -->
					<div class="col-md-4 text-center">
						<img class="img-fluid" src="${urlImg}${animal.animalImage}" alt="Hình ảnh động vật" />
					</div>
				</div>
			</div>
		</div>
	</div>

</div>

<style>
	table th, table td {
		text-align: center;
		vertical-align: middle;
	}

	img.img-fluid {
		border: 2px solid #ddd;
		border-radius: 10px;
		padding: 5px;
		background-color: #f9f9f9;
	}
</style>
