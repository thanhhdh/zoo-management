package zooproject.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import zooproject.entity.AreaEntity;


@Repository
public interface AreaRepository extends JpaRepository<AreaEntity, Long> {

}
