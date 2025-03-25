package zooproject.converter;

import org.modelmapper.ModelMapper;
import org.springframework.stereotype.Component;

import zooproject.dto.PaymentDTO;
import zooproject.entity.PaymentEntity;


@Component
public class PaymentConverter {
	ModelMapper modelMapper = new ModelMapper();

	public PaymentDTO toDto(PaymentEntity entity) {
		if (entity != null) {
			PaymentDTO dto = modelMapper.map(entity, PaymentDTO.class);
			return dto;
		} else {
			return null;
		}

	}

	public PaymentEntity toEntity(PaymentDTO toDto) {
		if (toDto != null) {
			PaymentEntity entity = modelMapper.map(toDto, PaymentEntity.class);
			return entity;
		} else {
			return null;
		}
	}
}
