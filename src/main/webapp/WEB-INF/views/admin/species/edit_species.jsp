<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="/common/taglib.jsp"%>
<c:url var="postURL" value="/admin/species/update"></c:url>
<c:url var="urlImg" value="/template/web/img/species/"></c:url>
<div class="content-wrapper">
    <div class="page-header">
        <h3 class="page-title">
			<span class="page-title-icon bg-gradient-primary text-white me-2">
				<i class="mdi mdi-crosshairs-gps"></i>
			</span> Chỉnh Sửa Loài
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
                <s:form class="forms-sample" id="form-category"
                        modelAttribute="species" action="${postURL}" method="post"
                        enctype="multipart/form-data">
                    <input type="hidden" name="id" value="${species.id}">
                    <div class="form-group">
                        <label for="exampleInputUsername1">Tên Loài</label> <input
                            name="speciesName" value="${species.speciesName}"  type="text" class="form-control"
                            id="name_category" placeholder="Điền tên thể loại"> <span
                            class="form-message text-danger"></span>
                    </div>

                    <div class="form-group">
                        <label for="exampleInputUsername1">Mô Tả Loài</label> <input
                            name="specieDesc" value="${species.specieDesc}" type="text" class="form-control"
                            id="name_category" placeholder="Điền mô tả loài"> <span
                            class="form-message text-danger"></span>
                    </div>

                    <div class="form-group">
                        <label for="exampleInputUsername1">Hình Ảnh Mô Tả</label> <br>
                        <input
                            name="imgage" type="file" class="form-control"
                            id="image_category"> <span
                            class="form-message text-danger"></span>
                    </div>

                    <div class="form-group">
                        <label for="exampleInputUsername1">Phân Bổ </label> <input
                            name="speciesAllocation" value="${species.speciesAllocation}" type="text" class="form-control"
                            id="name_category" placeholder="Điền phân bổ loài"> <span
                            class="form-message text-danger"></span>
                    </div>

                    <div class="form-group">
                        <label for="exampleInputUsername1">Sinh Sản </label> <input
                            name="speciesReproduction" value="${species.speciesReproduction}" type="text" class="form-control"
                            id="name_category" placeholder="Điền sinh sản của loài">
                        <span class="form-message text-danger"></span>
                    </div>

                    <div class="form-group">
                        <label for="exampleInputUsername1">Sinh Thái</label> <input
                            name="speciesEcological" value="${species.speciesEcological}" type="text" class="form-control"
                            id="name_category" placeholder="Điền sinh sản của loài">
                        <span class="form-message text-danger"></span>
                    </div>

                    <div class="form-group">
                        <label for="speciesStatus">Hiển Thị</label>
                        <div>
                            <select name="speciesStatus" id="" class="form-control"
                                    id="speciesStatus">
                                <option value="1" ${species.speciesStatus == 1 ? 'selected' : ''}>Hiển thị</option>
                                <option value="0" ${species.speciesStatus == 0 ? 'selected' : ''}>Ẩn</option>
                            </select>
                        </div>
                    </div>

                    <button type="submit"
                            class="btn btn-gradient-primary btn-lg add-category">Thêm</button>
                    <a href="/zooproject/admin/species/list" class="btn btn-light btn-lg">
                        <i class="mdi mdi-arrow-left"></i> Quay Lại
                    </a>
                </s:form>
            </div>
        </div>
    </div>
</div>