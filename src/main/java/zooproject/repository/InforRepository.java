package zooproject.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import zooproject.entity.InforEntity;

@Repository
public interface InforRepository  extends JpaRepository<InforEntity, Long>{

}
