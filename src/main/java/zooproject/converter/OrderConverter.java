package zooproject.converter;

import org.modelmapper.ModelMapper;
import org.springframework.stereotype.Component;

import zooproject.dto.OrderDTO;
import zooproject.entity.OrderEntity;


@Component
public class OrderConverter {
	ModelMapper modelMapper = new ModelMapper();

	public OrderDTO toDto(OrderEntity entity) {
		if (entity != null) {
			OrderDTO dto = modelMapper.map(entity, OrderDTO.class);
			dto.setOrderCode(entity.getOrderCode());
			dto.setCreatedAt(entity.getCreatedAt());
			return dto;
		} else {
			return null;
		}

	}

	public OrderEntity toEntity(OrderDTO toDto) {
		if (toDto != null) {
			OrderEntity entity = modelMapper.map(toDto, OrderEntity.class);
			return entity;
		} else {
			return null;
		}
	}
}
