<%@ taglib prefix="label" uri="http://www.springframework.org/tags/form" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@include file="/common/taglib.jsp"%>

<c:url var="postURL" value="/admin/species/detail"></c:url>
<c:url var="urlImg" value="/template/web/img/species/"></c:url>

<div class="content-wrapper">
    <div class="page-header">
        <h3 class="page-title">
			<span class="page-title-icon bg-gradient-primary text-white me-2">
				<i class="mdi mdi-crosshairs-gps"></i>
			</span> Chi Tiết Loài
        </h3>
        <nav aria-label="breadcrumb">
            <ul class="breadcrumb">
                <li class="breadcrumb-item active" aria-current="page"><i
                        class="mdi mdi-timetable"></i> <span></span></li>
            </ul>
        </nav>
    </div>

    <div class="col-md-12 grid-margin stretch-card">
        <div class="card">
            <div class="card-body">
                <div class="row">
                    <div class="col-md-6">
                        <div>
                            <p><strong>TÊN LOÀI : </strong>${species.speciesName}</p>
                            <p><strong>MÔ TẢ LOÀI : </strong></p>
                            <p>${species.specieDesc}</p>
                            <p><strong>PHÂN BỐ : </strong>${species.speciesAllocation}</p>
                            <p><strong>SINH SẢN : </strong>${species.speciesReproduction}</p>
                            <p><strong>SINH THÁI : </strong>${species.speciesEcological}</p>
                        </div>
                    </div>
                    <div class="col-md-6">
                        <div>
                            <img class="img-fluid" src="${urlImg}${species.speciesImage}"/>
                        </div>
                    </div>
                </div>

            </div>
        </div>
    </div>
</div>
