<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="/common/taglib.jsp"%>

<c:url var="postURL" value="/admin/food/save"></c:url>

<div class="content-wrapper">
	<div class="page-header">
		<h3 class="page-title">
			<span class="page-title-icon bg-gradient-primary text-white me-2">
				<i class="mdi mdi-crosshairs-gps"></i>
			</span> Thêm Thức Ăn
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
				<s:form class="forms-sample" id="form-category"
					modelAttribute="food" action="${postURL}" method="post"
					enctype="multipart/form-data">

					<div class="form-group">
						<label for="foodName">Tên Thức Ăn <span style="color: red;">(*)</span></label> <input
							name="foodName" type="text" class="form-control"
							id="foodName" placeholder="Tên Thức Ăn"> <span
							class="form-message text-danger"></span>
						<s:errors path="foodName" cssStyle="font-size: small; color: red"/>
					</div>

					<div class="form-group">
						<label for="foodQuantity">Số Lượng (kg)</label> <input
							name="foodQuantity" type="number" class="form-control"
							id="foodQuantity" placeholder="Số Lượng Nhập Vào Kho"> <span
							class="form-message text-danger"></span>
					</div>

					<div class="form-group">
						<label for="nutritionalInfo">Thông Tin Dinh Dưỡng <span style="color: red;">(*)</span></label>
						<textarea name="nutritionalInfo" class="form-control"
							id="nutritionalInfo" placeholder="Thông Tin Dinh Dưỡng" rows="10"></textarea>
						<s:errors path="nutritionalInfo" cssStyle="font-size: small; color: red"/>
					</div>


					<div class="form-group">
						<label for="exampleInputUsername1">Nhà Cung Cấp </label> <select
							name="supplierId" class="form-control" id="exampleInputUsername1">
							<c:forEach var="item" items="${supplier}">
								<option value="${item.supplierId }">${item.supplierName }</option>
							</c:forEach>
						</select>
					</div>

					<div class="form-group row">
						<div class="col-md-6">
							<label for="expirationStart">Năm Sản Xuất <span style="color: red;">(*)</span></label> <input
								name="expirationStart" type="text" class="form-control"
								id="datepicker_start"> <span
								class="form-message text-danger"></span>
							<s:errors path="expirationStart" cssStyle="font-size: small; color: red"/>
						</div>
						<div class="col-md-6">
							<label for="expirationEnd">Hạn Sử Dụng <span style="color: red;">(*)</span></label> <input
								name="expirationEnd" type="text" class="form-control"
								id="datepicker_end"> <span
								class="form-message text-danger"></span>
							<s:errors path="expirationEnd" cssStyle="font-size: small; color: red"/>
						</div>
					</div>

					<div class="form-group">
						<label for="storageRequirements">Yêu Cầu Bảo Quản <span style="color: red;">(*)</span></label>
						<textarea name="storageRequirements" class="form-control"
							id="storageRequirements" placeholder="Mô Tả" rows="10"></textarea>
						<span class="form-message text-danger"></span>
						<s:errors path="storageRequirements" cssStyle="font-size: small; color: red"/>
					</div>

					<button type="submit"
						class="btn btn-gradient-primary me-2 add-category">Thêm</button>
					<button type="button" class="btn btn-light"
						onclick="window.location.href='/admin/supplier/list'">Thoát</button>
				</s:form>
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
