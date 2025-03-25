package zooproject.service;

import java.util.List;
import java.util.Map;

import org.springframework.data.domain.Pageable;

import zooproject.dto.CouponDTO;
import zooproject.entity.CouponEntity;

public interface ICouponService {
	CouponDTO insert(CouponDTO couponDTO);

	List<CouponDTO> findAll(Pageable pageable);

	Integer getTotalItem();
	
	CouponEntity checkCoupon(String couponCode);
	
	void deleteQtyCoupon(String couponCode);

    void deleteById(Long couponId);

	CouponDTO findById(Long couponId);

	void updateCoupon(CouponDTO couponDTO);

	Long countValidCoupons();

	Long countExpiredCoupons();

	Map<Integer, Long> getCouponCountByCondition();
}
