package zooproject.service;

import java.util.List;
import java.util.Map;

import org.springframework.data.domain.Pageable;

import zooproject.dto.AnimalDTO;
import zooproject.entity.AnimalEntity;

public interface IAnimalService {
	AnimalDTO insert(AnimalDTO animalDTO);

	List<AnimalDTO> findAll(Pageable pageable);

	Integer getTotalItem();

	AnimalDTO findByID(Long id);
	
	void deleteById(Long animalId);

	AnimalDTO updateAnimal(AnimalDTO animalDTO);

	void updateStatus(Long animalId);

    List<Object[]> getAnimalCountByCage();

	List<Object[]> getAnimalCountBySpecies();

	List<AnimalDTO> findBySpeciesId(Long speciesId, Pageable pageable);

	List<AnimalDTO> findByCageId(Long cageId, Pageable pageable);
	
    List<Object[]> getCountAnimalBySpecies();

     Map<String, Integer> getTotalFoodQuantity();


	Map<String, Long> getAnimalStatisticsByStatus();
}
