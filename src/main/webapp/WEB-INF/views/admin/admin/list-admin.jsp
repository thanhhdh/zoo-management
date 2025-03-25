<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="dec" uri="http://www.opensymphony.com/sitemesh/decorator"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>  
 
 <c:url var="loadData" value="/admin/account-admin/load-table-admin"></c:url> 
 <c:url var="assignRoles" value="/admin/account-admin/assign-roles"></c:url> 
 <c:url var="deleteAdmin" value="/admin/account-admin/delete"></c:url> 
 
 
 <c:if test="${not empty userDTO.alertInfo}">
            <script>
                message_toastr("${userDTO.alertInfo.type}", "${userDTO.alertInfo.message}");
            </script>
        </c:if>
 
 <div class="content-wrapper">
    <div class="page-header">
        <h3 class="page-title">
            <span class="page-title-icon bg-gradient-primary text-white me-2">
                <i class="mdi mdi-book-variant"></i>
            </span> Quản Lý Tài Khoản
        </h3>
        <nav aria-label="breadcrumb">
            <ul class="breadcrumb">
                <li class="breadcrumb-item active" aria-current="page">
                    <i class="mdi mdi-timetable"></i>
                    <span><?php
                    $today = date('d/m/Y');
                    echo $today;
                    ?></span>
                </li>
            </ul>
        </nav>
    </div>

    <div class="col-lg-12 grid-margin stretch-card">
        <div class="card">
            <div class="card-body">
                <div style="display: flex;justify-content: space-between">
                    <div class="card-title col-sm-9">Bảng Danh Sách Admin</div>
                    <div class="col-sm-3">
                        <div class="input-group">
                            <input id="search" type="text" class="form-control" name="search"
                                placeholder="Tìm Kiếm Tên Admin Hoặc Email">
                            <button type="button" class="btn-md btn-inverse-success btn-icon">
                                <i class="mdi mdi-account-search"></i>
                            </button>
                        </div>
                    </div>
                </div>
                <table style="margin-top:20px " class="table table-bordered table-sort">
                    <thead>
                        <tr>
                            <th> STT </th>
                            <th> Tên Người Dùng </th>
                            <th> Tên Tài Khoản </th>
                            <th> Email </th>
                            <th> Quản Trị </th>
                            <th> Quản Lý </th>
                            <th> Nhân Viên </th>
                            <th> Thao Tác </th>
                        </tr>
                    </thead>
                    <tbody id="load_table_admin">

                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>

 <script src="https://cdn.jsdelivr.net/npm/table-sort-js/table-sort.min.js"></script>

    <script>
    
   
    
        loading_table_admin();
        
/*         Swal.fire({
        	  title: "Do you want to save the changes?",
        	  showDenyButton: true,
        	  showCancelButton: true,
        	  confirmButtonText: "Save",
        	  denyButtonText: `Don't save`
        	}).then((result) => {
        	  if (result.isConfirmed) {
        	    Swal.fire("Saved!", "", "success");
        	  } else if (result.isDenied) {
        	    Swal.fire("Changes are not saved", "", "info");
        	  }
        	}); */

        function loading_table_admin() {
            $.ajax({
                url: '${loadData}',
                method: 'get',
                data: {},
                success: function(data) {
                    $('#load_table_admin').html(data);
                },
                error: function() {
                    alert("Bug Huhu :<<");
                }
            })
        }
    </script>
    <script>
        $(document).on('click', '.form-check-input', function() {
         
            var admin_id = $(this).data('admin_id');
            var index_roles = $('input[type="radio"][name="roles' + admin_id + '"]:checked').val();
           	console.log(admin_id+"");
            $.ajax({
                url: '${assignRoles}',
                method: 'GET',
                data: {
                    admin_id: admin_id,
                    index_roles: index_roles,
                },
                success: function(data) {
                    loading_table_admin()
                    if (data == "ROLE_ADMIN") {
                        message_toastr("success", "Cấp Quyền Quản Trị Thành Công!", "Thông báo");
                    } else if (data == "ROLE_MANAGER") {
                        message_toastr("success", "Cấp Quyền Quản Lý Thành Công!", "Thông báo");
                    } else if (data == "ROLE_EMPLOYEE") {
                        message_toastr("success", "Cấp Quyền Nhân Viên Thành Công!", "Thông báo");
                    } else if (data = "permission_error") {
                        message_toastr("warning",
                            "Quản Trị Viên Không Thể Tự Cấp Lại Quyền Cho Chính Mình!",
                            "Oh Noooooo!");
                    }else{
                    	 message_toastr("error",data,"Oh Noooooo!");
                    }
                },
                error: function(e) {
                    alert("Bug : "+e);
                }
            })

        });
        

        
         $(document).on('click', '.btn-delete-admin-roles', function() {  
            var admin_id = $(this).data('admin_id');
            Swal.fire({
          	  title: "Bạn có chắc chắn không?",
          	  text: "Bạn sẽ không thể hoàn tác điều này!",
          	  icon: "warning",
          	  showCancelButton: true,
          	  confirmButtonColor: "#3085d6",
          	  cancelButtonColor: "#d33",
              cancelButtonText: "Hủy",
          	  confirmButtonText: "Đồng ý!"
          	}).then((result) => {
          	  if (result.isConfirmed) {
                  
                  $.ajax({
                      url: '${deleteAdmin}',
                      method: 'get',
                      data: {
                          admin_id: admin_id,
                      },
                      success: function(data) {
                          loading_table_admin()
                          if (data == "error_delete_admin") {
                              message_toastr("warning",
                                  "Quản Trị Viên Không Thể Tự Xóa Chính Mình!",
                                  "Oh Noooooo!");
                          } else if (data == "true") {
                              message_toastr("success", "Đã Xóa Thành Công!", "Thông báo");
                          }
                      },
                      error: function() {
                          alert("Bug Huhu :<<");
                      }
                  })
                  
          	  }
          	});


        });

        $(document).ready(function() {
            // Khi người dùng nhấn phím trong ô tìm kiếm
            $('#search').on('keyup', function() {
                performSearch(); // Gọi hàm tìm kiếm
            });

            // Khi người dùng nhấn nút tìm kiếm
            $('.btn-inverse-success').on('click', function() {
                performSearch(); // Gọi hàm tìm kiếm
            });

            // Hàm tìm kiếm
            function performSearch() {
                var keyword = $('#search').val();
                $.ajax({
                    url: '/zooproject/admin/account-admin/search',  // Đảm bảo URL này đúng
                    method: 'GET',
                    data: { keyword: keyword },
                    success: function(response) {
                        $('#load_table_admin').html(response);  // Cập nhật bảng kết quả tìm kiếm
                    },
                    error: function() {
                        alert("Đã xảy ra lỗi khi tìm kiếm.");
                    }
                });
            }
        });
    </script>

