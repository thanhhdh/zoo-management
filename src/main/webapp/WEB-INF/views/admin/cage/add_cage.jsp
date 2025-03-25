<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="/common/taglib.jsp"%>

<c:url var="postURL" value="/admin/cage/save"></c:url>

<div class="col-lg-12 stretch-card">
	<div class="content-wrapper">
		<div class="page-header">
			<h3 class="page-title">
				<span class="page-title-icon bg-gradient-primary text-white me-2">
					<i class="mdi mdi-crosshairs-gps"></i>
				</span> Thêm Chuồng
			</h3>
			<nav aria-label="breadcrumb">
				<ul class="breadcrumb">
					<li class="breadcrumb-item active" aria-current="page"><i
						class="mdi mdi-timetable"></i> <span></span></li>
				</ul>
			</nav>
		</div>
		<div class="row">
			<div class="col-md-12 grid-margin stretch-card">
				<div class="card">
					<div class="card-body">
						<s:form class="forms-sample" id="form-category"
							modelAttribute="cage" action="${postURL}" method="post"
							enctype="multipart/form-data">
							<div class="form-group">
								<label for="exampleInputUsername1">Tên Chuồng <span style="color: red;">(*)</span></label> <input
									name="cageName" type="text" class="form-control"
									id="name_category" placeholder="Điền tên chuồng"> <span
									class="form-message text-danger"></span>
								<s:errors path="cageName" cssStyle="font-size: small; color: red"/>
							</div>

							<div class="form-group">
								<label for="exampleInputUsername1">Chọn khu vực chuồng <span style="color: red;">(*)</span></label>
								<select name="areaId" class="form-control" id="exampleInputUsername1">
									<c:forEach var="item" items="${areas}">
										<option value="${item.id}"
												<c:choose>
													<c:when test="${(item.maxCapacity - item.currentCages) == 0 || item.areaStatus == 0}">
														disabled style="color: red;"
													</c:when>
												</c:choose>>
											<c:choose>
												<c:when test="${item.areaStatus == 0}">
													${item.areaName} (Đang bảo trì)
												</c:when>
												<c:otherwise>
													${item.areaName} (Số chuồng còn lại: ${item.maxCapacity - item.currentCages})
												</c:otherwise>
											</c:choose>
										</option>
									</c:forEach>
								</select>
								<s:errors path="cageArea" cssStyle="font-size: small; color: red"/>
							</div>

							<div class="form-group">
								<label for="exampleInputUsername1">Mô Tả Chuồng <span style="color: red;">(*)</span></label>
								<Textarea name="cageDesc" class="form-control"
									id="name_category" placeholder="Điền mô tả" rows="10"></Textarea>
								<span class="form-message text-danger"></span>
								<s:errors path="cageDesc" cssStyle="font-size: small; color: red"/>

							</div>
							<div class="form-group">
								<label for="exampleInputUsername1">Sức chứa chuồng</label> <input
									name="cageCapacity" type="number" value="0" min="0" class="form-control"
									id="name_category" placeholder="Dung Tích Chuồng"> <span
									class="form-message text-danger"></span>
							</div>
							<div class="form-group">
								<label for="exampleInputEmail1">Hiển thị</label>
								<div>
									<select name="cageStatus" id="" class="form-control"
										id="exampleInputUsername1">
										<option value="1">Hiển thị</option>
										<option value="0">Ẩn</option>
									</select>
								</div>
							</div>

							<button type="submit"
								class="btn btn-gradient-primary me-2 add-category">Thêm</button>
							<button class="btn btn-light">Thoát</button>
						</s:form>
					</div>
				</div>
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