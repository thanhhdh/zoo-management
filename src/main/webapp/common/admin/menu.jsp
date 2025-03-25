<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="dec"
    uri="http://www.opensymphony.com/sitemesh/decorator"%>
<%@ taglib prefix="security"
    uri="http://www.springframework.org/security/tags"%>
<nav class="sidebar sidebar-offcanvas" id="sidebar">
    <ul class="nav">
        <li class="nav-item nav-profile">
            <a href="#" class="nav-link">
                <div class="nav-profile-image">
                    <img src="<c:url value='/template/admin/assets/images/faces/face1.jpg'/>" alt="profile">
                    <span class="login-status online"></span>
                    <!--change to offline or busy as needed-->
                </div>
                <div class="nav-profile-text d-flex flex-column">
                    <span class="font-weight-bold mb-2">Zoo Management</span>
                    <span class="text-secondary text-small">
                        <security:authorize access="hasRole('ROLE_ADMIN')">ADMIN </security:authorize>
                        <security:authorize access="hasRole('ROLE_MANAGER')">MANAGER</security:authorize>
                        <security:authorize access="hasRole('ROLE_EMPLOYEE')">EMPLOYEE</security:authorize>
                        <security:authorize access="!isAuthenticated()">Chưa đăng nhập</security:authorize>
                    </span>
                </div>
                <i class="mdi mdi-bookmark-check text-success nav-profile-badge"></i>
            </a>
        </li>
        <li class="nav-item">
            <a class="nav-link" href="<c:url value='/admin/dashboard'/>">
                <span class="menu-title">Bảng Điều Khiển</span>
                <i class="mdi mdi-home menu-icon"></i>
            </a>
        </li>

        <security:authorize access="hasAnyRole('ROLE_ADMIN','ROLE_MANAGER')">
            <li class="nav-item">
                <a class="nav-link" data-bs-toggle="collapse" href="#ui-admin" aria-expanded="false" aria-controls="ui-admin">
                    <span class="menu-title">Quản Lý Tài Khoản</span>
                    <i class="menu-arrow"></i>
                    <i class="mdi mdi-crosshairs-gps menu-icon"></i>
                </a>
                <div class="collapse" id="ui-admin">
                    <ul class="nav flex-column sub-menu">
                        <li class="nav-item">
                            <a class="nav-link" href="<c:url value='/admin/account-admin/list'/>">Danh Sách</a>
                        </li>
                            <li class="nav-item">
                                <a class="nav-link" href="<c:url value='/admin/account-admin/add'/>">Thêm Mới</a>
                            </li>
                    </ul>
                </div>
            </li>
        </security:authorize>
        
        <!-- Đơn Hàng -->
        
        <security:authorize access="hasAnyRole('ROLE_ADMIN','ROLE_MANAGER')">
            <li class="nav-item">
                <a class="nav-link" data-bs-toggle="collapse" href="#ui-basic-order" aria-expanded="false" aria-controls="#ui-basic-order">
                    <span class="menu-title">Quản Lý Đơn Hàng</span>
                    <i class="menu-arrow"></i>
                    <i class="mdi mdi-clipboard-text menu-icon"></i>
                </a>
                <div class="collapse" id="ui-basic-order">
                    <ul class="nav flex-column sub-menu">
                        <li class="nav-item">
                            <a class="nav-link" href="<c:url value='/admin/order/view-order'/>">Đơn Hàng</a>
                        </li>
                    </ul>
                </div>
            </li>
        </security:authorize>

       <!-- QL LOÀI -->
<security:authorize access="hasAnyRole('ROLE_ADMIN','ROLE_MANAGER', 'ROLE_EMPLOYEE')">
    <li class="nav-item">
        <a class="nav-link" data-bs-toggle="collapse" href="#ui-basic-species" aria-expanded="false" aria-controls="ui-basic-species">
            <span class="menu-title">Quản Lý Loài</span>
            <i class="menu-arrow"></i>
            <i class="mdi mdi-clipboard-text menu-icon"></i>
        </a>
        <div class="collapse" id="ui-basic-species">
            <ul class="nav flex-column sub-menu">
                <li class="nav-item">
                    <a class="nav-link" href="<c:url value='/admin/species/list'/>">Liệt Kê Loài</a>
                </li>
                    <li class="nav-item">
                        <a class="nav-link" href="<c:url value='/admin/species/add'/>">Thêm Loài</a>
                    </li>
            </ul>
        </div>
    </li>
</security:authorize>

<!-- QL ĐỘNG VẬT -->
<security:authorize access="hasAnyRole('ROLE_ADMIN','ROLE_MANAGER', 'ROLE_EMPLOYEE')">
    <li class="nav-item">
        <a class="nav-link" data-bs-toggle="collapse" href="#ui-basic-animal" aria-expanded="false" aria-controls="ui-basic-animal">
            <span class="menu-title">Quản Lý Động Vật</span>
            <i class="menu-arrow"></i>
            <i class="mdi mdi-clipboard-text menu-icon"></i>
        </a>
        <div class="collapse" id="ui-basic-animal">
            <ul class="nav flex-column sub-menu">
                <li class="nav-item">
                    <a class="nav-link" href="<c:url value='/admin/animal/list'/>">Liệt Kê Động Vật</a>
                </li>
                    <li class="nav-item">
                        <a class="nav-link" href="<c:url value='/admin/animal/add'/>">Thêm Động Vật</a>
                    </li>
            </ul>
        </div>
    </li>
</security:authorize>

        <!-- QL KHU VUC -->
        <security:authorize access="hasAnyRole('ROLE_ADMIN','ROLE_MANAGER','ROLE_EMPLOYEE')">
        <li class="nav-item">
            <a class="nav-link" data-bs-toggle="collapse" href="#ui-basic-area" aria-expanded="false" aria-controls="ui-basic-area">
                <span class="menu-title">Quản Lý Khu Vực</span>
                <i class="menu-arrow"></i>
                <i class="mdi mdi-clipboard-text menu-icon"></i>
            </a>
            <div class="collapse" id="ui-basic-area">
                <ul class="nav flex-column sub-menu">
                    <li class="nav-item">
                        <a class="nav-link" href="<c:url value='/admin/areas/list'/>">Liệt Kê Khu Vực</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="<c:url value='/admin/areas/add'/>">Thêm Khu Vực</a>
                    </li>
                </ul>
            </div>
        </li>
        </security:authorize>

<!-- QL CHUỒNG -->
<security:authorize access="hasAnyRole('ROLE_ADMIN','ROLE_MANAGER','ROLE_EMPLOYEE')">
    <li class="nav-item">
        <a class="nav-link" data-bs-toggle="collapse" href="#ui-basic-cage" aria-expanded="false" aria-controls="ui-basic-cage">
            <span class="menu-title">Quản Lý Chuồng</span>
            <i class="menu-arrow"></i>
            <i class="mdi mdi-clipboard-text menu-icon"></i>
        </a>
        <div class="collapse" id="ui-basic-cage">
            <ul class="nav flex-column sub-menu">
                <li class="nav-item">
                    <a class="nav-link" href="<c:url value='/admin/cage/list'/>">Liệt Kê Chuồng</a>
                </li>
                    <li class="nav-item">
                        <a class="nav-link" href="<c:url value='/admin/cage/add'/>">Thêm Chuồng</a>
                    </li>
            </ul>
        </div>
    </li>
</security:authorize>

<!-- QL NHÀ CUNG CẤP -->
<security:authorize access="hasAnyRole('ROLE_ADMIN','ROLE_MANAGER', 'ROLE_EMPLOYEE')">
    <li class="nav-item">
        <a class="nav-link" data-bs-toggle="collapse" href="#ui-basic-supplier" aria-expanded="false" aria-controls="ui-basic-supplier">
            <span class="menu-title">Nhà Cung Cấp</span>
            <i class="menu-arrow"></i>
            <i class="mdi mdi-clipboard-text menu-icon"></i>
        </a>
        <div class="collapse" id="ui-basic-supplier">
            <ul class="nav flex-column sub-menu">
                <li class="nav-item">
                    <a class="nav-link" href="<c:url value='/admin/supplier/list'/>">Nhà Cung Cấp</a>
                </li>
                    <li class="nav-item">
                        <a class="nav-link" href="<c:url value='/admin/supplier/add'/>">Thêm Nhà Cung Cấp</a>
                    </li>
            </ul>
        </div>
    </li>
</security:authorize>

<!-- QL THỨC ĂN -->
<security:authorize access="hasAnyRole('ROLE_ADMIN','ROLE_MANAGER', 'ROLE_EMPLOYEE')">
    <li class="nav-item">
        <a class="nav-link" data-bs-toggle="collapse" href="#ui-basic-food" aria-expanded="false" aria-controls="ui-basic-food">
            <span class="menu-title">Thức Ăn</span>
            <i class="menu-arrow"></i>
            <i class="mdi mdi-clipboard-text menu-icon"></i>
        </a>
        <div class="collapse" id="ui-basic-food">
            <ul class="nav flex-column sub-menu">
                <li class="nav-item">
                    <a class="nav-link" href="<c:url value='/admin/food/list'/>">Liệt Kê Thức Ăn</a>
                </li>
                    <li class="nav-item">
                        <a class="nav-link" href="<c:url value='/admin/food/add'/>">Thêm Thức Ăn</a>
                    </li>
            </ul>
        </div>
    </li>
</security:authorize>

<!-- QL Task -->
<security:authorize access="hasAnyRole('ROLE_ADMIN','ROLE_MANAGER','ROLE_EMPLOYEE')">
    <li class="nav-item">
        <a class="nav-link" data-bs-toggle="collapse" href="#ui-basic-task" aria-expanded="false" aria-controls="ui-basic-task">
            <span class="menu-title">Lịch Trình</span>
            <i class="menu-arrow"></i>
            <i class="mdi mdi-clipboard-text menu-icon"></i>
        </a>
        <div class="collapse" id="ui-basic-task">
            <ul class="nav flex-column sub-menu">
                <security:authorize access="hasAnyRole('ROLE_ADMIN','ROLE_MANAGER')">
                    <li class="nav-item">
                        <a class="nav-link" href="<c:url value='/admin/task/add'/>">Thêm Lịch Trình</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="<c:url value='/admin/task/list-task-ad'/>">Danh sách Task</a>
                    </li>
                </security:authorize>
                <security:authorize access="hasRole('ROLE_EMPLOYEE')">
                 <li class="nav-item">
                        <a class="nav-link" href="<c:url value='/admin/task/list-task-employee'/>">Lịch Nhân Viên</a>
                </li>
                </security:authorize>
            </ul>
        </div>
    </li>
</security:authorize>

<!-- QL Mã Giảm -->
<security:authorize access="hasAnyRole('ROLE_ADMIN','ROLE_MANAGER','ROLE_EMPLOYEE')">
    <li class="nav-item">
        <a class="nav-link" data-bs-toggle="collapse" href="#ui-basic-coupon" aria-expanded="false" aria-controls="ui-basic-coupon">
            <span class="menu-title">Mã Giảm</span>
            <i class="menu-arrow"></i>
            <i class="mdi mdi-clipboard-text menu-icon"></i>
        </a>
        <div class="collapse" id="ui-basic-coupon">
            <ul class="nav flex-column sub-menu">
                <li class="nav-item">
                    <a class="nav-link" href="<c:url value='/admin/coupon/list'/>">Liệt Kê Mã Giảm</a>
                </li>
                    <li class="nav-item">
                        <a class="nav-link" href="<c:url value='/admin/coupon/add'/>">Thêm Mã Giảm</a>
                    </li>
            </ul>
        </div>
    </li>
</security:authorize>

        <!-- QL FAQ -->
<security:authorize access="hasAnyRole('ROLE_ADMIN','ROLE_MANAGER' ,'ROLE_EMPLOYEE')">
        <li class="nav-item">
            <a class="nav-link" data-bs-toggle="collapse" href="#ui-basic-question" aria-expanded="false" aria-controls="ui-basic-question">
                <span class="menu-title">FAQ</span>
                <i class="menu-arrow"></i>
                <i class="mdi mdi-clipboard-text menu-icon"></i>
            </a>
            <div class="collapse" id="ui-basic-question">
                <ul class="nav flex-column sub-menu">
                    <li class="nav-item">
                        <a class="nav-link" href="<c:url value='/admin/questions/list'/>">Danh sách câu hỏi</a>
                    </li>
                </ul>
            </div>
        </li>
</security:authorize>

</nav>

