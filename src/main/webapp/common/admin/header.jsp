<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>


 <nav class="navbar default-layout-navbar col-lg-12 col-12 p-0 fixed-top d-flex flex-row">
        <div class="text-center navbar-brand-wrapper d-flex align-items-center justify-content-center">
          <a class="navbar-brand brand-logo" href="http://localhost:8080/zooproject/admin/dashboard">
          <img src="<c:url value='/template/admin/assets/images/logo.svg'/>" alt="logo" /></a>
          <a class="navbar-brand brand-logo-mini" href="http://localhost:8080/zooproject/admin/dashboard">
          <img src="<c:url value='/template/admin/assets/images/logo-mini.svg'/>" alt="logo" /></a>
        </div>
        <div class="navbar-menu-wrapper d-flex align-items-stretch">
          <button class="navbar-toggler navbar-toggler align-self-center" type="button" data-toggle="minimize">
            <span class="mdi mdi-menu"></span>
          </button>
<%--          <div class="search-field d-none d-md-block">--%>
<%--            <form class="d-flex align-items-center h-100" action="#">--%>
<%--              <div class="input-group">--%>
<%--                <div class="input-group-prepend bg-transparent">--%>
<%--                  <i class="input-group-text border-0 mdi mdi-magnify"></i>--%>
<%--                </div>--%>
<%--                <input type="text" class="form-control bg-transparent border-0" placeholder="Search projects">--%>
<%--              </div>--%>
<%--            </form>--%>
<%--          </div>--%>
          <ul class="navbar-nav navbar-nav-right">
            <li class="nav-item nav-profile dropdown">
              <a class="nav-link dropdown-toggle" id="profileDropdown" href="#" data-bs-toggle="dropdown" aria-expanded="false">
                <div class="nav-profile-img">
                  <img src="<c:url value='/template/admin/assets/images/faces/face1.jpg'/>" alt="image">
                  <span class="availability-status online"></span>
                </div>
                <div class="nav-profile-text">
                  <p class="mb-1 text-black">${USER.username}</p>
                </div>
              </a>
              <div class="dropdown-menu navbar-dropdown" aria-labelledby="profileDropdown">
                <a class="dropdown-item" href="#">
                  <i class="mdi mdi-cached me-2 text-success"></i> Hoạt động </a>
                <div class="dropdown-divider"></div>
                <a class="dropdown-item" href="<c:url value='/auth/logout'/>">
                  <i class="mdi mdi-logout me-2 text-primary"></i> Đăng xuất </a>
              </div>
            </li>
            <li class="nav-item d-none d-lg-block full-screen-link">
              <a class="nav-link">
                <i class="mdi mdi-fullscreen" id="fullscreen-button"></i>
              </a>
            </li>
            <li class="nav-item dropdown">
              <a class="nav-link count-indicator dropdown-toggle" id="messageDropdown" href="#" data-bs-toggle="dropdown" aria-expanded="false">
                <i class="mdi mdi-email-outline"></i>
                <span class="count-symbol bg-warning"></span>
              </a>
                <div class="dropdown-menu dropdown-menu-end navbar-dropdown preview-list">
                    <h6 class="p-3 mb-0">Thông báo đơn hàng chờ</h6>
                    <div id="orderNotifications">
                        <c:forEach var="order" items="${newOrders}">
                            <a class="dropdown-item preview-item">
                                <div class="preview-item-content d-flex align-items-start flex-column justify-content-center">
                                    <h6 class="preview-subject ellipsis mb-1 font-weight-normal">
                                        Mã đơn hàng: ${order.orderCode}
                                    </h6>
                                    <p class="text-gray mb-0">
                                        Ngày tạo: ${order.createdAt}
                                    </p>
                                </div>
                            </a>
                        </c:forEach>
                    </div>
                    <div class="dropdown-divider"></div>
                    <h6 class="p-3 mb-0 text-center">
                        <c:choose>
                            <c:when test="${not empty newOrders}">
                                ${fn:length(newOrders)} đơn hàng mới
                            </c:when>
                            <c:otherwise>
                                Không có thông báo mới
                            </c:otherwise>
                        </c:choose>
                    </h6>
                </div>
            </li>

<%--         Thong bao thuc an sap het     --%>
              <li class="nav-item dropdown">
                  <a class="nav-link count-indicator dropdown-toggle" id="foodDropdown" href="#" data-bs-toggle="dropdown" aria-expanded="false">
                      <i class="mdi mdi-alert-circle-outline"></i>
                      <span class="count-symbol bg-danger"></span>
                  </a>
                  <div class="dropdown-menu dropdown-menu-end navbar-dropdown preview-list">
                      <h6 class="p-3 mb-0">Thông báo thức ăn sắp hết</h6>
                      <div id="foodNotifications">
                          <c:forEach var="food" items="${outOfStockFoods}">
                              <a class="dropdown-item preview-item">
                                  <div class="preview-item-content d-flex align-items-start flex-column justify-content-center">
                                      <h6 class="preview-subject ellipsis mb-1 font-weight-normal">
                                          Tên thức ăn: ${food.foodName}
                                      </h6>
                                      <p class="text-gray mb-0">
                                          Số lượng còn lại: ${food.foodQuantity}
                                      </p>
                                  </div>
                              </a>
                          </c:forEach>
                      </div>
                      <div class="dropdown-divider"></div>
                      <h6 class="p-3 mb-0 text-center">
                          <c:choose>
                              <c:when test="${not empty outOfStockFoods}">
                                  ${fn:length(outOfStockFoods)} thức ăn sắp hết
                              </c:when>
                              <c:otherwise>
                                  Không có thức ăn nào sắp hết
                              </c:otherwise>
                          </c:choose>
                      </h6>
                  </div>
              </li>

          <%--Thong bao cau hoi tu nguoi dung--%>
              <li class="nav-item dropdown">
                  <a class="nav-link count-indicator dropdown-toggle" id="questionDropdown" href="#" data-bs-toggle="dropdown" aria-expanded="false">
                      <i class="mdi mdi-bell-outline"></i>
                      <span class="count-symbol bg-warning"></span>
                  </a>
                  <div class="dropdown-menu dropdown-menu-end navbar-dropdown preview-list" style="z-index: 1050;">
                      <h6 class="p-3 mb-0">Câu hỏi mới</h6>
                      <div id="questionNotifications">
                          <c:forEach var="question" items="${newMessages}">
                              <a class="dropdown-item preview-item" href="/zooproject/admin/questions/list">
                                  <div class="preview-item-content d-flex align-items-start flex-column justify-content-center">
                                      <h6 class="preview-subject ellipsis mb-1 font-weight-normal">
                                          Từ: ${question.name}
                                      </h6>
                                      <p class="text-gray mb-0">
                                          <i class="mdi mdi-email"></i> ${question.email}
                                      </p>
                                      <p class="text-gray mb-0">
                                          Nội dung: ${fn:substring(question.content, 0, 50)}...
                                      </p>
                                  </div>
                              </a>
                          </c:forEach>
                      </div>
                      <div class="dropdown-divider"></div>
                      <h6 class="p-3 mb-0 text-center">
                          <c:choose>
                              <c:when test="${not empty newMessages}">
                                  ${fn:length(newMessages)} câu hỏi mới
                              </c:when>
                              <c:otherwise>
                                  Không có thông báo mới
                              </c:otherwise>
                          </c:choose>
                      </h6>
                  </div>
              </li>

            <li class="nav-item nav-settings d-none d-lg-block">
              <a class="nav-link" href="#">
                <i class="mdi mdi-format-line-spacing"></i>
              </a>
            </li>
          </ul>
          <button class="navbar-toggler navbar-toggler-right d-lg-none align-self-center" type="button" data-toggle="offcanvas">
            <span class="mdi mdi-menu"></span>
          </button>
        </div>
      </nav>

<style>
    .content-wrapper {
        margin-top: 40px;
    }
    .dropdown-menu {
        position: absolute;
        top: 100%;
        right: 0;
        z-index: 1000;
        width: 300px;
        background-color: white;
        border: 1px solid #ccc;
        border-radius: 5px;
        box-shadow: 0px 2px 8px rgba(0, 0, 0, 0.1);
        overflow-y: auto;
        max-height: 300px;
    }
</style>

