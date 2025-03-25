<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="/common/taglib.jsp"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:url var="postURL" value="/admin/medical/update" />

<div class="content-wrapper">
	<div class="page-header">
		<h3 class="page-title">
			<span class="page-title-icon bg-gradient-primary text-white me-2">
				<i class="mdi mdi-crosshairs-gps"></i>
			</span> Cập Nhật Hồ Sơ Y Tế
		</h3>
		<nav aria-label="breadcrumb">
			<ul class="breadcrumb">
				<li class="breadcrumb-item active" aria-current="page">
					<a href="/zooproject/admin/animal/list">Danh Sách Động Vật</a>
				<li class="breadcrumb-item active" aria-current="page">Cập Nhật Hồ Sơ Y Tế</li>
				</li>
			</ul>
		</nav>
	</div>

	<div class="col-md-12 grid-margin stretch-card">
		<div class="card">
			<div class="card-body">
				<!-- Form cập nhật hồ sơ y tế -->
				<form class="forms-sample" action="${postURL}" method="post" enctype="multipart/form-data">
					<!-- Input hidden chứa giá trị ID -->
					<input type="hidden" name="medicalId" value="${medical.medicalId}" />
					<input type="hidden" name="animal.animalId" value="${medical.animal.animalId}" />


					<div class="form-group">
						<label for="medicalName">Tên Hồ Sơ</label>
						<input name="medicalName" type="text" value="${medical.medicalName}" class="form-control"
							   placeholder="Điền tên hồ sơ y tế" required />
					</div>

					<div class="form-group">
						<label for="medicalDesc">Mô Tả</label>
						<textarea name="medicalDesc" class="form-control" placeholder="Mô tả hồ sơ y tế" rows="5">${medical.medicalDesc}</textarea>
					</div>

					<div class="form-group">
						<label for="medicalSurgicalHistory">Lịch Sử Phẫu Thuật</label>
						<textarea name="medicalSurgicalHistory" class="form-control" placeholder="Mô tả lịch sử phẫu thuật" rows="5">${medical.medicalSurgicalHistory}</textarea>
					</div>

					<div class="form-group">
						<label for="medicalCheck">Thời Gian Kiểm Tra Định Kỳ</label>
						<input name="medicalCheck" type="text" value="${medical.medicalCheck}" class="form-control"
							   placeholder="Thời gian kiểm tra (VD: 01/12/2024)" />
					</div>

					<div class="form-group">
						<label for="medicalStatus">Trạng Thái</label>
						<select name="medicalStatus" class="form-control">
							<option value="1" ${medical.medicalStatus == 1 ? 'selected' : ''}>Hoàn Thành</option>
							<option value="0" ${medical.medicalStatus == 0 ? 'selected' : ''}>Đang Tiến Hành</option>
						</select>
					</div>

					<!-- Buttons -->
					<button type="submit" class="btn btn-gradient-primary btn-lg">Cập Nhật</button>
					<a href="/zooproject/admin/animal/list" class="btn btn-light btn-lg">
						<i class="mdi mdi-arrow-left"></i> Quay Lại
					</a>
				</form>
			</div>
		</div>
	</div>
</div>

<script type="text/javascript">
	$(document).ready(function() {
		<c:if test="${not empty message}">
		var message = "${message.message}";
		var type = "${message.type}";
		message_toastr(type, message, "Thông Báo");
		</c:if>
	});
</script>

