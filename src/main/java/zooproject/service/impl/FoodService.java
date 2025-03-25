package zooproject.service.impl;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;

import zooproject.converter.FoodConverter;
import zooproject.converter.SupplierConverter;
import zooproject.dto.FoodDTO;
import zooproject.dto.SupplierDTO;
import zooproject.entity.FoodEntity;
import zooproject.entity.SupplierEntity;
import zooproject.repository.FoodRepository;
import zooproject.service.IFoodService;

@Service
public class FoodService implements IFoodService {
	@Autowired
	private FoodRepository foodRepository;

	@Autowired
	private FoodConverter foodConverter;

	@Autowired
	private SupplierService supplierService;

	@Autowired
	private SupplierConverter supplierConverter;

	@Override
	public FoodDTO insert(FoodDTO foodDTO) {
		// TODO Auto-generated method stub
		SupplierDTO supplierDTO = supplierService.findByID((long) foodDTO.getSupplier().getSupplierId());

		FoodEntity foodEntity = foodConverter.toEntity(foodDTO);
		foodEntity.setSupplierEntity(supplierConverter.toEntity(supplierDTO));
		foodEntity = foodRepository.save(foodEntity);

		foodDTO = foodConverter.toDto(foodEntity);
		return foodDTO;
	}

	@Override
	public List<FoodDTO> findAll(Pageable pageable) {
		// TODO Auto-generated method stub
		List<FoodDTO> foodDTOs = new ArrayList<>();
		List<FoodEntity> foodEntities = foodRepository.findAll(pageable).getContent();
		for (FoodEntity foodEntity : foodEntities) {
			foodDTOs.add(foodConverter.toDto(foodEntity));
		}
		return foodDTOs;
	}

	@Override
	public Integer getTotalItem() {
		// TODO Auto-generated method stub
		return (int) foodRepository.count();
	}

	@Override
	public FoodDTO findByID(Long id) {
		// TODO Auto-generated method stub
		FoodDTO foodDTO = foodConverter.toDto(foodRepository.findOne(id));
		return foodDTO;
	}

	@Override
	public FoodDTO update(FoodDTO foodDTO) {
		FoodEntity existingFood = foodRepository.findOne(foodDTO.getFoodId());
		if (existingFood != null) {
			if (foodDTO.getSupplier() != null) {
				SupplierEntity supplierEntity = supplierConverter.toEntity(foodDTO.getSupplier());
				existingFood.setSupplierEntity(supplierEntity);
			}
			FoodEntity updatedFood = foodConverter.toEntity(foodDTO, existingFood);
			updatedFood = foodRepository.save(updatedFood);
			return foodConverter.toDto(updatedFood);
		}
		return null;
	}

	@Override
	public void delete(Long id) {
		foodRepository.delete(id);

	}

	@Override
	public Map<String, Integer> getFoodStatistics() {
		List<Object[]> rawStats = foodRepository.getFoodStatistics();
		Map<String, Integer> foodStats = new HashMap<>();
		for (Object[] row : rawStats) {
			foodStats.put((String) row[0], ((Long) row[1]).intValue());
		}
		return foodStats;
	}

	@Override
	public Long getOutOfStockFoodCount() {
		return foodRepository.countOutOfStockFood();
	}

	public List<FoodEntity> findOutOfStockFoods() {
		return foodRepository.findByFoodQuantity(0);
	}

	public List<FoodEntity> findLowStockFoods(int threshold) {
		return foodRepository.findByFoodQuantityLessThanEqual(threshold);
	}
}
