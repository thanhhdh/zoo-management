package zooproject.service;

import java.util.List;

import org.springframework.data.domain.Pageable;

import zooproject.dto.SpeciesDTO;
import zooproject.entity.SpeciesEntity;

public interface ISpeciesService {
	SpeciesDTO insert(SpeciesDTO speciesDTO);

	List<SpeciesDTO> findAll(Pageable pageable);

	Integer getTotalItem();

	void updateStatus(Long id);

	SpeciesDTO findById(Long id);
	
	public void deleteById(Long id);

	void update(SpeciesDTO speciesDTO);

}
