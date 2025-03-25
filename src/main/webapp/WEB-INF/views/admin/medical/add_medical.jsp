<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="/common/taglib.jsp"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:url var="postURL" value="/admin/medical/save" />

<div class="content-wrapper">
	<div class="page-header">
		<h3 class="page-title">
			<span class="page-title-icon bg-gradient-primary text-white me-2">
				<i class="mdi mdi-crosshairs-gps"></i>
			</span> Thêm Hồ Sơ Y Tế
		</h3>
		<nav aria-label="breadcrumb">
			<ul class="breadcrumb">
				<li class="breadcrumb-item active" aria-current="page"><i class="mdi mdi-timetable"></i> Quản Lý Hồ Sơ</li>
			</ul>
		</nav>
	</div>

	<div class="col-md-12 grid-margin stretch-card">
		<div class="card">
			<div class="card-body">
				<!-- Form thêm hồ sơ y tế -->
				<form class="forms-sample" action="${postURL}" method="post" enctype="multipart/form-data">
					<!-- Input hidden chứa giá trị ID -->
					<input type="hidden" name="animal.animalId" value="${param.animalId}" />

					<div class="form-group">
						<label for="medicalName">Tên Hồ Sơ</label>
						<input name="medicalName" type="text" class="form-control" placeholder="Điền tên hồ sơ y tế" required />
					</div>

					<div class="form-group">
						<label for="medicalDesc">Mô Tả</label>
						<textarea name="medicalDesc" class="form-control" placeholder="Mô tả hồ sơ y tế" rows="5"></textarea>
					</div>

					<div class="form-group">
						<label for="medicalSurgicalHistory">Lịch Sử Phẫu Thuật</label>
						<textarea name="medicalSurgicalHistory" class="form-control" placeholder="Mô tả lịch sử phẫu thuật" rows="5"></textarea>
					</div>

					<div class="form-group">
						<label for="medicalCheck">Thời Gian Kiểm Tra Định Kỳ</label>
						<input name="medicalCheck" id="datepicker_start"  type="text" class="form-control" placeholder="Thời gian kiểm tra (VD: 01/12/2024)" />
					</div>

					<div class="form-group">
						<label for="medicalStatus">Trạng Thái</label>
						<select name="medicalStatus" class="form-control">
							<option value="1">Hoàn Thành</option>
							<option value="0">Đang Tiến Hành</option>
						</select>
					</div>

					<!-- Buttons -->
					<button type="submit" class="btn btn-gradient-primary btn-lg">Thêm</button>
					<a href="/zooproject/admin/animal/list" class="btn btn-light btn-lg">
						<i class="mdi mdi-arrow-left"></i> Quay Lại
					</a>
				</form>
			</div>
		</div>
	</div>
</div>

