package zooproject.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import zooproject.entity.FoodEntity;

import java.util.List;

@Repository
public interface FoodRepository extends JpaRepository<FoodEntity, Long> {

    @Query("SELECT f.foodName, SUM(f.foodQuantity) FROM FoodEntity f GROUP BY f.foodName")
    List<Object[]> getFoodStatistics();

    @Query("SELECT COUNT(f) FROM FoodEntity f WHERE f.foodQuantity = 0")
    Long countOutOfStockFood();

    List<FoodEntity> findByFoodQuantity(int quantity);

    List<FoodEntity> findByFoodQuantityLessThanEqual(int threshold);
}
