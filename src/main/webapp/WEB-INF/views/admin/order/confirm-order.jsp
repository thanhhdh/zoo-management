<%--
  Created by IntelliJ IDEA.
  User: hdhth
  Date: 10/31/2024
  Time: 4:45 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/common/taglib.jsp"%>

<div class="content-wrapper">
    <div class="page-header">
        <h3 class="page-title">
            <span class="page-title-icon bg-gradient-success text-white me-2">
                <i class="mdi mdi-check-circle"></i>
            </span> Xác Nhận Đơn Hàng
        </h3>
        <nav aria-label="breadcrumb">
            <ul class="breadcrumb">
                <li class="breadcrumb-item">
                    <a href="/zooproject/admin/order/view-order" class="text-primary">Quản Lý Đơn Hàng</a>
                </li>
                <li class="breadcrumb-item active" aria-current="page">
                    Xác Nhận Đơn Hàng
                </li>
            </ul>
        </nav>
    </div>

    <div class="col-md-8 grid-margin stretch-card mx-auto">
        <div class="card">
            <div class="card-body">
                <!-- Success/Error Message Display -->
                <c:if test="${not empty message}">
                    <div class="alert alert-success text-center">
                        <i class="mdi mdi-check-circle-outline"></i> ${message}
                    </div>
                </c:if>
                <c:if test="${not empty error}">
                    <div class="alert alert-danger text-center">
                        <i class="mdi mdi-alert-circle-outline"></i> ${error}
                    </div>
                </c:if>

                <!-- Order Details -->
                <h4 class="card-title text-center">Thông Tin Chi Tiết Đơn Hàng</h4>
                <div class="table-responsive mt-4">
                    <table class="table table-bordered table-hover">
                        <tr>
                            <th class="bg-light">Mã đơn hàng</th>
                            <td>${order.orderCode}</td>
                        </tr>
                        <tr>
                            <th class="bg-light">Tên người đặt</th>
                            <td>
                                <c:choose>
                                    <c:when test="${order.customerId.customerId == 0}">
                                        Khách vãng lai
                                    </c:when>
                                    <c:otherwise>
                                        ${order.customerId.customerName}
                                    </c:otherwise>
                                </c:choose>
                            </td>
                        </tr>
                        <tr>
                            <th class="bg-light">Trạng thái</th>
                            <td><span class="badge bg-success">Đã xác nhận</span></td>
                        </tr>
                        <tr>
                            <th class="bg-light">Hình thức thanh toán</th>
                            <td>
                                <c:choose>
                                    <c:when test="${order.paymentId.paymentMethod == 1}">
                                        Thanh toán trực tiếp
                                    </c:when>
                                    <c:when test="${order.paymentId.paymentMethod == 2}">
                                        Thanh toán trực tuyến
                                    </c:when>
                                </c:choose>
                            </td>
                        </tr>
                        <tr>
                            <th class="bg-light">Thời gian đặt</th>
                            <td>${order.createdAt}</td>
                        </tr>
                    </table>
                </div>

                <!-- Back Button -->
                <div class="text-center mt-4">
                    <a href="/zooproject/admin/order/view-order" class="btn btn-gradient-primary btn-lg">
                        <i class="mdi mdi-arrow-left"></i> Quay Lại Danh Sách Đơn Hàng
                    </a>
                </div>
            </div>
        </div>
    </div>
</div>
