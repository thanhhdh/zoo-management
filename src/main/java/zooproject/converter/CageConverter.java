package zooproject.converter;

import org.modelmapper.ModelMapper;
import org.springframework.stereotype.Component;

import zooproject.dto.CageDTO;

import zooproject.entity.CageEntity;


@Component
public class CageConverter {
	ModelMapper modelMapper = new ModelMapper();

	public CageDTO toDto(CageEntity entity) {
		if (entity != null) {
			CageDTO dto = modelMapper.map(entity, CageDTO.class);
			return dto;
		} else {
			return null;
		}

	}

	public CageEntity toEntity(CageDTO toDto) {
		if (toDto != null) {
			CageEntity entity = modelMapper.map(toDto, CageEntity.class);
			return entity;
		} else {
			return null;
		}
	}
}
