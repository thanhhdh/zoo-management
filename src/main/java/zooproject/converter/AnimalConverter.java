package zooproject.converter;

import org.modelmapper.ModelMapper;
import org.springframework.stereotype.Component;

import zooproject.dto.AnimalDTO;
import zooproject.entity.AnimalEntity;

@Component
public class AnimalConverter {
	ModelMapper modelMapper = new ModelMapper();

	public AnimalDTO toDto(AnimalEntity entity) {
		if (entity != null) {
			AnimalDTO dto = modelMapper.map(entity, AnimalDTO.class);
			return dto;
		} else {
			return null;
		}

	}

	public AnimalEntity toEntity(AnimalDTO toDto) {
		if (toDto != null) {
			AnimalEntity entity = modelMapper.map(toDto, AnimalEntity.class);
			return entity;
		} else {
			return null;
		}
	}
}
