<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/common/taglib.jsp"%>
<c:url var="postURL" value="/admin/supplier/update"></c:url>

<div class="content-wrapper">
    <div class="page-header">
        <h3 class="page-title">
            <span class="page-title-icon bg-gradient-primary text-white me-2">
                <i class="mdi mdi-crosshairs-gps"></i>
            </span> Chỉnh Sửa Nhà Cung Cấp
        </h3>
        <nav aria-label="breadcrumb">
            <ul class="breadcrumb">
                <li class="breadcrumb-item active" aria-current="page"><i class="mdi mdi-timetable"></i> <span></span></li>
            </ul>
        </nav>
    </div>

    <div class="col-md-12 grid-margin stretch-card">
        <div class="card">
            <div class="card-body">
                <s:form class="forms-sample" id="form-category" modelAttribute="supplier" action="${postURL}" method="post">
                <input type="hidden" name="supplierId" value="${supplier.supplierId}" />
                    <div class="form-group">
                        <label for="supplierName">Tên Nhà Cung Cấp</label> 
                        <input name="supplierName" type="text" class="form-control" id="supplierName" value="${supplier.supplierName}" placeholder="Tên Nhà Cung Cấp"> 
                        <span class="form-message text-danger"></span>
                    </div>

                    <div class="form-group">
                        <label for="supplierPhone">Số Điện Thoại</label> 
                        <input name="supplierPhone" type="text" class="form-control" id="supplierPhone" value="${supplier.supplierPhone}" placeholder="Số Điện Thoại Nhà Cung Cấp"> 
                        <span class="form-message text-danger"></span>
                    </div>

                    <div class="form-group">
                        <label for="supplierEmail">Email Liên Hệ</label> 
                        <input name="supplierEmail" type="text" class="form-control" id="supplierEmail" value="${supplier.supplierEmail}" placeholder="Email"> 
                        <span class="form-message text-danger"></span>
                    </div>

                    <div class="form-group">
                        <label for="supplierAddress">Địa Chỉ</label>
                        <textarea name="supplierAddress" class="form-control" id="supplierAddress" placeholder="Địa Chỉ" rows="5">${supplier.supplierAddress}</textarea>
                        <span class="form-message text-danger"></span>
                    </div>

                    <div class="form-group">
                        <label for="supplierDesc">Mô Tả</label>
                        <textarea name="supplierDesc" class="form-control" id="supplierDesc" placeholder="Mô Tả" rows="10">${supplier.supplierDesc}</textarea>
                        <span class="form-message text-danger"></span>
                    </div>

                    <button type="submit" class="btn btn-gradient-primary me-2 add-category">Cập Nhật</button>
                    <button type="button" class="btn btn-light" onclick="window.location.href='/admin/supplier/list'">Thoát</button>
                </s:form>
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
