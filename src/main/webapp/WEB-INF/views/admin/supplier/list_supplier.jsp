<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/common/taglib.jsp"%>


<div class="content-wrapper">
    <div class="page-header">
        <h3 class="page-title">
            <span class="page-title-icon bg-gradient-primary text-white me-2">
                <i class="mdi mdi-crosshairs-gps"></i>
            </span> Nhà Cung Cấp
        </h3>
        <nav aria-label="breadcrumb">
            <ul class="breadcrumb">
                <li class="breadcrumb-item active" aria-current="page">
                    <i class="mdi mdi-timetable"></i> <span></span>
                </li>
            </ul>
        </nav>
    </div>
    <div class="col-md-12 grid-margin stretch-card">
        <div class="card">
            <div class="card-body">
                <table class="table-bordered table">
                    <thead>
                        <tr>
                            <th style="font-weight: bold;">#ID</th>
                            <th style="font-weight: bold;">Tên</th>
                            <th style="font-weight: bold;">Điện Thoại</th>
                            <th style="font-weight: bold;">Email</th>
                            <th style="font-weight: bold;">Địa Chỉ</th>
                            <th style="font-weight: bold;">Mô Tả</th>
                            <th style="font-weight: bold;">Thao Tác</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:if test="${not empty suppliers}">
                            <c:forEach var="item" items="${suppliers.listResult}">
                                <tr>
                                    <td>${item.supplierId}</td>
                                    <td style="max-width: 150px; word-wrap: break-word;">${item.supplierName}</td>
                                    <td style="max-width: 200px; word-wrap: break-word;">${item.supplierPhone}</td>
                                    <td style="max-width: 150px; word-wrap: break-word;">${item.supplierEmail}</td>
                                    <td style="max-width: 150px; word-wrap: break-word;">${item.supplierAddress}</td>
                                    <td style="max-width: 150px; word-wrap: break-word;">${item.supplierDesc}</td>
                                    <td>
                                        <div style="display: flex;">
                                            <c:url var="deleteSupplier" value="/admin/supplier/delete">
                                                <c:param name="id" value="${item.supplierId}" />
                                            </c:url>
                                            <a href="${deleteSupplier}" class="delete-category">
                                                <i class="mdi mdi-delete-forever" style="color: red; margin-right: 10px; font-size: 1.2rem"></i>
                                            </a>
                                            <c:url var="editSupplier" value="/admin/supplier/edit">
                                                <c:param name="id" value="${item.supplierId}" />
                                            </c:url>
                                            <a href="${editSupplier}">
                                                <i class="mdi mdi-open-in-new" style="color: green; margin-right: 10px; font-size: 1.2rem"></i>
                                            </a>
                                        </div>
                                    </td>
                                </tr>
                            </c:forEach>
                        </c:if>
                    </tbody>
                </table>
                <nav class="d-flex justify-content-center pt-4" aria-label="Page navigation">
                    <ul class="pagination" id="pagination"></ul>
                </nav>
            </div>
        </div>
    </div>
</div>


<script type="text/javascript">
    var totalPages = ${suppliers.totalPage};
    var currentPage = ${suppliers.page};
    var limit = ${suppliers.limit};
    var page = 1;

    $(function () {
        window.pagObj = $('#pagination').twbsPagination({
            totalPages: totalPages,
            visiblePages: 3,
            startPage: currentPage,
            first: 'Đầu',
            prev: 'Trước',
            next: 'Tiếp',
            last: 'Cuối',
            onPageClick: function (event, page) {
                if (currentPage != page) {
                    window.location.href = "/zooproject/admin/supplier/list?page=" + page + "&limit=" + limit;
                }
            }
        });
    });

    $(document).ready(function() {
        var deleteUrl;

        $(".delete-category").on("click", function(e) {
            e.preventDefault();
            deleteUrl = $(this).attr("href");
            $('#deleteModal').modal('show'); // Hiển thị modal
        });

        $("#confirmDelete").on("click", function() {
            window.location.href = deleteUrl; // Điều hướng đến URL xóa
        });
    });


</script>

<script type="text/javascript">
	$(document).ready(function() {
		<c:if test="${not empty message}">
			var message = "${message.message}";
			var type = "${message.type}";
			message_toastr(type, message, "Thông Báo");
		</c:if>
	});
</script>

<style>
    table th, table td {
        text-align: center;
        vertical-align: middle;
    }
    table td {
        max-width: 100px;
        white-space: nowrap;
        overflow: hidden;
        text-overflow: ellipsis;
    }
    
.modal-body i {
    font-size: 4rem; /* Tăng kích thước biểu tượng */
    color: #FFA500; /* Màu cam cho biểu tượng cảnh báo */
}

.modal-footer .btn-danger {
    background-color: #dc3545;
    color: white;
}

.modal-footer .btn-secondary {
    background-color: #6c757d;
    color: white;
}

.modal-footer .btn {
    min-width: 120px; /* Đảm bảo nút có kích thước đủ lớn */
}

.modal-body {
    padding-top: 20px;
    padding-bottom: 10px;
}

.modal-title {
    font-weight: bold;
}

    
</style>
