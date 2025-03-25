<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="/common/taglib.jsp"%>
<c:url var="postURL" value="/admin/cage/update"></c:url>
<div class="col-lg-12 stretch-card">
    <div class="content-wrapper">
        <div class="page-header">
            <h3 class="page-title">
				<span class="page-title-icon bg-gradient-primary text-white me-2">
					<i class="mdi mdi-crosshairs-gps"></i>
				</span> Chỉnh Sửa Chuồng
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
                        <s:form class="forms-sample" id="form-category"
                                modelAttribute="cage" action="${postURL}" method="post"
                                enctype="multipart/form-data">
                            <input type="hidden" name="id" value="${cage.id}">
                            <div class="form-group">
                                <label for="exampleInputUsername1">Tên Chuồng</label> <input
                                    name="cageName" value="${cage.cageName}" type="text" class="form-control"
                                    id="name_category" placeholder="Điền tên chuồng"> <span
                                    class="form-message text-danger"></span>
                            </div>


                            <div class="form-group">
                                <label for="exampleInputUsername1">Chọn khu vực chuồng <span style="color: red;">(*)</span></label>
                                <select
                                        name="areaId" class="form-control"
                                        id="exampleInputUsername1">
                                    <c:forEach var="item" items="${areas}">
                                        <option value="${item.id }" ${item.id == cage.area.id  ? 'selected ="selected"':''}>
                                                ${item.areaName}
                                        </option>

                                    </c:forEach>
                                </select>
                            </div>

                            <div class="form-group">
                                <label for="exampleInputUsername1">Mô Tả Chuồng</label>
                                <Textarea name="cageDesc" class="form-control"
                                          id="cageDesc" placeholder="Điền mô tả" rows="10">${cage.cageDesc}</Textarea>
                                <span class="form-message text-danger"></span>
                            </div>
                            <div class="form-group">
                                <label for="exampleInputUsername1">Sức Chứa Chuồng</label> <input
                                    name="cageCapacity" value="${cage.cageCapacity}" type="text" class="form-control"
                                    id="cageCapacity" placeholder="Dung Tích Chuồng"> <span
                                    class="form-message text-danger"></span>
                            </div>
                            <div class="form-group">
                                <label for="cageStatus">Hiển Thị</label>
                                <div>
                                    <select name="cageStatus" id="" class="form-control"
                                            id="cageStatus">
                                        <option value="1" ${cage.cageStatus == 1 ? "selected" : ""}>Hiển thị</option>
                                        <option value="0" ${cage.cageStatus == 0 ? "selected" : ""}>Ẩn</option>
                                    </select>
                                </div>
                            </div>

                            <button type="submit"
                                    class="btn btn-gradient-primary btn-lg add-category">Chỉnh sửa</button>
                            <a href="/zooproject/admin/cage/list" class="btn btn-light btn-lg">
                                <i class="mdi mdi-arrow-left"></i> Quay Lại
                            </a>
                        </s:form>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>