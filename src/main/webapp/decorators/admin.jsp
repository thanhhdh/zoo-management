<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="dec"
	uri="http://www.opensymphony.com/sitemesh/decorator"%>

<!DOCTYPE html>
<html lang="en">
<head>
<!-- Required meta tags -->
<meta charset="utf-8">
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">
<title>Zoo Management</title>
<!--bootstrap -->
<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.2/css/bootstrap.min.css">
<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
<script
	src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.2/js/bootstrap.min.js"></script>

<!-- plugins:css -->
<link rel="stylesheet"
	href="<c:url value='/template/admin/assets/vendors/mdi/css/materialdesignicons.min.css'/>">
<link rel="stylesheet"
	href="<c:url value='/template/admin/assets/vendors/css/vendor.bundle.base.css'/>">
<!-- endinject -->
<!-- Plugin css for this page -->
<!-- End plugin css for this page -->
<!-- inject:css -->
<!-- endinject -->
<!-- Layout styles -->
<link rel="stylesheet"
	href="<c:url value='/template/admin/assets/css/style.css'/>">
<!-- End layout styles -->
<link rel="shortcut icon"
	href="<c:url value='/template/admin/assets/images/images.png'/>" />
<!-- Validator -->
<script src="<c:url value='/template/admin/assets/js/validator.js'/>"></script>

<!-- Ngày -->
<link rel="stylesheet"
	href="//code.jquery.com/ui/1.12.1/themes/smoothness/jquery-ui.css">

<!--  Toastr Css -->
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/toastr.min.css">
<!--  Js Toast -->
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/toastr.min.js"></script>
<!--  moment -->
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.29.1/moment.min.js"></script>
<!--  sweetalert -->
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

	<script>
	function message_toastr(type, content) {
		toastr.options = {
			"closeButton" : true,
			"debug" : true,
			"newestOnTop" : false,
			"progressBar" : true,
			"positionClass" : "toast-top-right",
			"preventDuplicates" : true,
			"showDuration" : "300",
			"hideDuration" : "1000",
			"timeOut" : "5000",
			"extendedTimeOut" : "1000",
			"showEasing" : "swing",
			"hideEasing" : "linear",
			"showMethod" : "fadeIn",
			"hideMethod" : "fadeOut"
		};
		toastr[type](content);
	}
</script>

<style>
	.navbar-dropdown {
		position: absolute; /* Giúp dropdown tách biệt */
	}


</style>

</head>
<body>
	<div class="container-scroller">
		<!-- partial:partials/_navbar.html -->
		<!-- header -->
		<%@include file="/common/admin/header.jsp"%>
		<!-- endheader -->
		<!-- partial -->
		<div class="container-fluid page-body-wrapper">
			<!-- partial:partials/_sidebar.html -->
			<!-- menu -->
			<%@include file="/common/admin/menu.jsp"%>
			<!-- endmenu -->
			<!-- partial -->
			<security:authorize access="hasAnyRole('ROLE_ADMIN','ROLE_MANAGER','ROLE_EMPLOYEE')">

			<div class="main-panel">

				<dec:body />

			</div>
			</security:authorize>
			<security:authorize access="!hasAnyRole('ROLE_ADMIN','ROLE_MANAGER','ROLE_EMPLOYEE')">
				<c:redirect url="/auth/login"/>
			</security:authorize>
			<!-- main-panel ends -->
		</div>
		<!-- Delete Confirmation Modal -->
		<div class="modal fade" id="deleteModal" tabindex="-1" role="dialog"
			aria-labelledby="deleteModalLabel" aria-hidden="true">
			<div class="modal-dialog" role="document">
				<div class="modal-content">
					<div class="modal-body text-center">
						<i class="mdi mdi-alert-circle-outline"
							style="font-size: 4rem; color: #FFA500;"></i>
						<h4 class="modal-title mt-3" id="deleteModalLabel">Bạn có chắc chắn không?</h4>
						<p class="mt-2">Bạn sẽ không thể hoàn tác điều này!</p>
					</div>
					<div class="modal-footer justify-content-center">
						<button type="button" id="confirmDelete" class="btn btn-danger">Đồng ý!</button>
						<button type="button" class="btn btn-secondary"
							data-bs-dismiss="modal">Hủy</button>
					</div>
				</div>
			</div>
		</div>
		<!-- page-body-wrapper ends -->
	</div>
	<!-- container-scroller -->
	<!-- plugins:js -->
	<script
		src="<c:url value='/template/admin/assets/vendors/js/vendor.bundle.base.js'/>"></script>
	<!-- endinject -->
	<!-- Plugin js for this page -->
	<script
		src="<c:url value='/template/admin/assets/vendors/chart.js/Chart.min.js'/>"></script>
	<script
		src="<c:url value='/template/admin/assets/js/jquery.cookie.js'/>"
		type="text/javascript"></script>
	<!-- End plugin js for this page -->
	<!-- inject:js -->
	<script src="<c:url value='/template/admin/assets/js/off-canvas.js'/>"></script>
	<script
		src="<c:url value='/template/admin/assets/js/hoverable-collapse.js'/>"></script>
	<script src="<c:url value='/template/admin/assets/js/misc.js'/>"></script>
	<!-- endinject -->
	<!-- Custom js for this page -->
	<script src="<c:url value='/template/admin/assets/js/dashboard.js'/>"></script>
	<script src="<c:url value='/template/admin/assets/js/todolist.js'/>"></script>
	<!-- End custom js for this page -->

	<!-- Ngày -->
	<script src="//code.jquery.com/jquery-1.12.4.js"></script>
	<script src="//code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
	<!-- End ngày -->

	<!--   Pagination  -->
	<script
		src="<c:url value='/template/admin/assets/js/jquery.twbsPagination.js'/>"></script>
	<!--   Endpagination  -->




	<script>
		$("#datepicker_start").datepicker({
			numberOfMonths : 1,
			dateFormat : 'yy/mm/dd',
			onSelect : function(selectdate) {
				var dt = new Date(selectdate);
				dt.setDate(dt.getDate() + 1)
				$("#datepicker_end").datepicker("option", "minDate", dt);
			}
		});

		$("#datepicker_end").datepicker({
			numberOfMonths : 1,
			dateFormat : 'yy/mm/dd',
			onSelect : function(selectdate) {
				var dt = new Date(selectdate);
				dt.setDate(dt.getDate() - 1)
				$("#datepicker_start").datepicker("option", "maxDate", dt);
			}
		});
	</script>


</body>
</html>
