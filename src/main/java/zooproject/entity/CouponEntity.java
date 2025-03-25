package zooproject.entity;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name = "tbl_coupon")
public class CouponEntity extends BaseEntity {
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "coupon_id")
	private Long couponId;

	@Column(name = "coupon_name", columnDefinition = "varchar(50)")
	private String couponName;

	@Column(name = "coupon_code", columnDefinition = "varchar(50)")
	private String couponCode;

	@Column(name = "coupon_qty", length = 5)
	private Integer couponQty;

	@Column(name = "coupon_number", columnDefinition = "double")
	private Integer couponNumber;

	@Column(name = "coupon_condition", length = 5)
	private Integer couponCondition;

	@Column(name = "coupon_start", columnDefinition = "varchar(50)")
	private String couponStart;

	@Column(name = "coupon_end", columnDefinition = "varchar(50)")
	private String couponEnd;

	public CouponEntity() {
		super();
	}

	public Long getCouponId() {
		return couponId;
	}

	public void setCouponId(Long couponId) {
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

	public Integer getCouponQty() {
		return couponQty;
	}

	public void setCouponQty(Integer couponQty) {
		this.couponQty = couponQty;
	}

	public Integer getCouponNumber() {
		return couponNumber;
	}

	public void setCouponNumber(Integer couponNumber) {
		this.couponNumber = couponNumber;
	}

	public Integer getCouponCondition() {
		return couponCondition;
	}

	public void setCouponCondition(Integer couponCondition) {
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
