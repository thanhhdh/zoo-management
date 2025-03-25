<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="/common/taglib.jsp"%>

<c:url var="postURL" value="/admin/supplier/save"></c:url>

<div class="content-wrapper">
	<div class="page-header">
		<h3 class="page-title">
			<span class="page-title-icon bg-gradient-primary text-white me-2">
				<i class="mdi mdi-crosshairs-gps"></i>
			</span> Thêm Nhà Cung Cấp
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
					modelAttribute="supplier" action="${postURL}" method="post"
					enctype="multipart/form-data">

					<div class="form-group">
						<label for="supplierName">Tên Nhà Cung Cấp <span style="color: red;">(*)</span></label> <input
							name="supplierName" type="text" class="form-control"
							id="supplierName" placeholder="Tên Nhà Cung Cấp"> <span
							class="form-message text-danger"></span>
						<s:errors path="supplierName" cssStyle="font-size: small; color: red"/>
					</div>

					<div class="form-group">
						<label for="supplierPhone">Số Điện Thoại <span style="color: red;">(*)</span></label> <input
							name="supplierPhone" type="text" class="form-control"
							id="supplierPhone" placeholder="Số Điện Thoại Nhà Cung Cấp">
						<span class="form-message text-danger"></span>
						<s:errors path="supplierPhone" cssStyle="font-size: small; color: red"/>
					</div>

					<div class="form-group">
						<label for="supplierEmail">Email Liên Hệ <span style="color: red;">(*)</span></label> <input
							name="supplierEmail" type="text" class="form-control"
							id="supplierEmail" placeholder="Email"> <span
							class="form-message text-danger"></span>
						<s:errors path="supplierEmail" cssStyle="font-size: small; color: red"/>
					</div>

					<div class="form-group">
						<label for="supplierAddress">Địa Chỉ <span style="color: red;">(*)</span></label>
						<textarea name="supplierAddress" class="form-control"
							id="supplierAddress" placeholder="Địa Chỉ" rows="5"></textarea>
						<span class="form-message text-danger"></span>
						<s:errors path="supplierAddress" cssStyle="font-size: small; color: red"/>
					</div>

					<div class="form-group">
						<label for="supplierDesc">Mô Tả <span style="color: red;">(*)</span></label>
						<textarea name="supplierDesc" class="form-control"
							id="supplierDesc" placeholder="Mô Tả" rows="10"></textarea>
						<span class="form-message text-danger"></span>
						<s:errors path="supplierDesc" cssStyle="font-size: small; color: red"/>
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
        	message_toastr( type, message, "Thông Báo");
        </c:if>
    });
</script>
