<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="/common/taglib.jsp"%>
<c:url var="postURL" value="/admin/animal/add"></c:url>
<div class="col-lg-12 stretch-card">
	<div class="content-wrapper">
		<div class="page-header">
			<h3 class="page-title">Thêm Động Vật</h3>
		</div>
		<div class="row">
			<div class="col-md-12 grid-margin stretch-card">
				<div class="card">
					<div class="card-body">
						<s:form class="forms-sample" id="form-category"
							modelAttribute="animal" action="${postURL}" method="post"
							enctype="multipart/form-data">
							<div class="form-group">
								<label for="exampleInputUsername1">Tên Động Vật <span style="color: red;">(*)</span></label> <input
									name="animalName" type="text" class="form-control"
									id="name_category" placeholder="Điền tên thể loại"> <span
									class="form-message text-danger"></span>
								<s:errors path="animalName" cssClass="error" cssStyle="color: red; font-size: small"/>
							</div>

							<div class="form-group row">
								<div class="col-md-6">
									<label for="exampleInputUsername1">Chọn Loài </label> <select
										name="specieId" class="form-control"
										id="exampleInputUsername1">
										<c:forEach var="item" items="${species }">
											<c:choose>
												<c:when test="${item.speciesStatus == 1}">
													<option value="${item.id }">${item.speciesName }</option>
												</c:when>
											</c:choose>
										</c:forEach>
									</select>
								</div>
								<div class="col-md-6">
									<label for="exampleInputUsername1">Chọn Chuồng </label> <select
										name="cageId" class="form-control" id="exampleInputUsername1">
										<c:forEach var="item" items="${cages}">
											<c:choose>
												<c:when test="${item.cageStatus == 1}">
													<option value="${item.id }">${item.cageName }</option>
												</c:when>
												<c:when test="${item.cageStatus == 0}">
													<option disabled class="food-out-of-stock" value="${item.id }">${item.cageName } (Chuồng đã đầy)</option>
												</c:when>
											</c:choose>
										</c:forEach>
									</select>
								</div>
							</div>

							<div class="form-group">
								<label for="exampleInputUsername1">Hình Ảnh</label> <input
									name="image" type="file" class="form-control"
									id="image_category"> <span
									class="form-message text-danger"></span>
							</div>

							<div class="form-group row">
								<div class="col-md-6">
									<label for="exampleInputUsername1">Chọn Loại Thức Ăn </label> <select
										name="foodId" class="form-control"
										id="exampleInputUsername1">
										<c:forEach var="item" items="${foods }">
											<c:choose>
												<c:when test="${item.foodQuantity > 1}">
													<option value="${item.foodId }">${item.foodName }</option>
												</c:when>
											</c:choose>
										</c:forEach>
									</select>
								</div>

								<div class="col-md-6">
									<label for="exampleInputUsername1">Tuổi Hiện Tại <span style="color: red;">(*)</span></label> <input
										name="animalAge" type="number" min="1" class="form-control"
										id="name_category" placeholder="Tuổi Hiện Tại"> <span
										class="form-message text-danger"></span>
									<s:errors path="animalAge" cssClass="error" cssStyle="color: red; font-size: small"/>
								</div>
							</div>

							<div class="form-group row">
								<div class="col-md-6">
									<label for="supplierDesc">Sinh Sản <span style="color: red;">(*)</span></label>
									<textarea name="animalReproduction" class="form-control"
										id="supplierDesc" placeholder="Mô Tả" rows="10"></textarea>
									<span class="form-message text-danger"></span>
									<s:errors path="animalReproduction" cssClass="error" cssStyle="color: red; font-size: small"/>

								</div>

								<div class="col-md-6">
									<label for="supplierDesc">Phân Bổ <span style="color: red;">(*)</span></label>
									<textarea name="animalAllocation" class="form-control"
										id="supplierDesc" placeholder="Mô Tả" rows="10"></textarea>
									<span class="form-message text-danger"></span>
									<s:errors path="animalAllocation" cssClass="error" cssStyle="color: red; font-size: small"/>
								</div>
							</div>

							<div class="form-group">
								<label for="exampleInputUsername1">
									Sinh Thái Của Động Vật <span style="color: red;">(*)</span></label>
								<textarea name="animalEcological" class="form-control"
									id="animalEcological" placeholder="Mô Tả" rows="10"></textarea>
								<span class="form-message text-danger"></span>
								<s:errors path="animalEcological" cssClass="error" cssStyle="color: red; font-size: small"/>

							</div>

							<div class="form-group">
								<label for="exampleInputUsername1">Mô Tả <span style="color: red;">(*)</span></label>
								<textarea name="animalDesc" class="form-control"
									id="supplierDesc" placeholder="Mô Tả" rows="10"></textarea>
								<span class="form-message text-danger"></span>
								<s:errors path="animalDesc" cssClass="error" cssStyle="color: red; font-size: small"/>
							</div>


							<!-- Animal Status -->
							<div class="form-group">
								<label for="animalStatus">Trạng Thái</label>
								<div>
									<select name="animalStatus" class="form-control" id="animalStatus">
										<option value="HEALTHY">Khỏe Mạnh</option>
										<option value="SICK">Bệnh</option>
										<option value="IN_QUARANTINE">Cách Ly</option>
										<option value="UNDER_TREATMENT">Đang Điều Trị</option>
									</select>
								</div>
							</div>

							<!-- Origin -->
							<div class="form-group">
								<label for="origin">Nguồn Gốc <span style="color: red;">(*)</span></label>
								<input name="origin" type="text" class="form-control" placeholder="Nguồn Gốc">
								<span class="form-message text-danger"></span>
								<s:errors path="origin" cssClass="error" cssStyle="color: red; font-size: small"/>
							</div>

							<!-- Date of Entry -->
							<div class="form-group">
								<label for="dateOfEntry">Ngày Nhập Chuồng <span style="color: red;">(*)</span></label>
								<input name="dateOfEntry" type="date" class="form-control" placeholder="Ngày Nhập Chuồng" id="dateOfEntry">
								<span class="form-message text-danger"></span>
								<s:errors path="dateOfEntry" cssClass="error" cssStyle="color: red; font-size: small"/>
							</div>

							<button type="submit"
								class="btn btn-gradient-primary me-2 add-category">Thêm</button>
							<button class="btn btn-light" >Thoát</button>
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

<<style>
.food-out-of-stock {
	color: red;
	font-weight: bold;
}
</style>
