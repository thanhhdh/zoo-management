<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/common/taglib.jsp"%>
<c:url var="updateUrl" value="/admin/food/update"></c:url>

<div class="content-wrapper">
    <div class="page-header">
        <h3 class="page-title">
            <span class="page-title-icon bg-gradient-primary text-white me-2">
                <i class="mdi mdi-pencil"></i>
            </span> Cập Nhật Thức Ăn
        </h3>
    </div>
    <div class="col-md-12 grid-margin stretch-card">
        <div class="card">
            <div class="card-body">
                <s:form class="forms-sample" id="form-food"
                    modelAttribute="food" action="${updateUrl}" method="post"
                    enctype="multipart/form-data">

                    <input type="hidden" name="foodId" value="${food.foodId}" />

                    <div class="form-group">
                        <label for="foodName">Tên Thức Ăn</label> 
                        <input name="foodName" type="text" class="form-control"
                            id="foodName" value="${food.foodName}" placeholder="Tên Thức Ăn" required> 
                        <span class="form-message text-danger"></span>
                    </div>

                    <div class="form-group">
                        <label for="foodQuantity">Số Lượng (kg)</label>
                        <input name="foodQuantity" type="number" class="form-control"
                            id="foodQuantity" value="${food.foodQuantity}" placeholder="Số Lượng Nhập Vào Kho" required> 
                        <span class="form-message text-danger"></span>
                    </div>

                    <div class="form-group">
                        <label for="nutritionalInfo">Thông Tin Dinh Dưỡng</label>
                        <textarea name="nutritionalInfo" class="form-control"
                            id="nutritionalInfo" placeholder="Thông Tin Dinh Dưỡng" rows="10" required>${food.nutritionalInfo}</textarea>
                        <span class="form-message text-danger"></span>
                    </div>


                    <div class="form-group">
                        <label for="supplierId">Nhà Cung Cấp </label> 
                        <select name="supplierId" class="form-control" id="supplierId">
                            <option value="">-- Chọn Nhà Cung Cấp --</option>
                            <c:forEach var="item" items="${supplier}">
                                <option value="${item.supplierId}" ${item.supplierId == food.supplier.supplierId ? 'selected' : ''}>
                                    ${item.supplierName}
                                </option>
                            </c:forEach>
                        </select>
                        <span class="form-message text-danger"></span>
                    </div>

                    <div class="form-group row">
                        <div class="col-md-6">
                            <label for="expirationStart">Năm Sản Xuất</label> 
                            <input name="expirationStart" type="text" class="form-control"
                                id="datepicker_start" value="${food.expirationStart}" placeholder="Năm Sản Xuất" required> 
                            <span class="form-message text-danger"></span>
                        </div>
                        <div class="col-md-6">
                            <label for="expirationEnd">Hạn Sử Dụng</label> 
                            <input name="expirationEnd" type="text" class="form-control"
                                id="datepicker_end" value="${food.expirationEnd}" placeholder="Hạn Sử Dụng" required> 
                            <span class="form-message text-danger"></span>
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="storageRequirements">Yêu Cầu Bảo Quản</label>
                        <textarea name="storageRequirements" class="form-control"
                            id="storageRequirements" placeholder="Yêu Cầu Bảo Quản" rows="10" required>${food.storageRequirements}</textarea>
                        <span class="form-message text-danger"></span>
                    </div>

                    <button type="submit" class="btn btn-gradient-primary btn-lg">Chỉnh sửa</button>
                    <a href="/zooproject/admin/food/list" class="btn btn-light btn-lg">
                        <i class="mdi mdi-arrow-left"></i> Quay Lại
                    </a>
                </s:form>
            </div>
        </div>
    </div>
</div>
