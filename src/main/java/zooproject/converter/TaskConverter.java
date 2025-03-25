package zooproject.converter;

import org.modelmapper.ModelMapper;
import org.springframework.stereotype.Component;

import zooproject.dto.TaskDTO;
import zooproject.entity.TaskEntity;

@Component
public class TaskConverter {
	ModelMapper modelMapper = new ModelMapper();

	public TaskDTO toDto(TaskEntity entity) {
		if (entity != null) {
			TaskDTO dto = modelMapper.map(entity, TaskDTO.class);
			return dto;
		} else {
			return null;
		}

	}

	public TaskEntity toEntity(TaskDTO toDto) {
		if (toDto != null) {
			TaskEntity entity = modelMapper.map(toDto, TaskEntity.class);
			return entity;
		} else {
			return null;
		}
	}
}
