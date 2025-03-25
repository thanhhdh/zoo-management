package zooproject.service;

import java.util.List;
import java.util.Map;

import org.springframework.data.domain.Pageable;

import zooproject.dto.FoodDTO;

public interface IFoodService {
	FoodDTO insert(FoodDTO foodDTO);
	
	List<FoodDTO> findAll(Pageable pageable);

	Integer getTotalItem();
	
	FoodDTO findByID(Long id);
	
	FoodDTO update(FoodDTO foodDTO);

	void delete(Long id);


    Map<String, Integer> getFoodStatistics();

	Long getOutOfStockFoodCount();
}
