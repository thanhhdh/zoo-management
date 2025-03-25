<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/common/taglib.jsp"%>
<c:set var="parsedcouponPrice" value="${order_byId.couponPrice}" />

<div class="print-container">
    <h1 class="text-center">Hoá Đơn Thanh Toán</h1>
    <p><strong>Mã Đơn Hàng:</strong> ${order_byId.orderCode}</p>
    <p><strong>Ngày Đặt:</strong> ${order_byId.createdAt}</p>

    <h2>Thông Tin Khách Hàng</h2>
    <table class="table table-bordered">
        <tr><th>Tên Khách Hàng:</th><td>${order_byId.inforId.name}</td></tr>
        <tr><th>Email:</th><td>${order_byId.inforId.email}</td></tr>
        <tr><th>Số Điện Thoại:</th><td>${order_byId.inforId.phone}</td></tr>
    </table>

    <h2>Chi Tiết Đơn Hàng</h2>
    <table class="table table-bordered">
        <thead>
        <tr>
            <th>Loại Vé</th>
            <th>Số Lượng</th>
            <th>Giá</th>
            <th>Thành Tiền</th>
        </tr>
        </thead>
        <tbody>
        <c:set var="total" value="0" />
        <c:forEach var="item" items="${order_detail}">
            <c:set var="itemTotal" value="${item.ticketPrice * item.ticketSalesQuantity}" />
            <c:set var="total" value="${total + itemTotal}" />
            <tr>
                <td>${item.ticketName}</td>
                <td>${item.ticketSalesQuantity}</td>
                <td><fmt:formatNumber value="${item.ticketPrice}" pattern="#,###.##" /> đ</td>
                <td><fmt:formatNumber value="${itemTotal}" pattern="#,###.##" /> đ</td>
            </tr>
        </c:forEach>
        </tbody>
    </table>

    <h2>Tổng Kết Đơn Hàng</h2>
    <table class="table table-bordered">
        <tr>
            <th>Tổng Cộng:</th>
            <td><fmt:formatNumber value="${total}" pattern="#,###.##" /> đ</td>
        </tr>

        <c:if test="${order_byId.orderCoupon != '0'}">
            <c:choose>
                <c:when test="${parsedcouponPrice <= 10}">
                    <tr>
                        <th>Giảm Giá:</th>
                        <td>${order_byId.couponPrice} %</td>
                    </tr>
                    <tr>
                        <th>Tổng Sau Giảm:</th>
                        <td>
                            <c:set var="totalAfterDiscount" value="${total - (total * order_byId.couponPrice / 100)}" />
                            <fmt:formatNumber value="${totalAfterDiscount}" pattern="#,###.##" /> đ
                        </td>
                    </tr>
                </c:when>

                <c:when test="${parsedcouponPrice > 100}">
                    <tr>
                        <th>Giảm Giá:</th>
                        <td><fmt:formatNumber value="${order_byId.couponPrice}" pattern="#,###" /> đ</td>
                    </tr>
                    <tr>
                        <th>Tổng Sau Giảm:</th>
                        <td>
                            <c:set var="totalAfterDiscount" value="${total - order_byId.couponPrice}" />
                            <fmt:formatNumber value="${totalAfterDiscount}" pattern="#,###.##" /> đ
                        </td>
                    </tr>
                </c:when>
            </c:choose>
        </c:if>

        <c:if test="${order_byId.orderCoupon == '0'}">
            <tr>
                <th>Tổng Đơn Hàng:</th>
                <td><fmt:formatNumber value="${total}" pattern="#,###.##" /> đ</td>
            </tr>
        </c:if>
    </table>

    <p class="text-center">Cảm ơn bạn đã sử dụng dịch vụ của chúng tôi!</p>

    <!-- Print Button -->
    <div class="print-button text-center mt-3">
        <button onclick="window.print()" class="btn btn-gradient-info btn-icon-text">
            <i class="mdi mdi-printer"></i> In Hoá Đơn
        </button>
    </div>
</div>

<style>
    /* Container for printing */
    .print-container {
        max-width: 800px;
        margin: auto;
        font-family: Arial, sans-serif;
    }

    h1, h2 {
        text-align: center;
        color: #4CAF50;
    }

    .table {
        width: 100%;
        margin-bottom: 1rem;
        color: #212529;
        border: 1px solid #dee2e6;
    }

    th, td {
        padding: 0.75rem;
        text-align: left;
        border-top: 1px solid #dee2e6;
    }

    /* Hide everything but the .print-container when printing */
    @media print {
        body * {
            visibility: hidden;
        }

        .print-container, .print-container * {
            visibility: visible;
        }

        .print-container {
            position: absolute;
            left: 0;
            top: 0;
            right: 0;
            width: 100%;
        }

        .print-button { display: none; }
    }
</style>
