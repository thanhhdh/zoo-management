<%--
  Created by IntelliJ IDEA.
  User: hdhth
  Date: 12/10/2024
  Time: 1:18 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/common/taglib.jsp"%>

<div class="container mt-5">
    <h1>View Question</h1>
    <div class="mb-3">
        <strong>Name:</strong> ${question.name}
    </div>
    <div class="mb-3">
        <strong>Email:</strong> ${question.email}
    </div>
    <div class="mb-3">
        <strong>Question:</strong>
        <p>${question.content}</p>
    </div>
    <a href="/admin/questions/list" class="btn btn-secondary">Back to List</a>
</div>
