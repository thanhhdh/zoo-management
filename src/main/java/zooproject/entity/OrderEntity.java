package zooproject.entity;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.List;

import javax.persistence.*;

@Entity
@Table(name = "tbl_order")
public class OrderEntity {
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "order_id")
	private Long orderId;

	@Column(name = "order_code")
	private String orderCode;

	@Column(name = "order_coupon")
	private String orderCoupon;

	@Column(name = "coupon_price")
	private double couponPrice;

	@OneToOne
	@JoinColumn(name = "customer_id", nullable = false)
	private CustomerEntity customerId;

	@OneToOne
	@JoinColumn(name = "infor_id", nullable = false)
	private InforEntity inforId;

	@OneToOne
	@JoinColumn(name = "payment_id", nullable = false)
	private PaymentEntity paymentId;

	@OneToMany(mappedBy = "order", cascade = CascadeType.ALL)
	private List<OrderDetailEntity> orderDetails = new ArrayList<>();;

	@Enumerated(EnumType.STRING)
	@Column(name = "order_status")
	private OrderStatus orderStatus;

	@Column(name = "created_at")
	private String createdAt;

	@Column(name = "updated_at")
	private String updatedAt;

	@PrePersist
	public void prePersist() {
		this.createdAt = LocalDateTime.now().format(DateTimeFormatter.ISO_LOCAL_DATE_TIME);
	}

	@PreUpdate
	public void preUpdate() {
		this.updatedAt = LocalDateTime.now().format(DateTimeFormatter.ISO_LOCAL_DATE_TIME);
	}


	public enum OrderStatus {
		PENDING, COMPLETED, CANCELLED
	}

	public double getTotalAmount() {
		return orderDetails != null ?
				orderDetails.stream()
						.mapToDouble(detail -> detail.getTicketPrice() * detail.getTicketSalesQuantity())
						.sum() : 0.0;
	}

	public List<OrderDetailEntity> getOrderDetails() {
		return orderDetails;
	}

	public void setOrderDetails(List<OrderDetailEntity> orderDetails) {
		this.orderDetails = orderDetails;
	}

	public CustomerEntity getCustomerId() {
		return customerId;
	}

	public void setCustomerId(CustomerEntity customerId) {
		this.customerId = customerId;
	}

	public Long getOrderId() {
		return orderId;
	}

	public void setOrderId(Long orderId) {
		this.orderId = orderId;
	}

	public String getOrderCode() {
		return orderCode;
	}

	public void setOrderCode(String orderCode) {
		this.orderCode = orderCode;
	}

	public String getOrderCoupon() {
		return orderCoupon;
	}

	public void setOrderCoupon(String orderCoupon) {
		this.orderCoupon = orderCoupon;
	}

	public double getCouponPrice() {
		return couponPrice;
	}

	public void setCouponPrice(double couponPrice) {
		this.couponPrice = couponPrice;
	}


	public InforEntity getInforId() {
		return inforId;
	}

	public void setInforId(InforEntity inforId) {
		this.inforId = inforId;
	}

	public PaymentEntity getPaymentId() {
		return paymentId;
	}

	public void setPaymentId(PaymentEntity paymentId) {
		this.paymentId = paymentId;
	}

	public OrderStatus getOrderStatus() {
		return orderStatus;
	}

	public void setOrderStatus(OrderStatus orderStatus) {
		this.orderStatus = orderStatus;
	}

	public String getCreatedAt() {
		return createdAt;
	}

	public void setCreatedAt(String createdAt) {
		this.createdAt = createdAt;
	}

	public String getUpdatedAt() {
		return updatedAt;
	}

	public void setUpdatedAt(String updatedAt) {
		this.updatedAt = updatedAt;
	}

}
