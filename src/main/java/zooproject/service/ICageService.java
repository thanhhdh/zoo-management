package zooproject.service;

import java.util.List;

import org.springframework.data.domain.Pageable;

import zooproject.dto.CageDTO;
import zooproject.entity.CageEntity;

public interface ICageService {
	CageDTO insert(CageDTO cageDTO);

	List<CageDTO> findAll(Pageable pageable);

	Integer getTotalItem();

	void update(Long id);

	CageDTO findByID(Long id);

	void deleteById(long id);

	void updateCage(CageDTO cageDTO);

	void updateStatus(Long id);

	boolean isCageInUse(Long id);

	Long countAnimalsInCage(Long cageId);

	CageEntity findByCageId(Long cageId);

}
