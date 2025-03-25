package zooproject.service.impl;

import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;

import zooproject.converter.CouponConverter;
import zooproject.dto.CouponDTO;
import zooproject.entity.CouponEntity;
import zooproject.repository.CouponRepository;
import zooproject.service.ICouponService;

@Service
public class CouponService implements ICouponService {
	@Autowired
	private CouponRepository couponRepository;

	@Autowired
	private CouponConverter couponConverter;

	@Override
	public CouponDTO insert(CouponDTO couponDTO) {
		// TODO Auto-generated method stub
		CouponEntity couponEntity = couponConverter.toEntity(couponDTO);
		couponEntity = couponRepository.save(couponEntity);
		couponDTO = couponConverter.toDto(couponEntity);
		return couponDTO;
	}

	@Override
	public List<CouponDTO> findAll(Pageable pageable) {
		List<CouponDTO> couponDTOs = new ArrayList<CouponDTO>();
		List<CouponEntity> couponEntities = couponRepository.findAll(pageable).getContent();
		for (CouponEntity couponEntity : couponEntities) {
			couponDTOs.add(couponConverter.toDto(couponEntity));
		}
		return couponDTOs;
	}

	@Override
	public Integer getTotalItem() {
		// TODO Auto-generated method stub
		return (int) couponRepository.count();
	}

	@Override
	public CouponEntity checkCoupon(String couponCode) {
	    if (couponCode == null || couponCode.trim().isEmpty()) {
	        return null;
	    }

	    CouponEntity couponEntity = couponRepository.findByCouponCode(couponCode);

	    if (couponEntity != null) {
	        LocalDate currentDate = LocalDate.now();
	        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy/MM/dd");
	        LocalDate couponEnd = LocalDate.parse(couponEntity.getCouponEnd(), formatter);

	        if (couponEntity.getCouponQty() > 0 && couponEnd.isAfter(currentDate)) {
	            return couponEntity;
	        }
	    }

	    return null;
	}

	@Override
	public void deleteQtyCoupon(String couponCode) {
		CouponEntity couponEntity = couponRepository.findByCouponCode(couponCode);
		if(couponCode != null) {
			couponEntity.setCouponQty(couponEntity.getCouponQty() - 1);
			couponRepository.save(couponEntity);
		}
		
	}

	@Override
	public void deleteById(Long couponId) {
		couponRepository.delete(couponId);
	}

	@Override
	public CouponDTO findById(Long couponId) {
		CouponDTO couponDTO = couponConverter.toDto(couponRepository.findOne(couponId));
		return couponDTO;
	}

	@Override
	public void updateCoupon(CouponDTO couponDTO) {
		CouponEntity couponEntity = couponConverter.toEntity(couponDTO);

		if (couponEntity != null) {
			couponRepository.save(couponEntity);
		} else {
			throw new RuntimeException("Khu vực không tồn tại với ID: " + couponEntity.getCouponId());
		}
	}

	@Override
	public Long countValidCoupons() {
		return couponRepository.countValidCoupons();
	}

	@Override
	public Long countExpiredCoupons() {
		return couponRepository.countExpiredCoupons();
	}

	@Override
	public Map<Integer, Long> getCouponCountByCondition() {
		List<Object[]> results = couponRepository.countCouponsByCondition();
		Map<Integer, Long> conditionMap = new HashMap<>();
		for (Object[] result : results) {
			conditionMap.put((Integer) result[0], (Long) result[1]);
		}
		return conditionMap;
	}

}
