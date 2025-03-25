package zooproject.dto;

import org.springframework.stereotype.Component;
import zooproject.entity.OrderEntity.OrderStatus;

@Component
public class OrderDTO extends AbstractDTO<OrderDTO> {
	private Long orderId;
	private String orderCode;
	private String orderCoupon;
	private double couponPrice;
	private CustomerDTO customerId;
	private InforDTO inforId;
	private PaymentDTO paymentId;
	private OrderStatus orderStatus;
	private String createdAt;
	private String updateAt;

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

	public OrderStatus getOrderStatus() {
		return orderStatus;
	}

	public void setOrderStatus(OrderStatus orderStatus) {
		this.orderStatus = orderStatus;
	}

	public CustomerDTO getCustomerId() {
		return customerId;
	}

	public void setCustomerId(CustomerDTO customerId) {
		this.customerId = customerId;
	}

	public InforDTO getInforId() {
		return inforId;
	}

	public void setInforId(InforDTO inforId) {
		this.inforId = inforId;
	}

	public PaymentDTO getPaymentId() {
		return paymentId;
	}

	public void setPaymentId(PaymentDTO paymentId) {
		this.paymentId = paymentId;
	}

	public String getCreatedAt() {
		return createdAt;
	}

	public void setCreatedAt(String createdAt) {
		this.createdAt = createdAt;
	}

	public String getUpdateAt() {
		return updateAt;
	}

	public void setUpdateAt(String updateAt) {
		this.updateAt = updateAt;
	}

}
