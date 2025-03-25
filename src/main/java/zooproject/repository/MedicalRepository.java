package zooproject.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import zooproject.entity.MedicalEntity;

import java.util.List;

@Repository
public interface MedicalRepository extends JpaRepository<MedicalEntity, Long> {
	MedicalEntity findByMedicalId(Long medicalId);

	List<MedicalEntity> findByAnimal_AnimalId(Long animalId);
}
