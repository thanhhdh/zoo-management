<%--
  Created by IntelliJ IDEA.
  User: hdhth
  Date: 10/9/2024
  Time: 4:22 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@include file="/common/taglib.jsp"%>

<c:url var="postURL" value="/admin/areas/update"></c:url>

<div class="col-lg-12 stretch-card">
    <div class="content-wrapper">
        <div class="page-header">
            <h3 class="page-title">
				<span class="page-title-icon bg-gradient-primary text-white me-2">
					<i class="mdi mdi-crosshairs-gps"></i>
				</span> Chỉnh sửa Khu Vực
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
                                modelAttribute="area" action="${postURL}" method="post"
                                enctype="multipart/form-data">
                            <input type="hidden" name="id" value="${area.id}">
                            <div class="form-group">
                                <label for="areaName">Tên Khu Vực <span style="color: red;">(*)</span></label> <input
                                    name="areaName" type="text" class="form-control"
                                    id="areaName" value="${area.areaName}" placeholder="Điền Tên Khu Vực"> <span
                                    class="form-message text-danger"></span>
                                <s:errors path="areaName" cssStyle="font-size: small; color: red"/>
                            </div>

                            <div class="form-group">
                                <label for="areaDesc">Mô Tả Khu Vực <span style="color: red;">(*)</span></label>
                                <Textarea name="areaDesc" class="form-control"
                                          id="areaDesc" placeholder="Điền mô tả" rows="10">${area.areaDesc}</Textarea>
                                <span class="form-message text-danger"></span>
                                <s:errors path="areaDesc" cssStyle="font-size: small; color: red"/>

                            </div>

                            <div class="form-group">
                                <label for="maxCapacity">Sức chứa của khu Vực (chuồng) <span style="color: red;">(*)</span></label> <input
                                    name="maxCapacity" type="text" class="form-control"
                                    id="maxCapacity" value="${area.maxCapacity}" placeholder="Điền Sức Chứa"> <span
                                    class="form-message text-danger"></span>
                                <s:errors path="areaName" cssStyle="font-size: small; color: red"/>
                            </div>

                            <div class="form-group">
                                <label for="areaLocation">Vị trí Khu Vực<span style="color: red;">(*)</span></label> <input
                                    name="areaLocation" type="text" class="form-control"
                                    id="areaLocation" value="${area.areaLocation}" placeholder="Điền Vị trí Khu Vực"> <span
                                    class="form-message text-danger"></span>
                                <s:errors path="areaName" cssStyle="font-size: small; color: red"/>
                            </div>

                            <div class="form-group">
                                <label for="areaStatus">Hiển thị</label>
                                <div>
                                    <select name="areaStatus" id="areaStatus" class="form-control"
                                            id="areaStatus">
                                        <option value="1" ${area.areaStatus == 1 ? "selected" : ""}>Có thể sử dụng</option>
                                        <option value="0" ${area.areaStatus == 0 ? "selected" : ""}>Không sử dụng</option>
                                    </select>
                                </div>
                            </div>

                            <button type="submit"
                                    class="btn btn-gradient-primary btn-lg add-category">Thêm</button>
                            <a href="/zooproject/admin/areas/list" class="btn btn-light btn-lg">
                                <i class="mdi mdi-arrow-left"></i> Quay Lại
                            </a>
                        </s:form>
                    </div>
                </div>
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
