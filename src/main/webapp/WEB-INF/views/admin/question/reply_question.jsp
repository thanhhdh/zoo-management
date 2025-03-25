<%--
  Created by IntelliJ IDEA.
  User: hdhth
  Date: 12/10/2024
  Time: 2:37 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/common/taglib.jsp"%>
<div class="content-wrapper">
    <div class="page-header">
        <h3 class="page-title">Reply to Question</h3>
    </div>
    <div class="col-md-12 grid-margin stretch-card">
        <div class="card">
            <div class="card-body">
                <form action="/admin/question/send-reply" method="post">
                    <input type="hidden" name="email" value="${question.email}" />
                    <input type="hidden" name="name" value="${question.name}" />
                    <input type="hidden" name="questionId" value="${question.id}" />
                    <div class="form-group">
                        <label for="content">Question</label>
                        <textarea class="form-control" readonly>${question.content}</textarea>
                    </div>
                    <div class="form-group">
                        <label for="replyContent">Your Reply</label>
                        <textarea name="replyContent" class="form-control" required></textarea>
                    </div>
                    <button type="submit" class="btn btn-success">Send Reply</button>
                    <a href="/admin/question/list" class="btn btn-light">Back</a>
                </form>
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

