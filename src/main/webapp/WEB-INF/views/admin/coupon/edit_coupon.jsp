<%--
  Created by IntelliJ IDEA.
  User: hdhth
  Date: 10/31/2024
  Time: 11:14 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@include file="/common/taglib.jsp"%>

<c:url var="postURL" value="/admin/coupon/update"></c:url>

<div class="content-wrapper">
    <div class="page-header">
        <h3 class="page-title">
			<span class="page-title-icon bg-gradient-primary text-white me-2">
				<i class="mdi mdi-crosshairs-gps"></i>
			</span> Chỉnh Sửa Chương Trình Khuyến Mãi
        </h3>
        <nav aria-label="breadcrumb">
            <ul class="breadcrumb">
                <li class="breadcrumb-item active" aria-current="page"><i
                        class="mdi mdi-timetable"></i> <span></span></li>
            </ul>
        </nav>
    </div>

    <div class="col-md-12 grid-margin stretch-card">
        <div class="card">
            <div class="card-body">
                <s:form class="forms-sample" id="form-category"
                        modelAttribute="coupon" action="${postURL}" method="post"
                        enctype="multipart/form-data">
                    <input type="hidden" name="couponId" value="${coupon.couponId}">

                    <div class="form-group">
                        <label for="exampleInputUsername1">Tên Mã Giảm Giá</label>
                        <Textarea name="couponName" rows="10" type="text" class="form-control"
                                  id="name_coupon">${coupon.couponName} </Textarea>
                    </div>
                    <div class="form-group">
                        <label for="exampleInputUsername1">Mã Giảm Giá</label> <input
                            name="couponCode" type="text" class="form-control" value="${coupon.couponCode}"
                            id="code_coupon"> <span class="form-message text-danger"></span>
                    </div>

                    <div class="form-group row">
                        <div class="col-md-4">
                            <label for="exampleInputEmail1">Tính Năng </label>
                            <div>
                                <select name="couponCondition" id="" class="form-control"
                                        id="condition_coupon">
                                    <option value="0">--Chọn--</option>
                                    <option value="1" ${coupon.couponCondition == 1 ? "selected" : ""}>Giảm Theo Phần Trăm</option>
                                    <option value="2" ${coupon.couponCondition == 2 ? "selected" : ""}>Giảm Theo Tiền</option>
                                </select>
                            </div>
                        </div>
                        <div class="col-md-4">
                            <label for="exampleInputUsername1">Nhập Số % Hoặc Số Tiền
                                giảm</label>
                            <input min="1" type="number" name="couponNumber" value="${coupon.couponNumber}"
                                                    class="form-control" id="number_coupon">
                        </div>

                        <div class="col-md-4">
                            <label for="exampleInputUsername1">Số Lượng Mã Giảm Giá</label>
                            <input value="${coupon.couponQty}"
                                name="couponQty" min="1" type="number" class="form-control" id="time_qty">
                            <span class="form-message text-danger"></span>
                        </div>
                    </div>

                    <div class="form-group row">
                        <div class="col-md-6">
                            <label for="exampleInputUsername1">Thời Gian Bắt Đầu</label> <input
                                name="couponStart" type="text" class="form-control" value="${coupon.couponStart}"
                                id="datepicker_start"> <span
                                class="form-message text-danger"></span>
                        </div>
                        <div class="col-md-6">
                            <label for="exampleInputUsername1">Thời Gian Kết Thúc</label>
                            <input
                                name="couponEnd" type="text" class="form-control"
                                value="${coupon.couponEnd}"
                                id="datepicker_end"> <span
                                class="form-message text-danger"></span>
                        </div>
                    </div>
                    <button type="submit"
                            class="btn btn-gradient-primary btn-lg add-coupon">Thêm</button>
                    <a href="/zooproject/admin/coupon/list" class="btn btn-light btn-lg">
                        <i class="mdi mdi-arrow-left"></i> Quay Lại
                    </a>
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
