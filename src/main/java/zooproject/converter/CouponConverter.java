package zooproject.converter;

import org.modelmapper.ModelMapper;
import org.springframework.stereotype.Component;

import zooproject.dto.CouponDTO;
import zooproject.entity.CouponEntity;


@Component
public class CouponConverter {
	ModelMapper modelMapper = new ModelMapper();

	public CouponDTO toDto(CouponEntity entity) {
		if (entity != null) {
			CouponDTO dto = modelMapper.map(entity, CouponDTO.class);
			return dto;
		} else {
			return null;
		}

	}

	public CouponEntity toEntity(CouponDTO toDto) {
		if (toDto != null) {
			CouponEntity entity = modelMapper.map(toDto, CouponEntity.class);
			return entity;
		} else {
			return null;
		}
	}
}
