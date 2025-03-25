<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="/common/taglib.jsp"%>

<c:url var="postURL" value="/admin/species/save"></c:url>

<div class="content-wrapper">
	<div class="page-header">
		<h3 class="page-title">
			<span class="page-title-icon bg-gradient-primary text-white me-2">
				<i class="mdi mdi-crosshairs-gps"></i>
			</span> Thêm Loài
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
					modelAttribute="species" action="${postURL}" method="post"
					enctype="multipart/form-data">

					<div class="form-group">
						<label for="speciesName">Tên Loài <span style="color: red;">(*)</span></label> <input
							name="speciesName" type="text" class="form-control"
							id="speciesName" placeholder="Điền tên thể loại"> <span
							class="form-message text-danger"></span>
						<s:errors path="speciesName" cssStyle="font-size: small; color: red"/>
					</div>

					<div class="form-group">
					<label for="specieDesc">Mô Tả Loài <span style="color: red;">(*)</span></label>
					<textarea name="specieDesc" class="form-control"
										id="specieDesc" placeholder="Mô Tả" rows="10"></textarea>
						<s:errors path="specieDesc" cssStyle="font-size: small; color: red"/>
					</div>

					<div class="form-group">
						<label for="imgage">Hình Ảnh Mô Tả</label> <input
							name="imgage" type="file" class="form-control"
							id="imgage"> <span
							class="form-message text-danger"></span>
					</div>

					<div class="form-group">
						<label for="speciesAllocation">Phân Bổ <span style="color: red;">(*)</span></label>
						<textarea name="speciesAllocation" class="form-control"
										id="speciesAllocation" placeholder="Điền phân bổ loài" rows="10"></textarea>
						<s:errors path="speciesAllocation" cssStyle="font-size: small; color: red"/>

					</div>

					<div class="form-group">
						<label for="speciesReproduction">Sinh Sản <span style="color: red;">(*)</span></label>
						<textarea name="speciesReproduction" class="form-control"
										id="speciesReproduction" placeholder="Sinh sản của loài" rows="10"></textarea>
						<s:errors path="speciesReproduction" cssStyle="font-size: small; color: red"/>
					</div>

					<div class="form-group">
						<label for="speciesEcological">Sinh Thái <span style="color: red;">(*)</span></label>
						<textarea name="speciesEcological" class="form-control"
										id="speciesEcological" placeholder="Sinh thái của loài" rows="10"></textarea>
						<s:errors path="speciesEcological" cssStyle="font-size: small; color: red"/>
					</div>

					<div class="form-group">
						<label for="speciesStatus">Hiển thị</label>
						<div>
							<select name="speciesStatus" id="" class="form-control"
								id="speciesStatus">
								<option value="1">Hiển thị</option>
								<option value="0">Ẩn</option>
							</select>
						</div>
					</div>

					<button type="submit"
						class="btn btn-gradient-primary me-2 add-category">Thêm</button>
					<button class="btn btn-light" >Thoát</button>
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
