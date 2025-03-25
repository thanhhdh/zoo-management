package zooproject.service;

import java.time.LocalDate;
import java.util.Arrays;
import java.util.List;
import java.util.Map;

import org.springframework.data.domain.Pageable;

import zooproject.dto.OrderDTO;
import zooproject.entity.OrderEntity;

public interface IOrderService {
	void saveOrder(OrderEntity orderEntity);

	List<OrderDTO> listAll(Pageable pageable);

	Integer getTotalItem();
	
	 OrderEntity listOrderDetail(String order_code);
	 
	 List<Object[]> getOrderCountByCreatedAt();

	Map<String, Integer> getOrderCountByDayOfWeek();

    OrderEntity findByOrderCode(String orderCode);

	List<OrderEntity> searchOrdersByCode(String keyword);

	List<OrderEntity> findNewOrders(OrderEntity.OrderStatus status);


	Map<String, Long> getOrderStatistics(); // Thống kê theo trạng thái
	Map<String, Long> getOrderCountByMonth(); // Thống kê số lượng đơn hàng theo tháng

	Map<String, Double> getMonthlyRevenue();

	Map<String, Long> getOrderCountByDay();
}
