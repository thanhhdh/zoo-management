package zooproject.repository;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Slice;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import zooproject.dto.AnimalDTO;
import zooproject.entity.AnimalEntity;

import java.util.List;

@Repository
public interface AnimalRepository extends JpaRepository<AnimalEntity, Long> {

	@Query("select a.cage.cageName, count(a) from AnimalEntity a GROUP BY a.cage.cageName")
	List<Object[]> countAnimalsByCage();

	@Query("select a.species.speciesName, count(a) from AnimalEntity a group by a.species.speciesName")
	List<Object[]> countAnimalsBySpecies();

	@Query("SELECT a FROM AnimalEntity a WHERE a.species.speciesId = :speciesId")
	Page<AnimalEntity> findBySpeciesId(@Param("speciesId") Long speciesId, Pageable pageable);

	@Query("select a from AnimalEntity a where a.cage.cageId = :cageId")
	Page<AnimalEntity> findByCageId(@Param("cageId") Long cageId, Pageable pageable);

	@Query("select a from AnimalEntity a where a.cage.cageId = :id")
	List<AnimalEntity> findAnimalInCage(@Param("id") Long id);

	@Query("SELECT a.species.speciesId AS speciesId, COUNT(a.animalId) AS animalCount " + "FROM AnimalEntity a "
			+ "GROUP BY a.species.speciesId " + "ORDER BY animalCount DESC")
	List<Object[]> findAnimalCountBySpecies();

	@Query("SELECT a.animalStatus, COUNT(a) FROM AnimalEntity a GROUP BY a.animalStatus")
	List<Object[]> countAnimalsByStatus();

//	@Query("SELECT a.species.speciesName AS speciesName, COUNT(a.animalId) AS animalCount " + "FROM AnimalEntity a "
//			+ "GROUP BY a.species.speciesName " + "ORDER BY speciesName")
//	List<Object[]> findSpeciesData(); // Query mới để lấy speciesName và count
}
