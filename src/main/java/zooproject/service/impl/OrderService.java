package zooproject.service.impl;

import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.time.format.TextStyle;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;
import java.util.stream.Collectors;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Service;

import org.springframework.transaction.annotation.Transactional;
import zooproject.converter.OrderConverter;
import zooproject.dto.OrderDTO;
import zooproject.entity.OrderDetailEntity;
import zooproject.entity.OrderEntity;
import zooproject.repository.OrderDetailRepository;
import zooproject.repository.OrderRepository;
import zooproject.service.IOrderService;

@Service
public class OrderService implements IOrderService{
	
	@Autowired
	private OrderRepository orderRepository;

	@Autowired
	private OrderDetailRepository orderDetailRepository;
	
	@Autowired 
	private OrderConverter orderConverter;

	@Transactional
	public void saveOrder(OrderEntity orderEntity) {
		orderRepository.save(orderEntity);
	}

	@Override
	public List<OrderDTO> listAll(Pageable pageable) {
	    List<OrderDTO> orderDTOs = new ArrayList<>();

	    // Tạo Pageable mới với sắp xếp theo ID giảm dần
	    Pageable sortedPageable = new PageRequest(pageable.getPageNumber(), pageable.getPageSize(), sortByIdDesc());

	    // Lấy danh sách OrderEntity đã được phân trang và sắp xếp
	    List<OrderEntity> orderEntities = orderRepository.findAll(sortedPageable).getContent();

	    // Chuyển đổi từng OrderEntity sang OrderDTO
	    for (OrderEntity orderEntity : orderEntities) {
	        orderDTOs.add(orderConverter.toDto(orderEntity));
	    }

	    return orderDTOs;
	}

	private Sort sortByIdDesc() {
	    return  new Sort(Sort.Direction.DESC, "orderId");
	}


	
	public Integer getTotalItem() {
		// TODO Auto-generated method stub
		return (int) orderRepository.count();
	}

	@Override
	public OrderEntity listOrderDetail(String order_code) {
		OrderEntity orderEntity = orderRepository.findByOrderCode(order_code);
		return orderEntity;
	}
	@Override
	public Map<String, Integer> getOrderCountByDayOfWeek() {
        List<Object[]> results = orderRepository.findOrderCountByCreatedAt();
        Map<String, Integer> orderCountByDay = new LinkedHashMap<>();

        // Khởi tạo với các giá trị bằng 0 cho từng ngày từ thứ Hai đến Chủ Nhật
        String[] days = {"Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"};
        for (String day : days) {
            orderCountByDay.put(day, 0);
        }

        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");

        for (Object[] result : results) {
            String createdAt = (String) result[0];
            Long orderCount = (Long) result[1];

            // Chuyển đổi timestamp sang định dạng ngày
            Calendar calendar = Calendar.getInstance();
            try {
                calendar.setTime(sdf.parse(createdAt));
            } catch (Exception e) {
                e.printStackTrace();
            }

            // Lấy tên của ngày trong tuần (Thứ Hai đến Chủ Nhật)
            String dayOfWeek = new SimpleDateFormat("EEEE", Locale.ENGLISH).format(calendar.getTime());

            // Cập nhật số lượng order
            orderCountByDay.put(dayOfWeek, orderCountByDay.get(dayOfWeek) + orderCount.intValue());
        }

        return orderCountByDay;
    }

	@Override
	public OrderEntity findByOrderCode(String orderCode) {
		return orderRepository.findByOrderCode(orderCode);
	}

	@Override
	public List<OrderEntity> searchOrdersByCode(String orderCode) {
		return orderRepository.findByOrderCodeContaining(orderCode);
	}

	@Override
	public List<OrderEntity> findNewOrders(OrderEntity.OrderStatus status) {
		String timeLimit = LocalDateTime.now().minusDays(1).format(DateTimeFormatter.ISO_LOCAL_DATE_TIME);
		return orderRepository.findByStatusAndCreatedDateAfter(status, timeLimit);
	}

	@Override
	public Map<String, Long> getOrderStatistics() {
		// Đếm số lượng đơn hàng theo trạng thái
		return orderRepository.findAll().stream()
				.collect(Collectors.groupingBy(order -> order.getOrderStatus().name(), Collectors.counting()));
	}

	@Override
	public Map<String, Long> getOrderCountByMonth() {
		// Đếm số lượng đơn hàng theo tháng
		return orderRepository.findAll().stream()
				.collect(Collectors.groupingBy(
						order -> order.getCreatedAt().substring(0, 7), // Lấy tháng từ createdAt
						Collectors.counting()
				));
	}

	@Override
	public Map<String, Double> getMonthlyRevenue() {
		// Lấy các đơn hàng có trạng thái "COMPLETED"
		List<OrderEntity> completedOrders    = orderRepository.findByOrderStatus(OrderEntity.OrderStatus.COMPLETED);

		// Tính doanh thu theo tháng
		Map<String, Double> monthlyRevenue = completedOrders.stream()
				.flatMap(order -> order.getOrderDetails().stream())
				.collect(Collectors.groupingBy(
						detail ->  {
							LocalDate date = detail.getOrderDate().toLocalDate();
							return date.getMonth().getDisplayName(TextStyle.FULL, Locale.forLanguageTag("vi-VN"))
									+ " " + date.getYear();
						}, // Lấy tháng từ orderDate
						Collectors.summingDouble(detail -> detail.getTicketPrice() * detail.getTicketSalesQuantity())
				));

		return monthlyRevenue;
	}

	@Override
	public Map<String, Long> getOrderCountByDay() {
		List<Object[]> results = orderRepository.countOrdersByDay();
		Map<String, Long> statistics = new LinkedHashMap<>();

		for (Object[] result : results) {
			String date = result[0].toString(); // Kết quả trả về là dạng `String`
			Long count = ((Number) result[1]).longValue(); // Chuyển kiểu số về Long
			statistics.put(date, count);
		}

		return statistics;
	}


	@Override
	public List<Object[]> getOrderCountByCreatedAt() {
        return orderRepository.findOrderCountByCreatedAt();
    }
}