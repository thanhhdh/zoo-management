package zooproject.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import zooproject.entity.OrderDetailEntity;
import zooproject.repository.OrderDetailRepository;
import zooproject.service.IOrderDetailService;

@Service
public class OrderDetailService implements IOrderDetailService {
	@Autowired
	private OrderDetailRepository orderDetailRepository;

	@Override
	public void saveOrderDetail(OrderDetailEntity orderDetailEntity) {
		orderDetailRepository.save(orderDetailEntity);
	}

	@Override
	public List<OrderDetailEntity> listOrderDetailById(String orderCode) {
		return orderDetailRepository.findByOrderCode(orderCode);
	}

	@Override
	public List<OrderDetailEntity> findByOrderCode(String orderCode) {
		return orderDetailRepository.findByOrderCode(orderCode);
	}

}
