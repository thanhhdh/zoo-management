<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/common/taglib.jsp"%>
<!-- Bootstrap CSS -->
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css"
	rel="stylesheet">
<<style>
body {
    background-color: #e2e4e7;
}
</style>

<div class="row gx-lg-5 gx-md-4 gx-2 justify-content-center mt-5 mb-5" style="margin: 0px">
	<div class="col-12 col-md-10 col-lg-6 p-3 p-md-5 p-lg-5 card mt-5">
		<div class="">

			<s:form class="form-info-shipping" modelAttribute="infor"
					action="/zooproject/thong-tin-ca-nhan" method="POST"
				enctype="multipart/form-data">
				<div class="mb-3">
					<h4 class="form-title text-center">Nhập Thông Tin Của Bạn</h4>
				</div>
				<div class="row">
					<div class="mb-3 col-md-6">
						<input type="text" class="form-control p-2" id="name_user"
							aria-describedby="emailHelp" name="name"
							placeholder="Tên của quý khách" value="" required> <span
							class="form-message text-danger"></span>
					</div>
					<div class="mb-3 col-md-6">
						<input type="text" class="form-control p-2" id="phone_user"
							aria-describedby="emailHelp" name="phone"
							placeholder="Số điện thoại của quý khách" value="" required>
						<span class="form-message text-danger"></span>
					</div>
				</div>
				<div class="mb-3">
					<input type="text" class="form-control p-2" id="email"
						aria-describedby="emailHelp" name="email"
						placeholder="Nhập Email để xem đơn hàng" required> <span
						class="form-message text-danger"></span>
				</div>
				<div class="mb-3">
					<textarea type="text" rows="5" class="form-control"
						id="exampleInputEmail1" aria-describedby="emailHelp"
						name="note" placeholder="Ghi chú của khách hàng *"></textarea>
				</div>
				<input type="submit" class="btn btn-success text-white w-100 p-2"
					id="submit-info-shipping" value="Xác nhận đơn hàng">
			</s:form>
		</div>
	</div>
</div>






