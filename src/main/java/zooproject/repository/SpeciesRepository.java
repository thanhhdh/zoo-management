package zooproject.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import zooproject.entity.SpeciesEntity;
@Repository
public interface SpeciesRepository extends JpaRepository<SpeciesEntity, Long>{
	
}
