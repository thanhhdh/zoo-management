<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="dec"
	uri="http://www.opensymphony.com/sitemesh/decorator"%>

<c:url var="postURL" value="/auth/login"></c:url> 


<!DOCTYPE html>
<html lang="en">

<head>
    <!-- Required meta tags -->
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <title>Đăng Nhập Vào Hệ Thống Quản Trị</title>
    <!-- plugins:css -->
    
    <link rel="stylesheet" href="<c:url value='/template/admin/assets/vendors/mdi/css/materialdesignicons.min.css'/>">
    <link rel="stylesheet" href="<c:url value='/template/admin/assets/vendors/css/vendor.bundle.base.css'/>">
    <!-- endinject -->
    <!-- Plugin css for this page -->
    <!-- End plugin css for this page -->
    <!-- inject:css -->
    <!-- endinject -->
    <!-- Layout styles -->
    <link rel="stylesheet" href="<c:url value='/template/admin/assets/css/style.css'/>">
    <!-- End layout styles -->
    <link rel="shortcut icon" href=" {{ asset('public/backend/assets/images/favicon.ico') }}" />
    <link rel="stylesheet" href="<c:url value='/template/admin/assets/images/favicon.ico'/>">
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.1/jquery.min.js"
        integrity="sha512-aVKKRRi/Q/YV+4mjoKBsE4x3H+BkegoM/em46NNlCqNTmUYADjBbeNefNxYV7giUp0VxICtqdrbqU7iVaeZNXA=="
        crossorigin="anonymous" referrerpolicy="no-referrer"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/toastr.min.js"></script>
    <script>
        function message_toastr(type, content) {
            Command: toastr[type](content)
            toastr.options = {
                "closeButton": true,
                "debug": true,
                "newestOnTop": false,
                "progressBar": true,
                "positionClass": "toast-top-right",
                "preventDuplicates": true,
                "showDuration": "300",
                "hideDuration": "1000",
                "timeOut": "5000",
                "extendedTimeOut": "1000",
                "showEasing": "swing",
                "hideEasing": "linear",
                "showMethod": "fadeIn",
                "hideMethod": "fadeOut"
            }
        }
    </script>
</head>


<style>
    @font-face {
        font-family: nhanf;
        src: url({{ asset('<c:url value='/template/admin/assets/fonts/Mt-Regular.otf'/>') }});
        font-display: swap;
    }
</style>

<body>

<div class="container-scroller">
	<div class="container-fluid page-body-wrapper full-page-wrapper">
		<div class="content-wrapper d-flex align-items-center auth">
			<div class="row flex-grow">
				<div class="col-lg-4 mx-auto">
					<div class="auth-form-light text-left p-5">
						<div class="brand-logo">
							<img src="<c:url value='/template/admin/assets/images/logo.svg'/>">
						</div>
						<h4>Chào Mừng Quản Trị Viên Đến Với Hệ Thống !</h4>
						<h6 class="font-weight-light">Đăng Nhập Tài Khoản Quản Trị Để
							Tiếp Tục.</h6>
						<form class="pt-3"
							action="${postURL}"
							method="post">
							<div class="form-group">
								<input type="text" name="username"
									class="form-control form-control-lg" id="exampleInputEmail"
									placeholder="username" value="">
							</div>
							<div class="form-group">
								<input type="password" name="password"
									class="form-control form-control-lg" id="exampleInputPassword"
									placeholder="password" value="">
							</div>
							
							<div class="mt-3">
								<input type="submit"
									class="btn btn-block btn-gradient-primary btn-lg font-weight-medium auth-form-btn"
									value="Đăng nhập">
							</div>
							<div
								class="my-2 d-flex justify-content-between align-items-center">
								<div class="form-check">
									<label class="form-check-label text-muted"> <input
										type="checkbox" class="form-check-input" name="SaveLoginCooke"
										value="ON">Lưu Phiên Đăng Nhập
									</label>
								</div>
								<a href="#" style="text-decoration: none;"
									class="auth-link text-black ">Bạn Quên Mật Khẩu?</a>
							</div>
						</form>
					</div>
				</div>
			</div>
		</div>
		<!-- content-wrapper ends -->
	</div>
	<!-- page-body-wrapper ends -->
</div>

    <!-- container-scroller -->
    <!-- plugins:js -->
    <script src="<c:url value='/template/admin/assets/vendors/js/vendor.bundle.base.js'/>"></script>
    <!-- endinject -->
    <!-- Plugin js for this page -->
    <!-- End plugin js for this page -->
    <!-- inject:js -->
    <script src="<c:url value='/template/admin/assets/js/off-canvas.js'/>"></script>
    <script src="<c:url value='/template/admin/assets/js/hoverable-collapse.js'/>"></script>
   	<script src="<c:url value='/template/admin/assets/js/misc.js'/>"></script>
    <!-- endinject -->
    <!-- <script src="https://www.google.com/recaptcha/api.js" async defer></script> -->

</body>

</html>