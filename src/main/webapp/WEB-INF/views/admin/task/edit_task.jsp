<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@include file="/common/taglib.jsp"%>
<c:url var="postURL" value="/admin/task/update"></c:url>
<div class="col-lg-12 stretch-card">
    <div class="content-wrapper">
        <div class="page-header">
            <h3 class="page-title">
				<span class="page-title-icon bg-gradient-primary text-white me-2">
					<i class="mdi mdi-crosshairs-gps"></i>
				</span> Chỉnh sửa Task
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
                        <form class="forms-sample" id="form-category" method="post"
                              enctype="multipart/form-data" modelAttribute="task" action="${postURL}">
                            <div class="form-container">
                                <!-- Container chính -->
                                <input type="hidden" name="id" value="${task.id}">
                                <div class="row">
                                    <div class="col-md-6">
                                        <div class="form-group">
                                            <label for="taskName">Tên Task</label>
                                            <input name="taskName" value="${task.taskName}" type="text" class="form-control" id="taskName" placeholder="Điền tên task">
                                        </div>
                                    </div>
                                    <div class="col-md-6">
                                        <div class="form-group">
                                            <label for="userId">Chọn Nhân Viên</label>
                                            <select name="userId" class="form-control">
                                                <c:forEach var="item" items="${user}">
                                                    <option value="${item.id}" ${item.id == task.user.id ? 'selected' : ''}>${item.fullname}</option>
                                                </c:forEach>
                                            </select>
                                        </div>
                                    </div>
                                </div>

                                <div class="row">
                                    <div class="col-md-6">
                                        <div class="form-group">
                                            <label for="cageId">Chọn Chuồng</label>
                                            <select name="cageId" class="form-control">
                                                <c:forEach var="item" items="${cages}">
                                                    <c:if test="${item.cageStatus == 1}">
                                                        <option value="${item.id}" ${item.id == task.cage.id ? 'selected' : ''}>${item.cageName}</option>
                                                    </c:if>
                                                </c:forEach>
                                            </select>
                                        </div>
                                    </div>
                                    <div class="col-md-6">
                                        <div class="form-group">
                                            <label for="foodId">Chọn Thức Ăn</label> <select name="foodId"
                                                                                             class="form-control">
                                            <c:forEach var="item" items="${foods}">
                                                <c:choose>
                                                    <c:when test="${item.foodQuantity > 0}">
                                                        <option value="${item.foodId}" ${item.foodId == task.food.foodId ? 'selected' : ''}>${item.foodName}- Còn
                                                            lại: ${item.foodQuantity}</option>
                                                    </c:when>
                                                    <c:when test="${item.foodQuantity == 0}">
                                                        <option value="${item.foodId}" ${item.foodId == task.food.foodId ? 'selected' : ''} class="food-out-of-stock"
                                                                disabled>${item.foodName}(Cần nhập hàng)</option>
                                                    </c:when>
                                                </c:choose>
                                            </c:forEach>
                                        </select>
                                        </div>
                                    </div>
                                </div>

                                <div class="row">
                                    <div class="col-md-6">
                                        <div class="form-group">
                                            <label for="quantity">Số lượng thức ăn</label> <input
                                                name="quantity" type="number" value="${task.quantity}" class="form-control" id="quantity"
                                                placeholder="Điền số lượng">
                                        </div>
                                        <div class="form-group">
                                            <label for="taskStatus">Trạng Thái Task</label> <select
                                                name="taskStatus" class="form-control" id="taskStatus">
                                            <option value="0" ${task.taskStatus == 0 ? 'selected' : ''}>Chưa Thực Hiện</option>
                                            <option value="1" ${task.taskStatus == 1 ? 'selected' : ''}>Hoàn Thành</option>
                                        </select>
                                        </div>
                                    </div>
                                    <div class="col-md-6">
                                        <div class="form-group">
                                            <label for="taskDesc">Mô Tả Task</label>
                                            <textarea name="taskDesc" class="form-control" id="taskDesc"
                                                      placeholder="Điền mô tả task" rows="6">${task.taskDesc}</textarea>
                                        </div>
                                    </div>

                                </div>
                                <div class="row">
                                    <div class="col-md-6">
                                        <div class="form-group">
                                            <label for="taskShift">Ca của Task</label> <input
                                                name="taskShift" type="text" value="${task.taskShift}" class="form-control" id="taskShift"
                                                placeholder="Ca của Task">
                                        </div>
                                    </div>
                                    <div class="col-md-6">
                                        <div class="form-group">
                                            <label for="taskDate">Ngày của Task</label> <input
                                                name="taskDate" type="date" value="${task.taskDate}" class="form-control" id="taskDate"
                                                placeholder="Ngày của Task" min="${today}">
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="form-actions">
                                <button type="submit" class="btn btn-primary">Cap Nhat</button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<script>
    document.addEventListener('DOMContentLoaded', function() {
        // Lấy ngày hiện tại và định dạng thành yyyy-mm-dd
        var today = new Date().toISOString().split('T')[0];
        // Gán giá trị cho thuộc tính min của input type date
        document.getElementById("taskDate").setAttribute('min', today);
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
        text-align: left; /* Canh trái */
        display: flex;
        flex-direction: column; /* Sắp xếp theo chiều dọc */
        align-items: flex-start; /* Đảm bảo các task được canh trái */
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


</style>
