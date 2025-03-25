package zooproject.service;

import java.util.List;

import zooproject.entity.OrderDetailEntity;

public interface IOrderDetailService {
	void saveOrderDetail(OrderDetailEntity orderDetailEntity);

	List<OrderDetailEntity> listOrderDetailById(String orderCode);

	List<OrderDetailEntity> findByOrderCode(String orderCode);
}
