<%@page import="java.time.DayOfWeek"%>
<%@page import="java.util.Date"%>
<%@include file="/common/taglib.jsp"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:url var="postURL" value="/admin/task/save"></c:url>

<c:url var="importExcelURL" value="/admin/task/import"></c:url>

<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page import="java.time.format.DateTimeFormatter"%>
<%@page import="java.time.LocalDate"%>

<%
LocalDate today = LocalDate.now();
DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd"); // Định dạng ngày
String formattedDate = today.format(formatter); // Chuyển đổi ngày thành chuỗi với định dạng mong muốn

DayOfWeek firstDayOfWeek = DayOfWeek.MONDAY;
DayOfWeek currentDayOfWeek = today.getDayOfWeek();
int daysUntilMonday = (currentDayOfWeek.getValue() - firstDayOfWeek.getValue() + 7) % 7;

LocalDate monday = today.minusDays(daysUntilMonday);
%>

<div class="col-lg-12 stretch-card">
	<div class="content-wrapper">
		<div class="page-header">
			<h3 class="page-title">Lịch Nhân Viên</h3>
		</div>
		<div class="row">
			<div class="col-md-12 grid-margin stretch-card">
				<div class="card">
					<div class="card-body">

						<%-- Loop through 4 weeks --%>
						<%
						for (int week = 0; week < 4; week++) {
							LocalDate weekStart = monday.plusDays(week * 7);
						%>

						<h4 class="week-heading" style="margin-top: 30px;">
							Tuần <%=week + 1%>: từ <%=weekStart.format(DateTimeFormatter.ofPattern("dd/MM/yyyy"))%>
							đến <%=weekStart.plusDays(6).format(DateTimeFormatter.ofPattern("dd/MM/yyyy"))%>
						</h4>

						<!-- Table Schedule -->
						<table id="schedule" class="table text-center table-bordered">
							<tr>
								<th></th>
								<th>Thứ 2 <br /><%=weekStart%></th>
								<th>Thứ 3 <br /><%=weekStart.plusDays(1)%></th>
								<th>Thứ 4 <br /><%=weekStart.plusDays(2)%></th>
								<th>Thứ 5 <br /><%=weekStart.plusDays(3)%></th>
								<th>Thứ 6 <br /><%=weekStart.plusDays(4)%></th>
								<th>Thứ 7 <br /><%=weekStart.plusDays(5)%></th>
								<th>Chủ nhật <br /><%=weekStart.plusDays(6)%></th>
							</tr>
							<tbody>
							<%-- MORNING SHIFT --%>
							<tr>
								<td class="cell fw-bold">
									<i class="mdi mdi-white-balance-sunny"></i> Sáng
								</td>
								<%
									for (int i = 0; i < 7; i++) {
										LocalDate currentDate = weekStart.plusDays(i);
										String currentFormattedDate = currentDate.format(formatter); // Định dạng ngày cho mỗi ô

										// Kiểm tra xem ngày đã qua hay chưa (không bao gồm ngày hôm nay)
										boolean isPastDate = currentDate.isBefore(today); // Chỉ những ngày trước hôm nay mới bị vô hiệu hóa
								%>
								<td data-shiftId="1" data-date="<%=currentFormattedDate%>"
									class="cell"
										<%= isPastDate ? "style='background-color: #f0f0f0; cursor: not-allowed;' ondrop='return false;' ondragover='return false;'" : "ondrop='drop(event)' ondragover='allowDrop(event)'" %>>
									<div class="task-container">
										<c:forEach var="item" items="${task}">
											<c:set var="currentFormattedDate" value="<%=currentFormattedDate%>" />
											<c:choose>
												<c:when test="${item.taskShift == 'MORNING' && item.taskDate == currentFormattedDate}">
													<option value="${item.id}">${item.taskName}</option>
												</c:when>
											</c:choose>
										</c:forEach>
									</div>
								</td>
								<%
									} // Kết thúc vòng lặp for
								%>
							</tr>

							<%-- AFTERNOON SHIFT --%>
							<tr>
								<td class="cell fw-bold">
									<i class="mdi mdi-weather-sunset"></i> Chiều
								</td>
								<%
									for (int i = 0; i < 7; i++) {
										LocalDate currentDate = weekStart.plusDays(i);
										String currentFormattedDate = currentDate.format(formatter);
										boolean isPastDate = currentDate.isBefore(today); // Điều kiện giống trên
								%>
								<td data-shiftId="2" data-date="<%=currentFormattedDate%>"
									class="cell"
										<%= isPastDate ? "style='background-color: #f0f0f0; cursor: not-allowed;' ondrop='return false;' ondragover='return false;'" : "ondrop='drop(event)' ondragover='allowDrop(event)'" %>>
									<div class="task-container">
										<c:forEach var="item" items="${task}">
											<c:set var="currentFormattedDate" value="<%=currentFormattedDate%>" />
											<c:choose>
												<c:when test="${item.taskShift == 'AFTERNOON' && item.taskDate == currentFormattedDate}">
													<option value="${item.id}">${item.taskName}</option>
												</c:when>
											</c:choose>
										</c:forEach>
									</div>
								</td>
								<%
									}
								%>
							</tr>

							<%-- EVENING SHIFT --%>
							<tr>
								<td class="cell fw-bold">
									<i class="mdi mdi-weather-night"></i> Tối
								</td>
								<%
									for (int i = 0; i < 7; i++) {
										LocalDate currentDate = weekStart.plusDays(i);
										String currentFormattedDate = currentDate.format(formatter);
										boolean isPastDate = currentDate.isBefore(today); // Điều kiện giống trên
								%>
								<td data-shiftId="3" data-date="<%=currentFormattedDate%>"
									class="cell"
										<%= isPastDate ? "style='background-color: #f0f0f0; cursor: not-allowed;' ondrop='return false;' ondragover='return false;'" : "ondrop='drop(event)' ondragover='allowDrop(event)'" %>>
									<div class="task-container">
										<c:forEach var="item" items="${task}">
											<c:set var="currentFormattedDate" value="<%=currentFormattedDate%>" />
											<c:choose>
												<c:when test="${item.taskShift == 'EVENING' && item.taskDate == currentFormattedDate}">
													<option value="${item.id}">${item.taskName}</option>
												</c:when>
											</c:choose>
										</c:forEach>
									</div>
								</td>
								<%
									}
								%>
							</tr>
							</tbody>


						</table>

						<%
						}
						%>

					</div>
				</div>
			</div>
		</div>
	</div>
</div>


<div class="modal fade" id="shiftModal" tabindex="-1"
	aria-labelledby="shiftModalLabel" aria-hidden="true">
	<div class="modal-dialog modal-lg">
		<!-- Thay đổi modal-dialog thành modal-lg để mở rộng hơn -->
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="shiftModalLabel">Chi tiết ca làm việc</h5>
				<button type="button" class="btn-close" data-bs-dismiss="modal"
					aria-label="Close"></button>
			</div>
			<div class="modal-body">
				<form class="forms-sample" id="form-category" method="post"
					enctype="multipart/form-data" action="${postURL}">
					<div class="form-container">
						<!-- Container chính -->
						<div class="form-group">
							<label for="taskName">Tên Task</label> <input name="taskName"
								type="text" class="form-control" id="taskName"
								placeholder="Điền tên task">
						</div>
						<div class="form-group">
							<label for="userId">Chọn Nhân Viên</label> <select name="userId"
								class="form-control">
								<c:forEach var="item" items="${user}">
									<option value="${item.id}">${item.fullname}</option>
								</c:forEach>
							</select>
						</div>
						<div class="form-group">
							<label for="cageId">Chọn Chuồng</label> <select name="cageId"
								class="form-control">
								<c:forEach var="item" items="${cages}">
									<c:choose>
										<c:when test="${item.cageStatus == 1}">
											<option value="${item.id}">${item.cageName}</option>
										</c:when>
									</c:choose>
								</c:forEach>
							</select>
						</div>
						<div class="form-group">
							<label for="foodId">Chọn Thức Ăn</label> <select name="foodId"
								class="form-control">
								<c:forEach var="item" items="${foods}">
									<c:choose>
										<c:when test="${item.foodQuantity > 0}">
											<option value="${item.foodId}">${item.foodName}- Còn
												lại: ${item.foodQuantity}</option>
										</c:when>
										<c:when test="${item.foodQuantity == 0}">
											<option value="${item.foodId}" class="food-out-of-stock"
												disabled>${item.foodName}(Cần nhập hàng)</option>
										</c:when>
									</c:choose>
								</c:forEach>
							</select>
						</div>
						<div class="form-group">
							<label for="taskDesc">Mô Tả Task</label>
							<textarea name="taskDesc" class="form-control" id="taskDesc"
								placeholder="Điền mô tả task" rows="10"></textarea>
						</div>

						<div class="form-group">
							<label for="quantity">Số lượng thức ăn</label> <input
								name="quantity" type="number" class="form-control" id="quantity"
								placeholder="Điền số lượng">
						</div>
						<div class="form-group">
							<label for="taskStatus">Trạng Thái Task</label> <select
								name="taskStatus" class="form-control" id="taskStatus">
								<option value="0">Chưa Thực Hiện</option>
								<option value="1">Hoàn Thành</option>
							</select>
						</div>
						<div class="form-group">
							<label for="taskShift">Ca của Task</label> <input
								name="taskShift" type="text" class="form-control" id="taskShift"
								placeholder="Ca của Task">
						</div>
						<div class="form-group">
							<label for="taskDate">Ngày của Task</label> <input
								name="taskDate" type="date" class="form-control" id="taskDate"
								placeholder="Ngày của Task" min="${today}">
						</div>
					</div>
					<div class="form-actions">
						<button type="submit" class="btn btn-primary">Thêm</button>
					</div>
				</form>
			</div>
		</div>
	</div>
</div>

<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script
	src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/5.1.3/js/bootstrap.min.js"></script>
<script>

	document.addEventListener('DOMContentLoaded', function() {
		// Lấy ngày hiện tại và định dạng thành yyyy-mm-dd
		var today = new Date().toISOString().split('T')[0];
		// Gán giá trị cho thuộc tính min của input type date
		document.getElementById("taskDate").setAttribute('min', today);
	});

	$(document).ready(function() {
// Hàm chuẩn hóa thời gian về 00:00:00 để so sánh ngày chính xác
		function normalizeDate(date) {
			return new Date(date.getFullYear(), date.getMonth(), date.getDate());
		}
		// Lấy ngày hiện tại
		var today = normalizeDate(new Date());

		// Sự kiện click chuột trái để highlight ô (chỉ một ô được highlight)
		$(".cell").on("click", function(e) {
			if (e.button === 0) { // Nếu là chuột trái
				// Kiểm tra ngày trong ô có phải là ngày đã qua không
				var taskDate = normalizeDate(new Date($(this).data('date'))); // Lấy ngày từ thuộc tính data-date

				if (taskDate >= today) { // Nếu ngày không phải là ngày đã qua
					// Bỏ highlight tất cả các ô khác
					$(".cell").removeClass("highlighted");
					// Highlight ô được click
					$(this).addClass("highlighted");
				}
			}
		});

		// Sự kiện click chuột phải để hiển thị modal
		$(".cell").on("contextmenu", function(e) {
			var taskDate = normalizeDate(new Date($(this).data('date'))); // Lấy ngày từ thuộc tính data-date

			if (taskDate >= today) { // Nếu ngày không phải là ngày đã qua
				if ($(this).hasClass("highlighted")) {
					e.preventDefault(); // Ngăn chặn menu ngữ cảnh mặc định
					$('#shiftModal').modal('show');

					// Lấy dữ liệu từ thuộc tính `data-shiftId` và `data-date` của ô được chọn
					var shiftId = $(this).data('shiftid');
					var taskDate = $(this).data('date');

					// Gán giá trị cho các input trong modal
					var shiftName = "";
					if (shiftId === 1)
						shiftName = "MORNING";
					else if (shiftId === 2)
						shiftName = "AFTERNOON";
					else if (shiftId === 3)
						shiftName = "EVENING";

					$('#taskShift').val(shiftName);
					$('#taskDate').val(taskDate);
				}
			}
		});
	});
</script>



<style>
.modal-body {
	display: flex;
	flex-wrap: wrap;
	gap: 15px;
	font-size: 16px;
}

.form-group {
	flex: 1;
	min-width: 250px;
}

.highlighted {
	background-color: #007bff !important; /* Blue background color */
	color: white !important; /* White text color */
}

.task-container {
	text-align: center; /* Canh trái */
	display: flex;
	flex-direction: column; /* Sắp xếp theo chiều dọc */
	align-items: center; /* Đảm bảo các task được canh trái */
}

.task-item {
	margin-bottom: 5px; /* Tạo khoảng cách giữa các task */
	padding: 3px;
	background-color: #f0f0f0; /* Màu nền nhẹ cho task */
	border-radius: 3px;
	font-size: 14px; /* Kích thước chữ cho task */
}

.cell {
	vertical-align: top; /* Đảm bảo các task được sắp xếp từ trên xuống */
}

.food-out-of-stock {
	color: red;
	font-weight: bold;
}

.form-message.text-danger {
	color: red;
	font-weight: bold;
}

.form-container {
	display: flex;
	flex-wrap: wrap;
	gap: 20px; /* Khoảng cách giữa các phần tử */
}

.form-group {
	flex: 1 1 45%; /* Điều chỉnh chiều rộng của mỗi phần tử */
	min-width: 200px; /* Đảm bảo các phần tử không quá hẹp */
}

.form-actions {
	margin-top: 20px;
	text-align: center;
}

/*Lich*/
.table {
	border-collapse: separate;
	border-spacing: 0;
	width: 100%;
	border: 1px solid #ddd;
}

.table th, .table td {
	padding: 10px;
	text-align: center;
	vertical-align: middle;
}

.table th {
	background-color: #f8f9fa;
	font-weight: bold;
	border-bottom: 2px solid #dee2e6;
}

.table tr:nth-child(even) {
	background-color: #f9f9f9;
}

.table tr:hover {
	background-color: #f1f1f1;
}

.cell {
	border: 1px solid #dee2e6;
	padding: 15px;
	min-height: 80px;
	position: relative;
}

.task-container {
	margin-top: 5px;
}

.task-container option {
	background-color: #007bff;
	color: white;
	padding: 5px 10px;
	border-radius: 4px;
	cursor: pointer;
}

.week-heading {
	font-size: 18px;
	font-weight: bold;
	margin-bottom: 20px;
}

</style>
