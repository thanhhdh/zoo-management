package zooproject.dto;

import org.springframework.stereotype.Component;

@Component
public class CouponDTO extends AbstractDTO<CouponDTO>{
	private int couponId;
	private String couponName;
	private String couponCode;
	private int couponQty;
	private int couponNumber;
	private int couponCondition;
	private String couponStart;
	private String couponEnd;

	public CouponDTO() {
		super();
	}

	public int getCouponId() {
		return couponId;
	}

	public void setCouponId(int couponId) {
		this.couponId = couponId;
	}

	public String getCouponName() {
		return couponName;
	}

	public void setCouponName(String couponName) {
		this.couponName = couponName;
	}

	public String getCouponCode() {
		return couponCode;
	}

	public void setCouponCode(String couponCode) {
		this.couponCode = couponCode;
	}

	public int getCouponQty() {
		return couponQty;
	}

	public void setCouponQty(int couponQty) {
		this.couponQty = couponQty;
	}

	public int getCouponNumber() {
		return couponNumber;
	}

	public void setCouponNumber(int couponNumber) {
		this.couponNumber = couponNumber;
	}

	public int getCouponCondition() {
		return couponCondition;
	}

	public void setCouponCondition(int couponCondition) {
		this.couponCondition = couponCondition;
	}

	public String getCouponStart() {
		return couponStart;
	}

	public void setCouponStart(String couponStart) {
		this.couponStart = couponStart;
	}

	public String getCouponEnd() {
		return couponEnd;
	}

	public void setCouponEnd(String couponEnd) {
		this.couponEnd = couponEnd;
	}

}
