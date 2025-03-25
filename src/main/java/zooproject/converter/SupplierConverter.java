package zooproject.converter;

import org.modelmapper.ModelMapper;
import org.springframework.stereotype.Component;

import zooproject.dto.SupplierDTO;
import zooproject.entity.SupplierEntity;

@Component
public class SupplierConverter {
	ModelMapper modelMapper = new ModelMapper();

	public SupplierDTO toDto(SupplierEntity entity) {
		if (entity != null) {
			SupplierDTO dto = modelMapper.map(entity, SupplierDTO.class);
			return dto;
		} else {
			return null;
		}

	}

	public SupplierEntity toEntity(SupplierDTO toDto) {
		if (toDto != null) {
			SupplierEntity entity = modelMapper.map(toDto, SupplierEntity.class);
			return entity;
		} else {
			return null;
		}
	}
}
