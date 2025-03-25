package zooproject.converter;

import org.modelmapper.ModelMapper;
import org.springframework.stereotype.Component;

import zooproject.dto.InforDTO;
import zooproject.entity.InforEntity;


@Component
public class InforConverter {
	ModelMapper modelMapper = new ModelMapper();

	public InforDTO toDto(InforEntity entity) {
		if (entity != null) {
			InforDTO dto = modelMapper.map(entity, InforDTO.class);
			return dto;
		} else {
			return null;
		}

	}

	public InforEntity toEntity(InforDTO toDto) {
		if (toDto != null) {
			InforEntity entity = modelMapper.map(toDto, InforEntity.class);
			return entity;
		} else {
			return null;
		}
	}
	
}
