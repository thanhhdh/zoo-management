package zooproject.entity;

import javax.persistence.*;
import java.time.LocalDateTime;

@Entity
@Table(name = "tbl_order_details")
public class OrderDetailEntity {
	@Id
	@GeneratedValue(strategy = GenerationType.AUTO)
	@Column(name = "order_details_id")
	private Long orderDetailsId;

	@Column(name = "order_code")
	private String orderCode;

	@Column(name = "ticket_name")
	private String ticketName;

	@Column(name = "ticket_price")
	private double ticketPrice;

	@Column(name = "ticket_sales_quantity")
	private int ticketSalesQuantity;

	@ManyToOne(fetch = FetchType.LAZY, optional = false)
	@JoinColumn(name = "order_id", nullable = false)
	private OrderEntity order;

	@Column(name = "order_date", nullable = false, updatable = false)
	private LocalDateTime orderDate;

	@Column(name = "updated_at")
	private LocalDateTime updatedAt;

	// Automatically set orderDate and updatedAt
	@PrePersist
	protected void onCreate() {
		orderDate = LocalDateTime.now();
		updatedAt = LocalDateTime.now();
	}

	@PreUpdate
	protected void onUpdate() {
		updatedAt = LocalDateTime.now();
	}

	public OrderEntity getOrder() {
		return order;
	}
	// Getters and Setters

	public void setOrder(OrderEntity order) {
		this.order = order;
	}

	public Long getOrderDetailsId() {
		return orderDetailsId;
	}

	public void setOrderDetailsId(Long orderDetailsId) {
		this.orderDetailsId = orderDetailsId;
	}

	public String getOrderCode() {
		return orderCode;
	}

	public void setOrderCode(String orderCode) {
		this.orderCode = orderCode;
	}

	public String getTicketName() {
		return ticketName;
	}

	public void setTicketName(String ticketName) {
		this.ticketName = ticketName;
	}

	public double getTicketPrice() {
		return ticketPrice;
	}

	public void setTicketPrice(double ticketPrice) {
		this.ticketPrice = ticketPrice;
	}

	public int getTicketSalesQuantity() {
		return ticketSalesQuantity;
	}

	public void setTicketSalesQuantity(int ticketSalesQuantity) {
		this.ticketSalesQuantity = ticketSalesQuantity;
	}

	public LocalDateTime getOrderDate() {
		return orderDate;
	}

	public void setOrderDate(LocalDateTime orderDate) {
		this.orderDate = orderDate;
	}

	public LocalDateTime getUpdatedAt() {
		return updatedAt;
	}

	public void setUpdatedAt(LocalDateTime updatedAt) {
		this.updatedAt = updatedAt;
	}
}
