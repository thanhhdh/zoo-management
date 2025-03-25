package zooproject.converter;

import org.modelmapper.ModelMapper;
import org.springframework.stereotype.Component;

import zooproject.dto.MedicalDTO;
import zooproject.entity.MedicalEntity;

import java.util.Collections;
import java.util.List;
import java.util.stream.Collectors;

@Component
public class MedicalConverter {
	ModelMapper modelMapper = new ModelMapper();

	public MedicalDTO toDto(MedicalEntity entity) {
		if (entity != null) {
			MedicalDTO dto = modelMapper.map(entity, MedicalDTO.class);
			return dto;
		} else {
			return null;
		}
	}

	public MedicalEntity toEntity(MedicalDTO toDto) {
		if (toDto != null) {
			MedicalEntity entity = modelMapper.map(toDto, MedicalEntity.class);
			return entity;
		} else {
			return null;
		}
	}

}
