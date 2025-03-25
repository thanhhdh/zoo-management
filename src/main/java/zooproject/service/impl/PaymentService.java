package zooproject.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import zooproject.converter.PaymentConverter;
import zooproject.dto.PaymentDTO;
import zooproject.entity.PaymentEntity;
import zooproject.repository.PaymentRepository;
import zooproject.service.IPaymentService;

@Service
public class PaymentService implements IPaymentService {
	@Autowired
	private PaymentConverter paymentConverter;
	
	@Autowired
	private PaymentRepository paymentRepository;
	@Override
	public PaymentEntity insert(PaymentEntity paymentEntity) {
		
		return paymentRepository.save(paymentEntity);
	}

}
