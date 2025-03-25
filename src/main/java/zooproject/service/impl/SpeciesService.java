package zooproject.service.impl;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;

import zooproject.converter.SpeciesConverter;
import zooproject.dto.SpeciesDTO;
import zooproject.entity.SpeciesEntity;
import zooproject.repository.SpeciesRepository;
import zooproject.service.ISpeciesService;

@Service
public class SpeciesService implements ISpeciesService {
	@Autowired
	private SpeciesRepository speciesRepository;
	
	@Autowired
	private SpeciesConverter speciesConverter;
	
	
	@Override
	public SpeciesDTO insert(SpeciesDTO speciesDTO) {
		// TODO Auto-generated method stub
		SpeciesEntity speciesEntity = speciesConverter.toEntity(speciesDTO);
		speciesEntity = speciesRepository.save(speciesEntity);
		speciesDTO = speciesConverter.toDto(speciesEntity);
		return speciesDTO;
	}


	@Override
	public List<SpeciesDTO> findAll(Pageable pageable) {
		// TODO Auto-generated method stub
		List<SpeciesDTO> speciesDTOs = new ArrayList<SpeciesDTO>();
		List<SpeciesEntity> speciesEntities = speciesRepository.findAll(pageable).getContent();
		for(SpeciesEntity speciesEntity: speciesEntities) {
			speciesDTOs.add(speciesConverter.toDto(speciesEntity));
		}
		return speciesDTOs;
	}


	@Override
	public Integer getTotalItem() {
		// TODO Auto-generated method stub
		return (int) speciesRepository.count();
	}


	@Override
	public void updateStatus(Long id) {
	    SpeciesEntity speciesEntity = speciesRepository.findOne(id);
	    
	    if (speciesEntity == null) {
	        throw new IllegalArgumentException("Species with ID " + id + " not found.");
	    }

	    if (speciesEntity.getSpeciesStatus() == 1) {
	        speciesEntity.setSpeciesStatus(0); 
	    } else {
	        speciesEntity.setSpeciesStatus(1); 
	    }
	    
	    speciesRepository.save(speciesEntity);
	}


	@Override
	public SpeciesDTO findById(Long id) {
		SpeciesDTO speciesDTO = speciesConverter.toDto(speciesRepository.findOne(id));
		return speciesDTO;
	}
	
	@Override
	public void deleteById(Long id) {
		speciesRepository.delete(id);
	}

	@Override
	public void update(SpeciesDTO speciesDTO) {
		SpeciesEntity species = speciesRepository.findOne(speciesDTO.getId());
		if (species == null) {
			throw new IllegalArgumentException("Species with ID " + speciesDTO.getId() + " not found.");
		}
		species.setSpeciesName(speciesDTO.getSpeciesName());
		species.setSpeciesStatus(speciesDTO.getSpeciesStatus());
		species.setSpeciesImage(speciesDTO.getSpeciesImage());
		species.setSpecieDesc(speciesDTO.getSpecieDesc());
		species.setSpeciesAllocation(speciesDTO.getSpeciesAllocation());
		species.setSpeciesReproduction(speciesDTO.getSpeciesReproduction());
		species.setSpeciesEcological(speciesDTO.getSpeciesEcological());
		speciesRepository.save(species);
	}

}








