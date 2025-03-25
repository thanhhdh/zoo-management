package zooproject.converter;

import org.modelmapper.ModelMapper;
import org.springframework.stereotype.Component;

import zooproject.dto.SpeciesDTO;
import zooproject.entity.SpeciesEntity;


@Component
public class SpeciesConverter {
	ModelMapper modelMapper = new ModelMapper();

	public SpeciesDTO toDto(SpeciesEntity entity) {
		if (entity != null) {
			SpeciesDTO dto = modelMapper.map(entity, SpeciesDTO.class);
			return dto;
		} else {
			return null;
		}

	}

	public SpeciesEntity toEntity(SpeciesDTO toDto) {
		if (toDto != null) {
			SpeciesEntity entity = modelMapper.map(toDto, SpeciesEntity.class);
			return entity;
		} else {
			return null;
		}
	}
}
