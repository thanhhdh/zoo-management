<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="dec"
	uri="http://www.opensymphony.com/sitemesh/decorator"%>
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>

<div class="content-wrapper">
	<!-- Header -->
	<div class="page-header">
		<h3 class="page-title">
            <span class="page-title-icon bg-gradient-primary text-white me-2">
                <i class="mdi mdi-home"></i>
            </span> Bảng Điều Khiển
		</h3>
	</div>

	<!-- Thống kê tổng quan -->
	<div class="row">
		<div class="col-md-4 stretch-card grid-margin">
			<div class="card bg-gradient-danger card-img-holder text-white shadow">
				<div class="card-body">
					<h4 class="font-weight-normal mb-3">Đơn Đặt Vé
						<i class="mdi mdi-chart-line mdi-24px float-right"></i>
					</h4>
					<h2 class="mb-5">Tổng: ${orders}</h2>
				</div>
			</div>
		</div>
		<div class="col-md-4 stretch-card grid-margin">
			<div class="card bg-gradient-info card-img-holder text-white shadow">
				<div class="card-body">
					<h4 class="font-weight-normal mb-3">Loài Trong Zoo
						<i class="mdi mdi-bookmark-outline mdi-24px float-right"></i>
					</h4>
					<h2 class="mb-5">Hiện tại: ${species}</h2>
				</div>
			</div>
		</div>
		<div class="col-md-4 stretch-card grid-margin">
			<div class="card bg-gradient-success card-img-holder text-white shadow">
				<div class="card-body">
					<h4 class="font-weight-normal mb-3">Động Vật Trong Zoo
						<i class="mdi mdi-diamond mdi-24px float-right"></i>
					</h4>
					<h2 class="mb-5">Hiện tại: ${aniaml}</h2>
				</div>
			</div>
		</div>
		<div class="col-md-4 stretch-card grid-margin">
			<div class="card bg-gradient-success card-img-holder text-white shadow">
				<div class="card-body">
					<h4 class="font-weight-normal mb-3">Khu vực Trong Zoo
						<i class="mdi mdi-diamond mdi-24px float-right"></i>
					</h4>
					<h2 class="mb-5">Hiện tại: ${areas}</h2>
				</div>
			</div>
		</div>
		<div class="col-md-4 stretch-card grid-margin">
			<div class="card bg-gradient-danger card-img-holder text-white shadow">
				<div class="card-body">
					<h4 class="font-weight-normal mb-3">Số câu hỏi Trong Zoo
						<i class="mdi mdi-diamond mdi-24px float-right"></i>
					</h4>
					<h2 class="mb-5">Hiện tại: ${questions}</h2>
				</div>
			</div>
		</div>
	</div>
	<div class="row mt-4">
		<div class="col-md-6">
			<div class="card shadow">
				<div class="card-header bg-success text-white">
					<h5 class="mb-0">Thống kê sức khỏe động vật</h5>
				</div>
				<div class="card-body">
					<ul class="list-group">
						<c:forEach var="entry" items="${animalHealthStats}">
							<li class="list-group-item d-flex justify-content-between align-items-center">
								<c:choose>
									<c:when test="${entry.key == 'HEALTHY'}">
										Khỏe mạnh
									</c:when>
									<c:when test="${entry.key == 'SICK'}">
										Đang bệnh
									</c:when>
									<c:when test="${entry.key == 'IN_QUARANTINE'}">
										Cách ly
									</c:when>
									<c:when test="${entry.key == 'UNDER_TREATMENT'}">
										Đang điều trị
									</c:when>
									<c:otherwise>
										Không xác định
									</c:otherwise>
								</c:choose>
								<span class="badge badge-primary badge-pill">${entry.value}</span>
							</li>
						</c:forEach>
					</ul>
				</div>
			</div>
		</div>
		<div class="col-md-3">
			<div class="card shadow">
				<div class="card-header bg-primary text-white">
					<h5 class="mb-0">Thống kê mã giảm giá</h5>
				</div>
				<div class="card-body">
					<p><b>Mã giảm giá còn hạn:</b> <span class="badge badge-success">${validCoupons}</span></p>
					<p><b>Mã giảm giá hết hạn:</b> <span class="badge badge-danger">${expiredCoupons}</span></p>
				</div>
			</div>
		</div>

		<div class="col-md-3">
			<div class="card shadow">
				<div class="card-header bg-warning text-white">
					<h5 class="mb-0">Thống kê mã giảm giá theo điều kiện</h5>
				</div>
				<div class="card-body">
					<ul class="list-group">
						<c:forEach var="entry" items="${couponConditionMap}">
							<li class="list-group-item d-flex justify-content-between align-items-center">
								<c:choose>
									<c:when test="${entry.key == 1}">
										Giảm giá theo %
									</c:when>
									<c:when test="${entry.key == 2}">
										Giảm giá theo số tiền
									</c:when>
									<c:otherwise>
										Điều kiện không xác định
									</c:otherwise>
								</c:choose>
								<span class="badge badge-primary badge-pill">${entry.value} mã</span>
							</li>
						</c:forEach>
					</ul>
				</div>
			</div>
		</div>
	</div>

	<!-- Thống kê doanh thu -->
	<div class="page-header mt-5">
		<h3 class="page-title">Thống Kê Doanh Thu Hàng Tháng</h3>
	</div>
	<div class="row">
		<div class="col-md-6">
			<!-- Bảng thống kê doanh thu -->
			<div class="card">
				<div class="card-body">
					<table class="table table-striped table-bordered">
						<thead class="table-primary">
						<tr>
							<th style="text-align: center;">Tháng</th>
							<th style="text-align: center;">Doanh Thu (VNĐ)</th>
						</tr>
						</thead>
						<tbody>
						<c:forEach var="month" items="${months}" varStatus="status">
							<tr>
								<td style="text-align: center;">${month}</td>
								<td style="text-align: center;">${revenues[status.index]}</td>
							</tr>
						</c:forEach>
						</tbody>
					</table>
				</div>
			</div>

		</div>
		<div class="col-md-6">
			<!-- Biểu đồ doanh thu -->
			<div class="card">
				<div class="card-body">
					<canvas id="revenueChart"></canvas>
				</div>
			</div>
		</div>
	</div>



<%-- thong ke don hang	--%>
	<div class="page-header">
		<h3 class="page-title">Thống Kê Đơn Vé</h3>
	</div>
	<div class="row">
		<div class="col-md-6">
			<div class="card">
				<div class="card-header">
					<h5>Thống kê trạng thái vé</h5>
				</div>
				<div class="card-body">
					<canvas id="orderStatusChart"></canvas>
				</div>
			</div>
		</div>
		<div class="col-md-6">
			<div class="card">
				<div class="card-header">
					<h5>Thống kê lượng vé theo tháng</h5>
				</div>
				<div class="card-body">
					<canvas id="orderMonthlyChart"></canvas>
				</div>
			</div>
		</div>
	</div>

	<div class="row mt-5">
		<div class="col-md-6">
			<div class="card">
				<div class="card-header">
					<h5>Thống kê đơn vé theo ngày</h5>
				</div>
				<div class="card-body">
					<canvas id="orderDailyChart"></canvas>
				</div>
			</div>
		</div>
		<!-- Biểu đồ tần suất đặt vé trong tuần -->
		<div class="col-md-6">
			<h4>Tần Suất Đặt Vé Trong Tuần</h4>
			<div class="card">
				<div class="card-body">
					<canvas id="orderChart"></canvas>
				</div>
			</div>
		</div>
	</div>

	<!-- Biểu đồ thống kê -->
	<div class="row mt-4">
		<!-- Biểu đồ lượng thức ăn tiêu thụ -->
		<div class="col-md-6">
			<h4>Lượng Thức Ăn Tiêu Thụ</h4>
			<div class="card">
				<div class="card-body">
					<canvas id="foodChart"></canvas>
				</div>
			</div>
		</div>
		<div class="col-md-6">
			<h4>Biểu Đồ Thống Kê Thức Ăn</h4>
			<div class="card">
				<div class="card-body">
					<canvas id="foodCountChart"></canvas>
				</div>
			</div>
		</div>


	</div>

	<!-- Biểu đồ số lượng loài -->
	<div class="row mt-4">
		<div class="col-md-4">
			<h4>Số Lượng Loài</h4>
			<div class="card">
				<div class="card-body">
					<canvas id="speciesChart" width="200" height="200"></canvas>
				</div>
			</div>
		</div>
	</div>
</div>

<script>
	// Lấy canvas của biểu đồ doanh thu
	const revenueCtx = document.getElementById('revenueChart').getContext('2d');

	// Biểu đồ doanh thu theo tháng
	const revenueChart = new Chart(revenueCtx, {
		type: 'bar',
		data: {
			labels: [
				<c:forEach var="month" items="${months}">
				'${month}',
				</c:forEach>
			],
			datasets: [{
				label: 'Doanh Thu (VNĐ)',
				data: [
					<c:forEach var="revenue" items="${revenues}">
					${revenue},
					</c:forEach>
				],
				backgroundColor: 'rgba(75, 192, 192, 0.2)',
				borderColor: 'rgba(75, 192, 192, 1)',
				borderWidth: 1
			}]
		},
		options: {
			responsive: true,
			plugins: {
				legend: {
					position: 'top'
				},
				title: {
					display: true,
					text: 'Doanh Thu Theo Tháng'
				}
			},
			scales: {
				y: {
					beginAtZero: true
				}
			}
		}
	});
</script>

<script>
	// Lấy canvas của biểu đồ lượng thức ăn tiêu thụ
	const foodCtx = document.getElementById('foodChart').getContext('2d');

	// Biểu đồ lượng thức ăn tiêu thụ
	const foodChart = new Chart(foodCtx, {
		type: 'bar',
		data: {
			labels: [
				<c:forEach var="foodKey" items="${foodMap.keySet()}">
				'${foodKey}',
				</c:forEach>
			],
			datasets: [{
				label: 'Lượng Thức Ăn',
				data: [
					<c:forEach var="quantity" items="${foodMap.values()}">
					${quantity},
					</c:forEach>
				],
				backgroundColor: 'rgba(75, 192, 192, 0.2)',
				borderColor: 'rgba(75, 192, 192, 1)',
				borderWidth: 1
			}]
		},
		options: {
			responsive: true,
			scales: {
				y: {
					beginAtZero: true
				}
			}
		}
	});
</script>

<script>
	document.addEventListener("DOMContentLoaded", function () {
		fetch("/zooproject/admin/dashboard/food-statistics")
				.then(response => response.json())
				.then(data => {
					const foodLabels = Object.keys(data.foodStats);
					const foodQuantities = Object.values(data.foodStats);

					const ctx = document.getElementById('foodCountChart').getContext('2d');
					new Chart(ctx, {
						type: 'bar',
						data: {
							labels: foodLabels,
							datasets: [{
								label: 'Số Lượng Thức Ăn',
								data: foodQuantities,
								backgroundColor: 'rgba(75, 192, 192, 0.2)',
								borderColor: 'rgba(75, 192, 192, 1)',
								borderWidth: 1
							}]
						},
						options: {
							scales: {
								y: { beginAtZero: true }
							},
							plugins: {
								legend: { display: false },
								title: { display: true, text: 'Thống Kê Số Lượng Thức Ăn' }
							}
						}
					});
				})
				.catch(error => console.error('Lỗi khi tải dữ liệu:', error));
	});
</script>
<script>
	// Lấy canvas của biểu đồ đặt vé
	const orderCtx = document.getElementById('orderChart').getContext('2d');

	// Biểu đồ tần suất đặt vé
	const orderChart = new Chart(orderCtx, {
		type: 'bar',
		data: {
			labels: ['Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday'],
			datasets: [{
				label: 'Tần Suất Đặt Vé',
				data: [
					<c:out value="${orderCountMap['Monday']}"/>,
					<c:out value="${orderCountMap['Tuesday']}"/>,
					<c:out value="${orderCountMap['Wednesday']}"/>,
					<c:out value="${orderCountMap['Thursday']}"/>,
					<c:out value="${orderCountMap['Friday']}"/>,
					<c:out value="${orderCountMap['Saturday']}"/>,
					<c:out value="${orderCountMap['Sunday']}"/>
				],
				backgroundColor: 'rgba(75, 192, 192, 0.2)',
				borderColor: 'rgba(75, 192, 192, 1)',
				borderWidth: 1
			}]
		},
		options: {
			responsive: true,
			scales: {
				y: {
					beginAtZero: true
				}
			}
		}
	});
</script>

<script>
	// Lấy canvas của biểu đồ số lượng loài
	const speciesCtx = document.getElementById('speciesChart').getContext('2d');

	// Biểu đồ số lượng loài
	const speciesChart = new Chart(speciesCtx, {
		type: 'pie',
		data: {
			labels: [
				<c:forEach var="speciesKey" items="${speciesCountMap.keySet()}">
				'${speciesKey}',
				</c:forEach>
			],
			datasets: [{
				label: 'Số Lượng Loài',
				data: [
					<c:forEach var="quantity" items="${speciesCountMap.values()}">
					${quantity},
					</c:forEach>
				],
				backgroundColor: [
					'rgba(255, 99, 132, 0.2)',
					'rgba(54, 162, 235, 0.2)',
					'rgba(255, 206, 86, 0.2)',
					'rgba(75, 192, 192, 0.2)',
					'rgba(153, 102, 255, 0.2)',
					'rgba(255, 159, 64, 0.2)'
				],
				borderColor: [
					'rgba(255, 99, 132, 1)',
					'rgba(54, 162, 235, 1)',
					'rgba(255, 206, 86, 1)',
					'rgba(75, 192, 192, 1)',
					'rgba(153, 102, 255, 1)',
					'rgba(255, 159, 64, 1)'
				],
				borderWidth: 1
			}]
		},
		options: {
			responsive: true,
			plugins: {
				legend: {
					position: 'top'
				},
				tooltip: {
					callbacks: {
						label: function (tooltipItem) {
							var label = tooltipItem.label || '';
							if (label) {
								label += ': ' + tooltipItem.raw;
							}
							return label;
						}
					}
				}
			}
		}
	});
</script>


<%--Thong ke don hang--%>

<script>
	document.addEventListener("DOMContentLoaded", function () {
		fetch("/zooproject/admin/dashboard/order-statistics")
				.then(response => {
					if (!response.ok) {
						throw new Error(`HTTP error! status: ${response.status}`);
					}
					return response.json();
				})
				.then(data => {
					console.log("Dữ liệu thống kê đơn hàng:", data);
					// Dữ liệu cho biểu đồ trạng thái đơn hàng
					const statusLabels = Object.keys(data.statusStatistics);
					const statusData = Object.values(data.statusStatistics);

					const statusCtx = document.getElementById('orderStatusChart').getContext('2d');
					new Chart(statusCtx, {
						type: 'pie',
						data: {
							labels: statusLabels,
							datasets: [{
								data: statusData,
								backgroundColor: ['#FF6384', '#36A2EB', '#FFCE56'],
							}]
						},
						options: {
							plugins: {
								legend: { position: 'top' },
								title: { display: true, text: 'Thống Kê Trạng Thái Đơn Hàng' }
							}
						}
					});

					// Dữ liệu cho biểu đồ đơn hàng theo tháng
					const monthlyLabels = Object.keys(data.monthlyStatistics);
					const monthlyData = Object.values(data.monthlyStatistics);

					const monthlyCtx = document.getElementById('orderMonthlyChart').getContext('2d');
					new Chart(monthlyCtx, {
						type: 'bar',
						data: {
							labels: monthlyLabels,
							datasets: [{
								label: 'Số Lượng Đơn Vé',
								data: monthlyData,
								backgroundColor: 'rgba(75, 192, 192, 0.2)',
								borderColor: 'rgba(75, 192, 192, 1)',
								borderWidth: 1
							}]
						},
						options: {
							plugins: {
								legend: { display: false },
								title: { display: true, text: 'Số Lượng Đơn Hàng Theo Tháng' }
							},
							scales: {
								y: { beginAtZero: true }
							}
						}
					});

					// Biểu đồ đơn hàng theo ngày
					const dailyLabels = Object.keys(data.dailyStatistics);
					const dailyData = Object.values(data.dailyStatistics);
					const dailyCtx = document.getElementById('orderDailyChart').getContext('2d');
					new Chart(dailyCtx, {
						type: 'line',
						data: {
							labels: dailyLabels,
							datasets: [{
								label: 'Số Lượng Đơn Hàng',
								data: dailyData,
								borderColor: 'rgba(54, 162, 235, 1)',
								backgroundColor: 'rgba(54, 162, 235, 0.2)',
								borderWidth: 2,
								fill: true
							}]
						},
						options: {
							plugins: {
								legend: { position: 'top' },
								title: { display: true, text: 'Số Lượng Đơn Hàng Theo Ngày' }
							},
							scales: {
								x: { beginAtZero: true },
								y: { beginAtZero: true }
							}
						}
					});

				})
				.catch(error => {
					console.error("Lỗi khi tải thống kê đơn hàng:", error);
					alert("Không thể tải thống kê đơn hàng. Vui lòng kiểm tra API!");
				});
	});

</script>











