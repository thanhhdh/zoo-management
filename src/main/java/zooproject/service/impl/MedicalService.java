package zooproject.service.impl;

import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;

import zooproject.converter.AnimalConverter;
import zooproject.converter.MedicalConverter;
import zooproject.dto.AnimalDTO;
import zooproject.dto.MedicalDTO;
import zooproject.entity.MedicalEntity;
import zooproject.repository.MedicalRepository;
import zooproject.service.IMedicalService;

import javax.persistence.EntityNotFoundException;

@Service
public class MedicalService implements IMedicalService {
	@Autowired
	private MedicalRepository medicalRepository;

	@Autowired
	private MedicalConverter medicalConverter;

	@Autowired
	private AnimalConverter animalConverter;

	@Autowired
	private AnimalService animalService;

	@Override
	public MedicalDTO insert(MedicalDTO medicalDTO) {
		// TODO Auto-generated method stub
		AnimalDTO animalDTO = animalService.findByID(medicalDTO.getAnimal().getAnimalId());
		MedicalEntity medicalEntity = medicalConverter.toEntity(medicalDTO);

		medicalEntity.setAnimal(animalConverter.toEntity(animalDTO));
		medicalEntity = medicalRepository.save(medicalEntity);
		medicalDTO = medicalConverter.toDto(medicalEntity);
		return medicalDTO;
	}

	@Override
	public List<MedicalDTO> findAll(Pageable pageable) {
		// TODO Auto-generated method stub
		List<MedicalDTO> medicalDTOs = new ArrayList<>();
		List<MedicalEntity> medicalEntities = medicalRepository.findAll(pageable).getContent();
		for (MedicalEntity medicalEntity : medicalEntities) {
			medicalDTOs.add(medicalConverter.toDto(medicalEntity));
		}
		return medicalDTOs;
	}

	@Override
	public MedicalDTO findById(Long id) {
		MedicalDTO medicalDTO = medicalConverter.toDto(medicalRepository.findByMedicalId(id));
		return medicalDTO;
	}

	@Override
	public void update(MedicalDTO medicalDTO) {
		MedicalEntity medical = medicalRepository.findOne(medicalDTO.getMedicalId());
		if(medical == null) {
			throw new EntityNotFoundException("Supplier not found");
		}
		medical.setMedicalName(medicalDTO.getMedicalName());
		medical.setMedicalDesc(medicalDTO.getMedicalDesc());
		medical.setMedicalSurgicalHistory(medicalDTO.getMedicalSurgicalHistory());
		medical.setMedicalCheck(medicalDTO.getMedicalCheck());
		medical.setMedicalStatus(medicalDTO.getMedicalStatus());
		medicalRepository.save(medical);
	}

	@Override
	public List<MedicalDTO> findByAnimalId(Long animalId) {
		List<MedicalEntity> entities = medicalRepository.findByAnimal_AnimalId(animalId);

		// Chuyển đổi danh sách từ Entity sang DTO thủ công
		return entities.stream()
				.map(medicalConverter::toDto)
				.collect(Collectors.toList());
	}

	@Override
	public void deleteMedicalById(Long medicalId) {
		medicalRepository.delete(medicalId);
	}

//	@Override
//	public MedicalDTO findAnimalById(Long animalId) {
//		MedicalEntity medicalEntity = medicalRepository.findByAnimalId(animalId);
//		return null;
//	}

}
