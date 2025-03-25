package zooproject.repository;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Slice;
import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import zooproject.entity.TaskEntity;

@Repository
public interface TaskRepository extends JpaRepository<TaskEntity, Long> {
	@Query(value = "SELECT * FROM tbl_task WHERE user_id = :id", nativeQuery = true)
	List<TaskEntity> findByUserId(@Param("id") Long id);

	@Query("SELECT t.food.id AS foodId, SUM(t.quantity) AS totalQuantity " + "FROM TaskEntity t "
			+ "GROUP BY t.food.id " + "ORDER BY totalQuantity DESC")
	List<Object[]> findTotalFoodQuantity();
}
