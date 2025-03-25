package zooproject.converter;

import org.modelmapper.ModelMapper;
import org.springframework.stereotype.Component;
import zooproject.dto.AreaDTO;
import zooproject.dto.QuestionDTO;
import zooproject.entity.AreaEntity;
import zooproject.entity.QuestionEntity;

@Component
public class QuestionConverter {
    ModelMapper modelMapper = new ModelMapper();

    // Chuyển từ QuestionEntity sang AreaDTO
    public QuestionDTO toDto(QuestionEntity entity) {
        if (entity != null) {
            QuestionDTO dto = modelMapper.map(entity, QuestionDTO.class);
            return dto;
        } else {
            return null;
        }
    }

    // Chuyển từ AreaDTO sang AreaEntity
    public QuestionEntity toEntity(QuestionDTO dto) {
        if (dto != null) {
            QuestionEntity entity = modelMapper.map(dto, QuestionEntity.class);
            return entity;
        } else {
            return null;
        }
    }
}
