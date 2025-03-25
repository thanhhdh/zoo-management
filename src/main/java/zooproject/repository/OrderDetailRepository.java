package zooproject.repository;

import java.util.List;

import javax.transaction.Transactional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.stereotype.Repository;

import zooproject.entity.OrderDetailEntity;
import zooproject.entity.OrderEntity;

@Repository
public interface OrderDetailRepository extends JpaRepository<OrderDetailEntity, Long>{
	@Transactional
	@Modifying
	List<OrderDetailEntity> findByOrderCode(String orderCode);

}
