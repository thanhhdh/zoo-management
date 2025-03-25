package zooproject.service;

import java.util.List;

import org.springframework.data.domain.Pageable;

import zooproject.dto.MedicalDTO;

public interface IMedicalService {
	MedicalDTO insert(MedicalDTO medicalDTO);
	
	List<MedicalDTO> findAll(Pageable pageable);
	
	MedicalDTO findById(Long id);
	void update(MedicalDTO medicalDTO);

	List<MedicalDTO> findByAnimalId(Long animalId);

	void deleteMedicalById(Long medicalId);


//	MedicalDTO findAnimalById(Long animalId);
}
