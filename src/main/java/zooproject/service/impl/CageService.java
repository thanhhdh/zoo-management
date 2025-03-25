package zooproject.service.impl;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;

import zooproject.converter.AreaConverter;
import zooproject.converter.CageConverter;
import zooproject.dto.AnimalDTO;
import zooproject.dto.AreaDTO;
import zooproject.dto.CageDTO;
import zooproject.entity.AnimalEntity;
import zooproject.entity.CageEntity;
import zooproject.repository.AnimalRepository;
import zooproject.repository.CageRepository;
import zooproject.service.ICageService;

@Service
public class CageService implements ICageService {
	@Autowired
	private CageRepository cageRepository;
	@Autowired
	private AnimalRepository animalRepository;

	@Autowired
	private AreaService areaService;

	@Autowired
	private CageConverter cageConverter;

	@Autowired
	private AreaConverter areaConverter;

	@Override
	public CageDTO insert(CageDTO cageDTO) {
		// TODO Auto-generated method stub
		CageEntity cageEntity = cageConverter.toEntity(cageDTO);
		cageEntity = cageRepository.save(cageEntity);
		cageDTO = cageConverter.toDto(cageEntity);
		return cageDTO;
	}

	@Override
	public List<CageDTO> findAll(Pageable pageable) {
		// TODO Auto-generated method stub
		List<CageDTO> cageDTOs = new ArrayList<CageDTO>();
		List<CageEntity> cageEntities = cageRepository.findAll(pageable).getContent();
		for (CageEntity cageEntity : cageEntities) {
			cageDTOs.add(cageConverter.toDto(cageEntity));
		}
		return cageDTOs;
	}

	@Override
	public Integer getTotalItem() {
		// TODO Auto-generated method stub
		return (int) cageRepository.count();
	}

	@Override
	public void update(Long id) {
		// Tìm entity dựa trên id
		CageEntity cageEntity = cageRepository.findOne(id);

		if (cageEntity == null) {
			throw new IllegalArgumentException("Cage with ID " + id + " not found.");
		}

		// Chuyển đổi từ Entity thành DTO
		CageDTO cageDTO = cageConverter.toDto(cageEntity);

		// Thay đổi trạng thái của DTO
		if (cageDTO.getCageStatus() == 1) {
			cageDTO.setCageStatus(0); // Nếu đang là 1, đổi thành 0
		} else {
			cageDTO.setCageStatus(1); // Nếu đang là 0, đổi thành 1
		}

		// Chuyển đổi từ DTO thành Entity
		CageEntity updatedCageEntity = cageConverter.toEntity(cageDTO);

		cageRepository.save(updatedCageEntity);
	}

	@Override
	public CageDTO findByID(Long id) {
		CageDTO cageDTO = cageConverter.toDto(cageRepository.findOne(id));
		return cageDTO;
	}

	@Override
	public void deleteById(long id) {
		cageRepository.delete(id);
	}

	@Override
	public void updateCage(CageDTO cageDTO) {
		CageEntity cage = cageRepository.findOne(cageDTO.getId());

		AreaDTO areaDTO = areaService.findById(cageDTO.getArea().getId());

		if (cage == null) {
			throw new IllegalArgumentException("Cage with ID " + cageDTO.getId() + " not found.");
		}
		cage.setCageName(cageDTO.getCageName());
		cage.setCageDesc(cageDTO.getCageDesc());
		cage.setCageCapacity(cageDTO.getCageCapacity());
		cage.setCageStatus(cageDTO.getCageStatus());
		cage.setArea(areaConverter.toEntity(areaDTO));
		cageRepository.save(cage);
	}

	@Override
	public void updateStatus(Long id) {
		CageEntity cageEntity = cageRepository.findOne(id);
		if (cageEntity.getCageStatus() == 1) {
			cageEntity.setCageStatus(0);
		} else {
			cageEntity.setCageStatus(1);
		}
		cageRepository.save(cageEntity);
	}

	@Override
	public boolean isCageInUse(Long id) {
		List<AnimalEntity> animalInCage = animalRepository.findAnimalInCage(id);
		return !animalInCage.isEmpty();
	}

	@Override
	public Long countAnimalsInCage(Long cageId) {
		return cageRepository.countAnimalsInCage(cageId);
	}

	@Override
	public CageEntity findByCageId(Long cageId) {
		 return cageRepository.findByCageId(cageId);
	}



}
