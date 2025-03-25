package zooproject.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import zooproject.dto.CouponDTO;
import zooproject.entity.CouponEntity;

import java.util.List;

@Repository
public interface CouponRepository extends JpaRepository<CouponEntity ,Long>{
	CouponEntity findByCouponCode(String couponCode);

    @Query("SELECT COUNT(c) FROM CouponEntity c WHERE c.couponEnd >= CURRENT_DATE")
    Long countValidCoupons();

    @Query("SELECT COUNT(c) FROM CouponEntity c WHERE c.couponEnd < CURRENT_DATE")
    Long countExpiredCoupons();

    @Query("SELECT c.couponCondition, COUNT(c) FROM CouponEntity c GROUP BY c.couponCondition")
    List<Object[]> countCouponsByCondition();
}
