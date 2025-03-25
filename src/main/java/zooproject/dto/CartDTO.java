package zooproject.dto;

public class CartDTO {
	private int id;
	private String ticketName;
	private double ticketPrice;
	private int ticketQty;

	public CartDTO() {
		super();
	}

	public CartDTO(int id, String ticketName, double ticketPrice, int ticketQty) {
		super();
		this.id = id;
		this.ticketName = ticketName;
		this.ticketPrice = ticketPrice;
		this.ticketQty = ticketQty;
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
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

	public int getTicketQty() {
		return ticketQty;
	}

	public void setTicketQty(int ticketQty) {
		this.ticketQty = ticketQty;
	}

}
