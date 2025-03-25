<%@page import="java.time.DayOfWeek"%>
<%@page import="java.util.Date"%>
<%@include file="/common/taglib.jsp"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:url var="postURL" value="/admin/task/save"></c:url>

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
						<div class="form-group col-2" style="float: right">
							<label for="userSelect">Chọn Nhân Viên</label> <select
								id="userSelect" class="form-control">
							<option value="">--Chọn Nhân Viên--</option>
							<c:forEach var="item" items="${user}">
								<option value="${item.id}"
										<c:if test="$param.userId == item.id">
											selected="selected"
										</c:if>>
										${item.fullname}
								</option>
							</c:forEach>
						</select>
						</div>

						<%-- Loop through 4 weeks --%>
						<%
						for (int week = 0; week < 4; week++) {
							LocalDate weekStart = monday.plusDays(week * 7);
						%>

						<h4 class="week-heading" style="margin-top: 30px;">
							Tuần
							<%=week + 1%>: từ
							<%=weekStart%>
							đến
							<%=weekStart.plusDays(6)%></h4>

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
									%>
									<td data-shiftId="1" data-date="<%=currentFormattedDate%>"
										class="cell" onclick="openTaskModal(this)"
										ondrop="drop(event)" ondragover="allowDrop(event)">
										<div class="task-container">
											<c:forEach var="item" items="${task}">
												<c:set var="currentFormattedDate" value="<%=currentFormattedDate%>" />
												<c:choose>
													<c:when test="${item.taskShift == 'MORNING' && item.taskDate == currentFormattedDate}">
														<div class="task-item
															 <c:if test='${item.taskStatus == 1}'>completed-task</c:if>
															 <c:if test='${item.taskStatus == 0}'>pending-task</c:if>">
															<span>${item.taskName}</span>
															<a href="/zooproject/admin/task/edit?taskId=${item.id}" title="Edit Task">
																<i class="mdi mdi-pencil" style="color: green; font-size: 1.2rem; margin-left: 10px;"></i>
															</a>
															<a href="/zooproject/admin/task/delete?taskId=${item.id}" title="Delete Task">
																<i class="mdi mdi-delete-forever" style="color: red; font-size: 1.2rem; margin-left: 10px;"></i>
															</a>
														</div>
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
										<i class="mdi mdi-weather-sunset"></i> Chiều</td>
									<%
									for (int i = 0; i < 7; i++) {
										LocalDate currentDate = weekStart.plusDays(i);
										String currentFormattedDate = currentDate.format(formatter);
									%>
									<td data-shiftId="2" data-date="<%=currentFormattedDate%>"
										class="cell" onclick="openTaskModal(this)"
										ondrop="drop(event)" ondragover="allowDrop(event)">
										<div class="task-container">
											<c:forEach var="item" items="${task}">
												<c:set var="currentFormattedDate"
													value="<%=currentFormattedDate%>" />
												<c:choose>
													<c:when
														test="${item.taskShift == 'AFTERNOON' && item.taskDate == currentFormattedDate}">
														<div class="task-item
															 <c:if test='${item.taskStatus == 1}'>completed-task</c:if>
															 <c:if test='${item.taskStatus == 0}'>pending-task</c:if>">
															<span>${item.taskName}</span>
															<a href="/zooproject/admin/task/edit?taskId=${item.id}" title="Edit Task">
																<i class="mdi mdi-pencil" style="color: green; font-size: 1.2rem; margin-left: 10px;"></i>
															</a>
															<a href="/zooproject/admin/task/delete?taskId=${item.id}" title="Delete Task">
																<i class="mdi mdi-delete-forever" style="color: red; font-size: 1.2rem; margin-left: 10px;"></i>
															</a>
														</div>
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
									%>
									<td data-shiftId="3" data-date="<%=currentFormattedDate%>"
										class="cell" onclick="openTaskModal(this)"
										ondrop="drop(event)" ondragover="allowDrop(event)">
										<div class="task-container">
											<c:forEach var="item" items="${task}">
												<c:set var="currentFormattedDate"
													value="<%=currentFormattedDate%>" />
												<c:choose>
													<c:when
														test="${item.taskShift == 'EVENING' && item.taskDate == currentFormattedDate}">
														<div class="task-item
															 <c:if test='${item.taskStatus == 1}'>completed-task</c:if>
															 <c:if test='${item.taskStatus == 0}'>pending-task</c:if>">
															<span>${item.taskName}</span>
															<a href="/zooproject/admin/task/edit?taskId=${item.id}" title="Edit Task">
																<i class="mdi mdi-pencil" style="color: green; font-size: 1.2rem; margin-left: 10px;"></i>
															</a>
															<a href="/zooproject/admin/task/delete?taskId=${item.id}" title="Delete Task">
																<i class="mdi mdi-delete-forever" style="color: red; font-size: 1.2rem; margin-left: 10px;"></i>
															</a>
														</div>
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

						<button type="submit"
							class="btn btn-gradient-primary me-2 add-category">Thêm</button>
						<button type="button" class="btn btn-light"
							onclick="window.location.href='/'">Thoát</button>

					</div>
				</div>
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
	$(document).ready(
			function() {
				// Sự kiện click chuột trái để highlight ô (chỉ một ô được highlight)
				$(".cell").on("click", function(e) {
					if (e.button === 0) { // Nếu là chuột trái
						// Bỏ highlight tất cả các ô khác
						$(".cell").removeClass("highlighted");
						// Highlight ô được click
						$(this).addClass("highlighted");
					}
				});

				// Sự kiện click chuột phải để hiển thị modal
				$(".cell").on("contextmenu", function(e) {
					if ($(this).hasClass("highlighted")) {
						e.preventDefault(); // Ngăn chặn menu ngữ cảnh mặc định
						$('#shiftModal').modal('show');

						// Lấy giá trị từ các thẻ <option> bên trong .task-container
						var optionValue = $(this).find("option").val();

						// Kiểm tra nếu có giá trị trong option thì gọi hàm showTaskDetails()
						if (optionValue) {
							showTaskDetails(optionValue);
						}

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
				});
				// /admin/task/details?id=${taskId}
				function showTaskDetails(taskId) {
					$.ajax({
						url : '/zooproject/admin/task/details?id=' + taskId,
						type : 'GET',
						success : function(data) {
							console.log(data)
							$('#shiftModal').find("input#foodName").val(
									data.food.foodName)
							$('#shiftModal').find("input#cageName").val(
									data.cage.cageName)
							$('#shiftModal').find("input#taskName").val(
									data.taskName)
							$('#shiftModal').find("input#taskDesc").val(
									data.taskDesc)
							$('#shiftModal').find("input#quantity").val(
									data.quantity)
							$('#shiftModal').find("select#taskStatus").val(
									data.taskStatus);

						},
						error : function(xhr, status, error) {
							alert("Loi roi thang ngu" + error)
						}
					})
				}

				// Filter select by User
				var userId = new URLSearchParams(window.location.search).get('userId');
				if(userId) {
					$('#userSelect').val(userId);
				}
				$('#userSelect').on('change', function() {
					var userId = $(this).val();
					var url = '/zooproject/admin/task/list-task-ad';

					if (userId) {
						// Nếu chọn userId thì thêm vào URL
						url += '?userId=' + userId;
					}
					// Điều hướng đến URL tương ứng
					window.location.href = url;
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
		align-items: center;
	}

	.task-item {
		margin-bottom: 5px; /* Tạo khoảng cách giữa các task */
		padding: 3px;
		background-color: #f0f0f0; /* Màu nền nhẹ cho task */
		border-radius: 3px;
		font-size: 14px; /* Kích thước chữ cho task */
	}

	.pending-task {
		background-color: #f8d7da; /* Màu đỏ nhạt */
		color: #721c24;
		padding: 10px;
		border-radius: 5px;
	}

	/* Task đã hoàn thành (Completed) */
	.completed-task {
		background-color: #d4edda; /* Màu xanh nhạt */
		color: #155724;
		padding: 10px;
		border-radius: 5px;
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
