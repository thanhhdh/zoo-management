package zooproject.converter;

import org.modelmapper.ModelMapper;
import org.springframework.stereotype.Component;

import zooproject.dto.FoodDTO;
import zooproject.entity.FoodEntity;

@Component
public class FoodConverter {
	ModelMapper modelMapper = new ModelMapper();

	public FoodDTO toDto(FoodEntity entity) {
		if (entity != null) {
			FoodDTO dto = modelMapper.map(entity, FoodDTO.class);
			return dto;
		} else {
			return null;
		}

	}

	public FoodEntity toEntity(FoodDTO toDto) {
		if (toDto != null) {
			FoodEntity entity = modelMapper.map(toDto, FoodEntity.class);
			return entity;
		} else {
			return null;
		}
	}
	
	public FoodEntity toEntity(FoodDTO dto, FoodEntity existingEntity) {
        if (dto != null && existingEntity != null) {
            existingEntity.setFoodName(dto.getFoodName());
            existingEntity.setFoodQuantity(dto.getFoodQuantity());
            existingEntity.setNutritionalInfo(dto.getNutritionalInfo());
            existingEntity.setExpirationStart(dto.getExpirationStart());
            existingEntity.setExpirationEnd(dto.getExpirationEnd());
            existingEntity.setStorageRequirements(dto.getStorageRequirements());
        }
        return existingEntity;
    }

}
