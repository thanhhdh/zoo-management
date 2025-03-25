package zooproject.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import zooproject.entity.CageEntity;

@Repository
public interface CageRepository extends JpaRepository<CageEntity, Long> {
	@Query("SELECT COUNT(a.animalId) FROM AnimalEntity a WHERE a.cage.cageId = :cageId")
	Long countAnimalsInCage(@Param("cageId") Long cageId);

	@Query("SELECT c FROM CageEntity c WHERE c.cageId = :cageId")
	CageEntity findByCageId(@Param("cageId") Long cageId);

	@Query("SELECT COUNT(c) FROM CageEntity c WHERE c.area.areaId = :areaId")
	int countByAreaId(@Param("areaId") Long areaId);
}
