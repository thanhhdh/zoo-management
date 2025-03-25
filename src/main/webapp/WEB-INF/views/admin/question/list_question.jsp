<%--
  Created by IntelliJ IDEA.
  User: hdhth
  Date: 12/10/2024
  Time: 12:16 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/common/taglib.jsp"%>


<div class="content-wrapper">
    <div class="page-header">
        <h3 class="page-title">
            <span class="page-title-icon bg-gradient-primary text-white me-2">
                <i class="mdi mdi-crosshairs-gps"></i>
            </span> Quản Lý Câu Hỏi
        </h3>
        <nav aria-label="breadcrumb">
            <ul class="breadcrumb">
                <li class="breadcrumb-item active" aria-current="page">
                    <i class="mdi mdi-timetable"></i> <span>Danh Sách Câu Hỏi</span>
                </li>
            </ul>
        </nav>
    </div>
    <div class="col-md-12 grid-margin stretch-card">
        <div class="card">
            <div class="card-body">
                <table class="table-bordered table">
                    <thead>
                    <tr>
                        <th style="font-weight: bold;">#STT</th>
                        <th style="font-weight: bold;">Tên Người Gửi</th>
                        <th style="font-weight: bold;">Email</th>
                        <th style="font-weight: bold;">Nội Dung Câu Hỏi</th>
                        <th style="font-weight: bold;">Trạng Thái</th>
                        <th style="font-weight: bold;">Phản Hồi</th>

                        <th style="font-weight: bold;">Thao Tác</th>
                    </tr>
                    </thead>
                    <tbody>
                    <c:if test="${not empty questions}">
                        <c:forEach var="item" items="${questions.listResult}">
                            <tr>
                                <td>${item.id}</td>
                                <td style="max-width: 150px; word-wrap: break-word;">${item.name}</td>
                                <td style="max-width: 200px; word-wrap: break-word;">${item.email}</td>
                                <td style="max-width: 300px; word-wrap: break-word;">${item.content}</td>
                                <td style="max-width: 300px; word-wrap: break-word;">
                                    <c:choose>
                                        <c:when test="${item.status == 'Replied'}">
                                            <span class="text-success" style="font-weight: bold;">Đã Phản Hồi</span>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="text-warning" style="font-weight: bold;">Đang Chờ</span>
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                                <td style="max-width: 300px; word-wrap: break-word;">${item.response}</td>
                                <td>
                                    <button class="btn btn-primary btn-sm" data-bs-toggle="modal"
                                            data-bs-target="#replyModal-${item.id}">Trả lời</button>
                                </td>
<%--                                <td>--%>
<%--                                    <div style="display: flex;">--%>
<%--                                        <c:url var="deleteQuestion" value="/admin/questions/delete">--%>
<%--                                            <c:param name="id" value="${item.id}" />--%>
<%--                                        </c:url>--%>
<%--                                        <a href="${deleteQuestion}" class="delete-question">--%>
<%--                                            <i class="mdi mdi-delete-forever" style="color: red; margin-right: 10px; font-size: 1.2rem"></i>--%>
<%--                                        </a>--%>
<%--                                        <c:url var="viewQuestion" value="/admin/questions/view">--%>
<%--                                            <c:param name="id" value="${item.id}" />--%>
<%--                                        </c:url>--%>
<%--                                        <a href="${viewQuestion}">--%>
<%--                                            <i class="mdi mdi-open-in-new" style="color: green; margin-right: 10px; font-size: 1.2rem"></i>--%>
<%--                                        </a>--%>

<%--                                        <!-- Reply Button -->--%>
<%--                                        <c:url var="replyUrl" value="/admin/question/reply">--%>
<%--                                            <c:param name="id" value="${item.id}" />--%>
<%--                                        </c:url>--%>
<%--                                        <a href="${replyUrl}" class="btn btn-primary btn-sm">Reply</a>--%>
<%--                                    </div>--%>
<%--                                </td>--%>
                            </tr>

                            <!-- Reply Modal -->
                            <div class="modal fade" id="replyModal-${item.id}" tabindex="-1" aria-labelledby="replyModalLabel" aria-hidden="true">
                                <div class="modal-dialog">
                                    <div class="modal-content">
                                        <form action="/zooproject/admin/questions/reply" method="post">
                                            <div class="modal-header">
                                                <h5 class="modal-title" id="replyModalLabel">Trả Lời Câu Hỏi</h5>
                                                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                            </div>
                                            <div class="modal-body">
                                                <input type="hidden" name="id" value="${item.id}">
                                                <input type="hidden" name="email" value="${item.email}">
                                                <div class="mb-3">
                                                    <label for="response" class="form-label">Phản Hồi</label>
                                                    <textarea class="form-control" name="response" rows="4"></textarea>
                                                </div>
                                            </div>
                                            <div class="modal-footer">
                                                <button type="submit" class="btn btn-primary">Gửi trả lời</button>
                                                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Đóng</button>
                                            </div>
                                        </form>
                                    </div>
                                </div>
                            </div>
                        </c:forEach>
                    </c:if>
                    <c:if test="${empty questions}">
                        <tr>
                            <td colspan="5" class="text-center">Không có câu hỏi nào được gửi.</td>
                        </tr>
                    </c:if>
                    </tbody>
                </table>
                <nav class="d-flex justify-content-center pt-4" aria-label="Page navigation">
                    <ul class="pagination" id="pagination"></ul>
                </nav>
            </div>
        </div>
    </div>
</div>

<script type="text/javascript">
    var totalPages = ${questions.totalPage};
    var currentPage = ${questions.page};
    var limit = ${questions.limit};
    var page = 1;

    $(function () {
        window.pagObj = $('#pagination').twbsPagination({
            totalPages: totalPages,
            visiblePages: 3,
            startPage: currentPage,
            first: 'Đầu',
            prev: 'Trước',
            next: 'Tiếp',
            last: 'Cuối',
            onPageClick: function (event, page) {
                if (currentPage != page) {
                    window.location.href = "/zooproject/admin/questions/list?page=" + page + "&limit=" + limit;
                }
            }
        });
    });

    $(document).ready(function() {
        var deleteUrl;

        $(".delete-category").on("click", function(e) {
            e.preventDefault();
            deleteUrl = $(this).attr("href");
            $('#deleteModal').modal('show'); // Hiển thị modal
        });

        $("#confirmDelete").on("click", function() {
            window.location.href = deleteUrl; // Điều hướng đến URL xóa
        });
    });


</script>

<script type="text/javascript">
    $(document).ready(function() {
        <c:if test="${not empty message}">
        var message = "${message.message}";
        var type = "${message.type}";
        message_toastr(type, message, "Thông Báo");
        </c:if>
    });
</script>
