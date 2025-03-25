package zooproject.converter;

import org.modelmapper.ModelMapper;
import org.springframework.stereotype.Component;
import zooproject.dto.AreaDTO;
import zooproject.entity.AreaEntity;

@Component
public class AreaConverter {
    ModelMapper modelMapper = new ModelMapper();

    // Chuyển từ AreaEntity sang AreaDTO
    public AreaDTO toDto(AreaEntity entity) {
        if (entity != null) {
            AreaDTO dto = modelMapper.map(entity, AreaDTO.class);
            return dto;
        } else {
            return null;
        }
    }

    // Chuyển từ AreaDTO sang AreaEntity
    public AreaEntity toEntity(AreaDTO dto) {
        if (dto != null) {
            AreaEntity entity = modelMapper.map(dto, AreaEntity.class);
            return entity;
        } else {
            return null;
        }
    }
}
