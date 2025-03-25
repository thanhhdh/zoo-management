<%--
  Created by IntelliJ IDEA.
  User: hdhth
  Date: 10/9/2024
  Time: 4:21 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@include file="/common/taglib.jsp"%>

<c:url var="postURL" value="/admin/areas/save"></c:url>

<div class="col-lg-12 stretch-card">
    <div class="content-wrapper">
        <div class="page-header">
            <h3 class="page-title">
				<span class="page-title-icon bg-gradient-primary text-white me-2">
					<i class="mdi mdi-crosshairs-gps"></i>
				</span> Thêm Khu Vực
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
                            <div class="form-group">
                                <label for="areaName">Tên Khu Vực <span style="color: red;">(*)</span></label> <input
                                    name="areaName" type="text" class="form-control"
                                    id="areaName" placeholder="Điền Tên Khu Vực"> <span
                                    class="form-message text-danger"></span>
                                <s:errors path="areaName" cssStyle="font-size: small; color: red"/>
                            </div>

                            <div class="form-group">
                                <label for="areaDesc">Mô Tả Khu Vực <span style="color: red;">(*)</span></label>
                                <Textarea name="areaDesc" class="form-control"
                                          id="areaDesc" placeholder="Điền mô tả" rows="10"></Textarea>
                                <span class="form-message text-danger"></span>
                                <s:errors path="areaDesc" cssStyle="font-size: small; color: red"/>

                            </div>

                            <div class="form-group">
                                <label for="maxCapacity">Sức chứa của khu Vực (chuồng)<span style="color: red;">(*)</span></label> <input
                                    name="maxCapacity" type="text" class="form-control"
                                    id="maxCapacity" placeholder="Điền Sức chứa của khu Vực"> <span
                                    class="form-message text-danger"></span>
                                <s:errors path="maxCapacity" cssStyle="font-size: small; color: red"/>
                            </div>

                            <div class="form-group">
                                <label for="areaLocation">Vị trí Khu Vực<span style="color: red;">(*)</span></label> <input
                                    name="areaLocation" type="text" class="form-control"
                                    id="areaLocation" placeholder="Điền Vị trí Khu Vực"> <span
                                    class="form-message text-danger"></span>
                                <s:errors path="areaLocation" cssStyle="font-size: small; color: red"/>
                            </div>

                            <div class="form-group">
                                <label for="areaStatus">Trạng thái:</label>
                                <div>
                                    <select name="areaStatus" id="areaStatus" class="form-control"
                                            id="areaStatus">
                                        <option value="1">Có thể sử dụng</option>
                                        <option value="0">Không sử dụng</option>
                                    </select>
                                </div>
                            </div>

                            <button type="submit"
                                    class="btn btn-gradient-primary me-2 add-category">Thêm</button>
                            <button class="btn btn-light">Thoát</button>
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
