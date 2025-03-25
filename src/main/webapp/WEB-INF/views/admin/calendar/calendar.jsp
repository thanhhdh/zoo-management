<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@include file="/common/taglib.jsp"%>
<c:url var="postURL" value="/admin/schedule/events/add"></c:url>

<div class="p-5">
    <div class="card">
        <div class="card-body p-0">
            <div id="calendar"></div>

            <!-- Modal for Event Form -->
            <div class="modal fade" id="addEventModal" tabindex="-1" role="dialog" aria-labelledby="addEventModalLabel" aria-hidden="true">
                <div class="modal-dialog" role="document">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title" id="modalTitle">Thêm sự lịch mới</h5>
                            <button type="button" class="close" data-bs-dismiss="modal" aria-label="Close">
                                <span aria-hidden="true">&times;</span>
                            </button>
                        </div>
                        <div class="modal-body">
                            <s:form id="addEventForm"   method="POST" action="${postURL}">
                                <div class="form-group">
                                    <label for="eventTitle">Tiêu đề</label>
                                    <input type="text" class="form-control" id="eventTitle" name="title" required>
                                </div>
                                <div class="form-group">
                                    <label for="startTime">Start Time</label>
                                    <input type="datetime-local" class="form-control" id="startTime" name="startTime" required>
                                </div>
                                <div class="form-group">
                                    <label for="endTime">End Time</label>
                                    <input type="datetime-local" class="form-control" id="endTime" name="endTime" required>
                                </div>
                                <div class="form-group">
                                    <label for="eventDescription">Mô tả</label>
                                    <textarea class="form-control" id="eventDescription" name="description"></textarea>
                                </div>
                                <button type="submit" class="btn btn-primary">Lưu</button>
                            </s:form>
                        </div>
                    </div>
                </div>
            </div>

        </div>
    </div>
</div>


<script type="text/javascript">
    document.addEventListener('DOMContentLoaded', function() {
        var calendarEl = document.getElementById('calendar');
        var calendar = new FullCalendar.Calendar(calendarEl, {
            headerToolbar: {
                left: 'prev,next today',
                center: 'title',
                right: 'timeGridWeek,dayGridMonth'
            },
            initialView: 'dayGridMonth',
            selectable: true,

            events: 'http://localhost:8080/zooproject/admin/schedule/events/data',
            dateClick: function(info) {
                var now = new Date();
                var currentTime = now.toTimeString().slice(0,5);

                $('#eventTitle').val('');
                $('#startTime').val(info.dateStr + 'T' + currentTime);
                $('#endTime').val('');
                $('#eventDescription').val('');

                $('#modalTitle').text('Thêm sự kiện mới');

                $('#addEventModal').modal('show');


                $('#addEventForm').attr('action', 'http://localhost:8080/zooproject/admin/schedule/events/add');

            },
            eventClick: function (info) {
                var event = info.event;
                var offset = new Date().getTimezoneOffset() * 60000;
                var startTime = new Date(event.start.getTime() - offset).toISOString().slice(0,16);
                var endTime = event.end ? new Date(event.end.getTime() - offset).toISOString().slice(0,16) : '';

                $('#eventTitle').val(event.title);
                $('#startTime').val(startTime);
                $('#endTime').val(endTime);
                $('#eventDescription').val(event.extendedProps.description);

                $('#modalTitle').text('Thay đổi kiện mới');

                $('#addEventModal').modal('show');

                $('#addEventForm').attr('action', 'http://localhost:8080/zooproject/admin/schedule/events/update/' + event.id);

            }


        });
        calendar.render();
    });
</script>


