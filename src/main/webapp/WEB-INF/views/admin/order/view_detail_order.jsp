<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
    <%@ include file="/common/taglib.jsp"%>
        <c:set var="parsedcouponPrice" value="${order_byId.couponPrice}" />

        <div class="content-wrapper">
            <div class="col-lg-12 stretch-card">
                <div class="card">
                    <div class="card-body">
                        <h1 class="card-title text-primary">Thông tin người mua (Tài khoản khách)</h1>
                        <table class="table table-bordered">
                            <thead>
                                <tr>
                                    <th>STT</th>
                                    <th>Tên Khách Hàng</th>
                                    <th>Email</th>
                                    <th>Số Điện Thoại</th>
                                </tr>
                            </thead>
                            <tbody>

                                <tr class="table">

                                    <c:choose>
                                        <c:when test="${order_byId.customerId.customerId == 0}">
                                            <td>#0</td>
                                            <td>Khách Vãng Lai</td>
                                            <td>Trống</td>
                                            <td>Trống</td>
                                        </c:when>

                                        <c:when test="${order_byId.customerId.customerId != 0}">

                                            <td>${order_byId.customerId.customerName }</td>
                                            <td>${order_byId.customerId.customerName }</td>
                                            <td>${order_byId.customerId.customerEmail }</td>
                                            <td>${order_byId.customerId.customerPhone }</td>
                                        </c:when>
                                    </c:choose>

                                </tr>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>

            <br> <br>

            <div class="col-lg-12 stretch-card">
                <div class="card">
                    <div class="card-body">
                        <h1 class="card-title text-primary">Thông tin đặt vé (Khách hàng)</h1>
                        <table class="table table-bordered">
                            <thead>
                                <tr>
                                    <th>STT</th>
                                    <th>Tên</th>
                                    <th>Số Điện Thoại</th>
                                    <th>Email</th>
                                    <th>Ghi Chú</th>
                                </tr>
                            </thead>
                            <tbody>

                                <tr class="table">
                                    <td>${order_byId.inforId.id }</td>
                                    <td>${order_byId.inforId.name }</td>
                                    <td>${order_byId.inforId.phone }</td>
                                    <td>${order_byId.inforId.email }</td>

                                    <c:choose>
                                        <c:when test="${order_byId.inforId.note == null}">
                                            <td>Không yêu cầu</td>
                                        </c:when>

                                        <c:when test="${order_byId.inforId.note != null}">
                                            <td>${order_byId.inforId.note}</td>
                                        </c:when>
                                    </c:choose>
                                </tr>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>

            <br> <br>

            <div class="col-lg-12 stretch-card">
                <div class="card">
                    <div class="card-body">
                        <h1 class="card-title text-primary">Liệt kê chi tiết đơn hàng</h1>
                        <table class="table table-bordered">
                            <thead>
                                <tr>
                                    <th>#Mã Đơn Hàng</th>
                                    <th>Loại Vé</th>
                                    <th>Số Lượng</th>
                                    <th>Mã Giảm</th>
                                    <th>Giá</th>
                                    <th>Thành Tiền</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:set var="total" value="0" />
                                <c:forEach var="item" items="${order_detail}">
                                    <c:set var="qty" value="${item.ticketSalesQuantity }" />
                                    <c:set var="price" value="${item.ticketPrice }" />
                                    <c:set var="total" value="${ total + (qty * price) }" />
                                    <tr class="table">
                                        <td>${item.orderCode }</td>
                                        <td>${item.ticketName }</td>
                                        <td>${item.ticketSalesQuantity }</td>

                                        <c:choose>
                                            <c:when test="${order_byId.orderCoupon == '0'}">
                                                <td>Không Có Mã Giảm</td>
                                            </c:when>

                                            <c:when test="${order_byId.orderCoupon != '0'}">
                                                <td>${order_byId.orderCoupon }</td>
                                            </c:when>
                                        </c:choose>


                                        <td>
                                            <fmt:formatNumber value="${item.ticketPrice}" pattern="#,###.##" /> đ</td>


                                        <td>
                                            <fmt:formatNumber value="${item.ticketPrice * item.ticketSalesQuantity }" pattern="#,###.##" /> đ</td>

                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>

                        <!-- Tổng các vé chưa có mã giảm -->
                        <div class="row">
                            <div class="col-md-12 mt-3">
                                <div style="display: flex; justify-content: flex-start; margin-top: 10px;">
                                    <span style="color: red; font-weight: bold">Tổng Các Món:
								&nbsp; </span>
                                    <fmt:formatNumber value="${total }" pattern="" />đ
                                </div>

                                <c:choose>
                                    <c:when test="${order_byId.orderCoupon == '0'}">
                                        <div style="display: flex; justify-content: flex-start; margin-top: 10px;">
                                            <span style="color: red; font-weight: bold">Số Giảm:
										&nbsp; </span> Không Có Mã Giảm
                                        </div>
                                    </c:when>


                                    <c:when test="${order_byId.orderCoupon != '0'}">
                                        <c:choose>
                                            <c:when test="${ parsedcouponPrice <= 10 }">
                                                <div style="display: flex; justify-content: flex-start; margin-top: 10px;">
                                                    <span style="color: red; font-weight: bold">Số Giảm:
												&nbsp</span> ${order_byId.couponPrice} %
                                                </div>
                                            </c:when>

                                            <c:when test="${parsedcouponPrice > 100}">
                                                <div style="display: flex; justify-content: flex-start; margin-top: 10px;">
                                                    <span style="color: red; font-weight: bold">Số Giảm: &nbsp;</span>
                                                    <fmt:formatNumber value="${order_byId.couponPrice}" pattern="#,###" /> đ
                                                </div>
                                            </c:when>
                                        </c:choose>
                                    </c:when>
                                </c:choose>



                                <!-- Tính tống đơn hàng -->
                                <c:choose>

                                    <c:when test="${order_byId.orderCoupon == '0'}">
                                        <div style="display: flex; justify-content: flex-start; margin-top: 10px;">
                                            <span style="color: red; font-weight: bold">Tổng Đơn
										Hàng: &nbsp; </span>
                                            <fmt:formatNumber value="${total }" pattern="#,###.##" /> đ
                                        </div>
                                    </c:when>


                                    <c:when test="${order_byId.orderCoupon != '0'}">
                                        <c:choose>
                                            <c:when test="${parsedcouponPrice <= 10}">
                                                <div style="display: flex; justify-content: flex-start; margin-top: 10px;">
                                                    <span style="color: red; font-weight: bold">Tổng Đơn
												Hàng: &nbsp; </span>
                                                    <c:set var="total_coupon" value="${(total * order_byId.couponPrice) / 100 }" />
                                                    <fmt:formatNumber value="${ total - total_coupon}" pattern="#,###.##" /> đ
                                                </div>
                                            </c:when>


                                            <c:when test="${parsedcouponPrice > 100}">
                                                <div style="display: flex; justify-content: flex-start; margin-top: 10px;">
                                                    <span style="color: red; font-weight: bold">Tổng Đơn
												Hàng: &nbsp; </span>

                                                    <fmt:formatNumber value="${total - order_byId.couponPrice}" pattern="#,###.##" /> đ
                                                </div>
                                            </c:when>
                                        </c:choose>
                                    </c:when>

                                </c:choose>


                                <div class="mt-2">
                                    <a href="/zooproject/admin/order/print-order?order_code=${order_byId.orderCode}" target="_blank">
                                        <button type="button" class="btn btn-gradient-info btn-icon-text">
                                            <i class="mdi mdi-printer"></i> In Hoá Đơn
                                        </button>
                                    </a>
                                </div>

                            </div>
                        </div>
                    </div>
                </div>
            </div>

        </div>