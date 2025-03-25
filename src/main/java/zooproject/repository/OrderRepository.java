package zooproject.repository;

import java.time.LocalDateTime;
import java.util.List;

import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import zooproject.entity.OrderEntity;

@Repository
public interface OrderRepository extends JpaRepository<OrderEntity, Long>{
	OrderEntity findByOrderCode(String orderCode);


	@Query("SELECT o.createdAt, COUNT(o) FROM OrderEntity o GROUP BY o.createdAt")
	List<Object[]> findOrderCountByCreatedAt();


	List<OrderEntity> findByOrderCodeContaining(String orderCode);

	@Query("SELECT o FROM OrderEntity o WHERE o.orderStatus = :status AND o.createdAt >= :timeLimit")
	List<OrderEntity> findByStatusAndCreatedDateAfter(
			@Param("status") OrderEntity.OrderStatus status,
			@Param("timeLimit") String timeLimit);

	List<OrderEntity> findByOrderStatus(OrderEntity.OrderStatus orderStatus);

	@Query(value = "SELECT DATE(o.created_at) AS orderDate, COUNT(o.order_id) AS orderCount " +
			"FROM tbl_order o " +
			"GROUP BY DATE(o.created_at) " +
			"ORDER BY orderDate ASC", nativeQuery = true)
	List<Object[]> countOrdersByDay();
}
