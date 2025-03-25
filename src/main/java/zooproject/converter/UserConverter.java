package zooproject.converter;

import org.modelmapper.ModelMapper;
import org.springframework.stereotype.Component;

import zooproject.dto.UserDTO;
import zooproject.entity.UserEntity;


@Component
public class UserConverter {
	ModelMapper modelMapper = new ModelMapper();

	public UserDTO toDto(UserEntity entity) {
		if (entity != null) {
			UserDTO dto = modelMapper.map(entity, UserDTO.class);
			return dto;
		} else {
			return null;
		}

	}

	public UserEntity toEntity(UserDTO toDto) {
		if (toDto != null) {
			UserEntity entity = modelMapper.map(toDto, UserEntity.class);
			return entity;
		} else {
			return null;
		}
	}
}
