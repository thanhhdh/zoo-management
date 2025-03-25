<%--
  Created by IntelliJ IDEA.
  User: hdhth
  Date: 12/4/2024
  Time: 4:37 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@include file="/common/taglib.jsp"%>
<div class="content-wrapper">
    <div class="page-header">
        <h3 class="page-title">
            <span class="page-title-icon bg-gradient-primary text-white me-2">
				<i class="mdi mdi-crosshairs-gps"></i>
            </span>
            Danh Sách Hồ Sơ Y Tế - Động Vật: ${animal.animalName}
        </h3>
        <nav aria-label="breadcrumb">
            <ul class="breadcrumb">
                <li class="breadcrumb-item">
                    <a href="/zooproject/admin/animal/list">Danh Sách Động Vật</a>
                </li>
                <li class="breadcrumb-item active" aria-current="page">Hồ Sơ Y Tế</li>
            </ul>
        </nav>
    </div>

    <div class="col-md-12 grid-margin stretch-card">
        <div class="card">
            <div class="card-body">
                <div class="row">
                    <div class="col-md-6">
                        <h4 class="card-title">Danh Sách Hồ Sơ Y Tế</h4>
                    </div>
                    <div class="col-md-6 text-end">
                        <c:url var="addMedicalUrl" value="/admin/medical/add">
                            <c:param name="animalId" value="${animal.animalId}" />
                        </c:url>
                        <a href="${addMedicalUrl}" class="btn btn-primary btn-sm">Thêm Hồ Sơ Y Tế</a>
                    </div>
                </div>
                <div class="table-responsive">
                    <table class="table table-bordered">
                        <thead>
                        <tr>
                            <th>STT</th>
                            <th>Tên Hồ Sơ</th>
                            <th>Mô Tả</th>
                            <th>Trạng Thái</th>
                            <th>Thời Gian Kiểm Tra</th>
                            <th>Thao Tác</th>
                        </tr>
                        </thead>
                        <tbody>
                        <c:if test="${not empty medicalRecords}">
                            <c:forEach var="record" items="${medicalRecords}" varStatus="status">
                                <tr>
                                    <td>${status.index + 1}</td>
                                    <td>${record.medicalName}</td>
                                    <td>${record.medicalDesc}</td>
                                    <td>
                                        <c:choose>
                                            <c:when test="${record.medicalStatus == 1}">Hoàn Thành</c:when>
                                            <c:otherwise>Đang Tiến Hành</c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td>${record.medicalCheck}</td>
                                    <td>
                                        <c:url var="editMedicalUrl" value="/admin/medical/edit">
                                            <c:param name="medicalId" value="${record.medicalId}" />
                                        </c:url>
                                        <a href="${editMedicalUrl}" class="btn btn-warning btn-sm">Sửa</a>

                                        <c:url var="deleteMedicalUrl" value="/admin/medical/delete/${record.medicalId}">
                                            <c:param name="animalId" value="${animal.animalId}" />
                                        </c:url>
                                        <a href="${deleteMedicalUrl}" class="btn btn-danger btn-sm">Xóa</a>

                                    </td>
                                </tr>
                            </c:forEach>
                        </c:if>
                        <c:if test="${empty medicalRecords}">
                            <tr>
                                <td colspan="6" class="text-center">Chưa có hồ sơ y tế nào cho động vật này.</td>
                            </tr>
                        </c:if>
                        </tbody>

                    </table>
                </div>
                <a href="/zooproject/admin/animal/list" class="btn btn-light btn-sm mt-3">Quay Lại</a>
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

