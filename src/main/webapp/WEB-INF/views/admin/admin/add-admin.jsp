 <%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="dec"
	uri="http://www.opensymphony.com/sitemesh/decorator"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>

<c:url var="postURL" value="/admin/account-admin/save"></c:url>

<div class="content-wrapper">
	<div class="page-header">
		<h3 class="page-title">
			<span class="page-title-icon bg-gradient-primary text-white me-2">
				<i class="mdi mdi-crosshairs-gps"></i>
			</span> Quản Lý Tài Khoản Admin
		</h3>
		<nav aria-label="breadcrumb">
			<ul class="breadcrumb">
				<li class="breadcrumb-item active" aria-current="page"><i
					class="mdi mdi-timetable"></i> <span></span></li>
			</ul>
		</nav>
	</div>

	<div class="col-12 grid-margin stretch-card">
		<div class="card">
			<div class="card-body">

				<c:choose>
					<c:when test="${empty accountAdmin.id}">
						<h4 style="margin-top: -15px" class="card-title">Thêm Mới Tài Khoản</h4>
					</c:when>
					<c:otherwise>
						<h4 style="margin-top: -15px" class="card-title">Chỉnh Sửa Tài Khoản</h4>
					</c:otherwise>
				</c:choose>

				<form:form id="formSubmit" action="${postURL}" method="post"
						   enctype="multipart/form-data" modelAttribute="accountAdmin">
					<form:hidden path="id" id="id" />
					<div class="form-group">
						<label for="fullname">Họ Và Tên<span style="color: red;">(*)</span></label>
						<form:input path="fullname" id="fullname" class="form-control"
							type="text" maxlength="20" placeholder="Họ Và Tên" />
						<span class="text-danger form-message"></span>
						<form:errors path="fullname" cssClass="error" cssStyle="color: red; font-size: small"/>
					</div>

					<div class="form-group">
						<label for="username">Tài Khoản<span style="color: red;">(*)</span></label>
						<form:input path="username" id="username" class="form-control"
							type="text" maxlength="20" placeholder="Tài Khoản" />
						<span class="text-danger form-message"></span>
						<form:errors path="username" cssClass="error" cssStyle="color: red; font-size: small"/>
					</div>

					<div class="form-group">
						<label for="email">Email<span style="color: red;">(*)</span></label>
						<form:input path="email" id="email" class="form-control"
							type="text" placeholder="Email" />
						<span class="text-danger form-message"></span>
						<form:errors path="email" cssClass="error" cssStyle="color: red; font-size: small"/>
					</div>

					<c:if test="${empty accountAdmin.id}">
						<div class="form-group">
							<label for="password">Mật Khẩu<span style="color: red;">(*)</span></label>
							<form:input path="password" id="password" class="form-control"
										type="password" placeholder="Password" />
							<span class="text-danger form-message"></span>
							<form:errors path="password" cssClass="error" cssStyle="color: red; font-size: small"/>
						</div>

						<div class="form-group">
							<label for="password1">Nhập Lại Mật Khẩu<span style="color: red;">(*)</span></label>
							<input id="password1" class="form-control" type="password"
								   name="password1" placeholder="Nhập lại mật khẩu">
							<span class="text-danger form-message"></span>
						</div>
					</c:if>

					<div class="form-group">
						<label>Quyền Hạn Tài Khoản<span style="color: red;">(*)</span></label>
						<div class="col-md-6">
							<div class="form-group">
								<div class="form-check">
									<label class="form-check-label"> <form:radiobutton
											path="typeRole" class="form-check-input" id="roleAdmin"
											value="1" checked="true" /> Admin
									</label>
								</div>
								<div class="form-check">
									<label class="form-check-label"> <form:radiobutton
											path="typeRole" class="form-check-input" id="roleManager"
											value="2" /> Manager
									</label>
								</div>
								<div class="form-check">
									<label class="form-check-label"> <form:radiobutton
											path="typeRole" class="form-check-input" id="roleEmployee"
											value="3" /> Employee
									</label>
								</div>
							</div>
						</div>
					</div>

					<button type="submit" id="click-submit"
						class="btn btn-gradient-primary me-2 form-submit">Xác
						Nhận</button>
				</form:form>
			</div>
		</div>
	</div>
</div>

<script>

	Validator({
		form: '#formSubmit',
		errorSelector: '.form-message',
		rules: [
			Validator.isRequired('#fullname', 'Vui lòng nhập trường này'),
			Validator.isRequired('#username', 'Vui lòng nhập trường này'),
			Validator.isRequired('#email', 'Vui lòng nhập trường này'),
			Validator.isEmail('#email', 'Hãy nhập địa chỉ email hợp lệ'),
			// Chỉ thêm kiểm tra mật khẩu nếu trường tồn tại
			$('#password').length && Validator.isRequired('#password', 'Vui lòng nhập trường này'),
			$('#password1').length && Validator.isRequired('#password1', 'Vui lòng nhập trường này')
		]
	});
	
	  $(document).ready(function() {
		    $('#click-submit').click(function(event) {
		      event.preventDefault();
		      if ($('#fullname').val() === '' ||
		          $('#username').val() === '' ||
		          $('#email').val() === '' ||
		          $('#password').val() === '' ||
		          $('.form-message').text() !== '') {
		        	message_toastr("warning", "Dữ liệu nhập vào không hợp lệ!");
		      } else {
		        Swal.fire({
		          title: "Bạn có muốn lưu lại không?",
		          showDenyButton: true,
		          showCancelButton: true,
		          confirmButtonText: "Lưu",
		          denyButtonText: `Không lưu`
		        }).then((result) => {
		          if (result.isConfirmed) {
		            $("#formSubmit").unbind('submit').submit();
		          } else if (result.isDenied) {
		            message_toastr("info", "Đã hủy bỏ!");
		          }
		        });
		      }
		    });
		  });
	  
</script>
