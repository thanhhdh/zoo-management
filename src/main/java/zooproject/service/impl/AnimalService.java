package zooproject.service.impl;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Optional;

import org.hibernate.Hibernate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;

import zooproject.converter.AnimalConverter;
import zooproject.converter.CageConverter;
import zooproject.converter.FoodConverter;
import zooproject.converter.SpeciesConverter;
import zooproject.dto.AnimalDTO;
import zooproject.dto.CageDTO;
import zooproject.dto.FoodDTO;
import zooproject.dto.SpeciesDTO;
import zooproject.entity.AnimalEntity;
import zooproject.entity.SpeciesEntity;
import zooproject.repository.AnimalRepository;
import zooproject.repository.MedicalRepository;
import zooproject.repository.SpeciesRepository;
import zooproject.service.IAnimalService;

import javax.persistence.EntityNotFoundException;

@Service
public class AnimalService implements IAnimalService {
	@Autowired
	private AnimalRepository animalRepository;

	@Autowired
	private AnimalConverter animalConverter;

	@Autowired
	private SpeciesService speciesService;

	@Autowired
	private SpeciesConverter speciesConverter;

	@Autowired
	private CageConverter cageConverter;

	@Autowired
	private CageService cageService;
	
	@Autowired
	private FoodService foodService;

	@Autowired
	private FoodConverter foodConverter;
	
	@Autowired
	private MedicalRepository medicalRepository;
	
	@Autowired
	private SpeciesRepository speciesRepository;

	@Override
	public AnimalDTO insert(AnimalDTO animalDTO) {
		SpeciesDTO speciesDTO = speciesService.findById(animalDTO.getSpecies().getId());
		CageDTO cageDTO = cageService.findByID(animalDTO.getCage().getId());
		FoodDTO foodDTO = foodService.findByID(animalDTO.getFood().getFoodId());

		// Convert AnimalDTO to AnimalEntity
		AnimalEntity animalEntity = animalConverter.toEntity(animalDTO);

		// Set related entities
		animalEntity.setSpecies(speciesConverter.toEntity(speciesDTO));
		animalEntity.setCage(cageConverter.toEntity(cageDTO));
		animalEntity.setFood(foodConverter.toEntity(foodDTO));

		// Save entity to repository
		animalEntity = animalRepository.save(animalEntity);

		// Convert saved entity back to DTO and return
		return animalConverter.toDto(animalEntity);
	}

	@Override
	public List<AnimalDTO> findAll(Pageable pageable) {
		List<AnimalDTO> animalDTOs = new ArrayList<AnimalDTO>();
		List<AnimalEntity> animalEntities = animalRepository.findAll(pageable).getContent();
		for (AnimalEntity animalEntity : animalEntities) {
			animalDTOs.add(animalConverter.toDto(animalEntity));
		}

		return animalDTOs;
	}

	@Override
	public Integer getTotalItem() {
		// TODO Auto-generated method stub
		return (int) animalRepository.count();
	}

	@Override
	public AnimalDTO findByID(Long id) {
		// TODO Auto-generated method stub
		AnimalDTO animalDTO = animalConverter.toDto(animalRepository.findOne(id));
		return animalDTO;
	}
	
	@Override
	public void deleteById(Long animalId) {
		if(medicalRepository.exists(animalId)) {
			medicalRepository.delete(animalId);
		}
		animalRepository.delete(animalId);
	}

	@Override
	public AnimalDTO updateAnimal(AnimalDTO animalDTO) {
		// Tìm kiếm đối tượng Species và Cage bằng ID từ DTO
		SpeciesDTO speciesDTO = speciesService.findById((long) animalDTO.getSpecies().getId());
		CageDTO cageDTO = cageService.findByID((long) animalDTO.getCage().getId());
		FoodDTO foodDTO = foodService.findByID((long) animalDTO.getFood().getFoodId());

		AnimalEntity animalEntity = animalRepository.findOne(animalDTO.getAnimalId());

		animalEntity.setAnimalName(animalDTO.getAnimalName());
		animalEntity.setAnimalAge(animalDTO.getAnimalAge());
		animalEntity.setAnimalAllocation(animalDTO.getAnimalAllocation());
		animalEntity.setAnimalDesc(animalDTO.getAnimalDesc());
		animalEntity.setAnimalEcological(animalDTO.getAnimalEcological());
		animalEntity.setAnimalReproduction(animalDTO.getAnimalReproduction());
		animalEntity.setAnimalStatus(animalDTO.getAnimalStatus());
		animalEntity.setOrigin(animalDTO.getOrigin());
		animalEntity.setDateOfEntry(animalDTO.getDateOfEntry());


		if(animalDTO.getAnimalImage() != null && !animalDTO.getAnimalImage().isEmpty()) {
			animalEntity.setAnimalImage(animalDTO.getAnimalImage());
		}
		animalEntity.setSpecies(speciesConverter.toEntity(speciesDTO));
		animalEntity.setCage(cageConverter.toEntity(cageDTO));
		animalEntity.setFood(foodConverter.toEntity(foodDTO));

		animalEntity = animalRepository.save(animalEntity);
		animalDTO = animalConverter.toDto(animalEntity);
		return animalDTO;
	}

	@Override
	public void updateStatus(Long animalId) {
		AnimalEntity  animalEntity = animalRepository.findOne(animalId);

		switch (animalEntity.getAnimalStatus()) {
			case HEALTHY:
				animalEntity.setAnimalStatus(AnimalEntity.AnimalStatus.SICK);
				break;
			case SICK:
				animalEntity.setAnimalStatus(AnimalEntity.AnimalStatus.IN_QUARANTINE);
				break;
			case IN_QUARANTINE:
				animalEntity.setAnimalStatus(AnimalEntity.AnimalStatus.UNDER_TREATMENT);
				break;
			case UNDER_TREATMENT:
				animalEntity.setAnimalStatus(AnimalEntity.AnimalStatus.HEALTHY);
				break;
			default:
				throw new IllegalStateException("Unknown status: " + animalEntity.getAnimalStatus());
		}
		animalRepository.save(animalEntity);
	}

	@Override
	public List<Object[]> getAnimalCountByCage() {
		return animalRepository.countAnimalsByCage();
	}

	@Override
	public List<Object[]> getAnimalCountBySpecies() {
		return animalRepository.countAnimalsBySpecies();
	}

	@Override
	public List<AnimalDTO> findBySpeciesId(Long speciesId, Pageable pageable) {
		List<AnimalDTO> animalDTOs = new ArrayList<>();

		// Lấy danh sách các AnimalEntity theo speciesId với phân trang
		List<AnimalEntity> animalEntities = animalRepository.findBySpeciesId(speciesId, pageable).getContent();

		// Chuyển đổi từng AnimalEntity sang AnimalDTO và thêm vào danh sách
		for (AnimalEntity animalEntity : animalEntities) {
			animalDTOs.add(animalConverter.toDto(animalEntity));
		}

		return animalDTOs;
	}

	@Override
	public List<AnimalDTO> findByCageId(Long cageId, Pageable pageable) {
		List<AnimalDTO> animalDTOS = new ArrayList<>();

		List<AnimalEntity> animalEntities = animalRepository.findByCageId(cageId, pageable).getContent();

		for (AnimalEntity animalEntity : animalEntities) {
			animalDTOS.add(animalConverter.toDto(animalEntity));
		}
		return animalDTOS;
	}
	
	@Override
    public List<Object[]> getCountAnimalBySpecies() {  
        return animalRepository.findAnimalCountBySpecies();
    }

    @Override
    public Map<String, Integer> getTotalFoodQuantity() {
        List<Object[]> results = animalRepository.findAnimalCountBySpecies();
        Map<String, Integer> foodQuantityMap = new HashMap<>();

        for (Object[] result : results) {
            Long speciesId = ((Number) result[0]).longValue(); // Convert từ Object sang Long
            String speciesName = speciesRepository.findOne(speciesId).getSpeciesName();           
            Integer totalQuantity = ((Number) result[1]).intValue(); // Convert từ Object sang Integer           
            String speciesKey = speciesId + "." + speciesName; // Tạo key kết hợp speciesId và speciesName
            foodQuantityMap.put(speciesKey, totalQuantity);
        }

        return foodQuantityMap;
    }

	@Override
	public Map<String, Long> getAnimalStatisticsByStatus() {

		Map<String, Long> statistics = new HashMap<>();
		statistics.put("HEALTHY", 0L);
		statistics.put("SICK", 0L);
		statistics.put("IN_QUARANTINE", 0L);
		statistics.put("UNDER_TREATMENT", 0L);

		List<Object[]> results = animalRepository.countAnimalsByStatus();

		for (Object[] result : results) {
			String status = result[0].toString();  // `animalStatus` as String
			Long count = (Long) result[1];        // Count of animals
			statistics.put(status, count);
		}

		return statistics;
	}
}
