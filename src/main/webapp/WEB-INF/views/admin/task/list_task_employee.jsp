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
												<c:set var="currentFormattedDate"
													value="<%=currentFormattedDate%>" />
												<c:choose>
													<c:when
														test="${item.taskShift == 'MORNING' && item.taskDate == currentFormattedDate}">
														<div class="task-item
															 <c:if test='${item.taskStatus == 1}'>completed-task</c:if>
															 <c:if test='${item.taskStatus == 0}'>pending-task</c:if>">
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


<!-- Modal HTML -->
<div class="modal fade" id="shiftModal" tabindex="-1" aria-labelledby="shiftModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="shiftModalLabel">Shift Details</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <c:url var="postURL" value="/admin/task/save"></c:url>
                <s:form class="forms-sample" id="form-category" modelAttribute="task" action="${postURL}" method="post" enctype="multipart/form-data">
                    <div class="row">
                        <div class="col-md-6">
                            <div class="form-group">
                                <label for="taskName">Tên Task</label>
                                <input type="text" disabled class="form-control" id="taskName" placeholder="Tên Task">
                            </div>
                        </div>
                        <div class="col-md-6">
                            <div class="form-group">
                                <label for="cageName">Vị Trí Chuồng</label>
                                <input type="text" disabled class="form-control" id="cageName" placeholder="Vị Trí Chuồng">
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-6">
                            <div class="form-group">
                                <label for="foodName">Thức Ăn</label>
                                <input type="text" disabled class="form-control" id="foodName" placeholder="Thức Ăn">
                            </div>
                        </div>
                        <div class="col-md-6">
                            <div class="form-group">
                                <label for="taskDesc">Mô Tả Task</label>
                                <textarea class="form-control" disabled id="taskDesc" rows="3" placeholder="Mô Tả Task"></textarea>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-6">
                            <div class="form-group">
                                <label for="quantity" >Số Lượng Thức Ăn</label>
                                <input type="text" disabled class="form-control" id="quantity" placeholder="Số Lượng">
                            </div>
                        </div>
						<div class="col-md-6">
							<div class="form-group">
								<label for="taskStatus" >Trạng Thái Task</label>
								<input type="text" disabled class="form-control" id="taskStatus" placeholder="">
							</div>
						</div>

                    </div>
                    <div class="row">
                        <div class="col-md-6">
                            <div class="form-group">
                                <label for="taskShift">Ca của Task</label>
                                <input name="taskShift" disabled type="text" class="form-control" id="taskShift" placeholder="Ca của Task">
                                <span class="form-message text-danger"></span>
                            </div>
                        </div>
                        <div class="col-md-6">
                            <div class="form-group">
                                <label for="taskDate">Ngày của Task</label>
                                <input name="taskDate" disabled type="date" class="form-control" id="taskDate" placeholder="Ngày của Task">
                                <span class="form-message text-danger"></span>
                            </div>
                        </div>
                    </div>
                </s:form>
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
							$('#shiftModal').find("#taskDesc").text(
									data.taskDesc)
							$('#shiftModal').find("input#quantity").val(
									data.quantity)

							let taskStatus = data.taskStatus;
							if (taskStatus === 0) {
								$('#shiftModal').find("input#taskStatus").val("Chưa thực hiện");
							} else if (taskStatus === 1) {
								$('#shiftModal').find("input#taskStatus").val("Hoàn thành");
							}

						},
						error : function(xhr, status, error) {
							alert("Loi roi thang ngu" + error)
						}
					})
				}
			});
</script>



<style>
.modal-body {
	font-size: 20px;
}

.highlighted {
	background-color: #007bff !important; /* Blue background color */
	color: white !important; /* White text color */
}

/*Lich*/

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
	color: #000000;
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
