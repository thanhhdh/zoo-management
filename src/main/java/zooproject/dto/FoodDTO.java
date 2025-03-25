package zooproject.dto;

import org.springframework.stereotype.Component;

import javax.validation.constraints.NotBlank;

@Component
public class FoodDTO extends AbstractDTO<FoodDTO> {
	private Long foodId;
	@NotBlank(message = "Trường này không được để trống")
	private String foodName;
	private int foodQuantity;
	@NotBlank(message = "Trường này không được để trống")
	private String nutritionalInfo;
	@NotBlank(message = "Trường này không được để trống")
	private String expirationStart;
	@NotBlank(message = "Trường này không được để trống")
	private String expirationEnd;
	@NotBlank(message = "Trường này không được để trống")
	private String storageRequirements;
	private SupplierDTO supplier;

	public FoodDTO() {
		super();
	}

	public FoodDTO(Long foodId, String foodName, int foodQuantity, String nutritionalInfo,
			String expirationStart, String expirationEnd, String storageRequirements, SupplierDTO supplier) {
		super();
		this.foodId = foodId;
		this.foodName = foodName;
		this.foodQuantity = foodQuantity;
		this.nutritionalInfo = nutritionalInfo;
		this.expirationStart = expirationStart;
		this.expirationEnd = expirationEnd;
		this.storageRequirements = storageRequirements;
		this.supplier = supplier;
	}

	public Long getFoodId() {
		return foodId;
	}

	public void setFoodId(Long foodId) {
		this.foodId = foodId;
	}

	public String getFoodName() {
		return foodName;
	}

	public void setFoodName(String foodName) {
		this.foodName = foodName;
	}

	public int getFoodQuantity() {
		return foodQuantity;
	}

	public void setFoodQuantity(int foodQuantity) {
		this.foodQuantity = foodQuantity;
	}

	public String getNutritionalInfo() {
		return nutritionalInfo;
	}

	public void setNutritionalInfo(String nutritionalInfo) {
		this.nutritionalInfo = nutritionalInfo;
	}

	public String getExpirationStart() {
		return expirationStart;
	}

	public void setExpirationStart(String expirationStart) {
		this.expirationStart = expirationStart;
	}

	public String getExpirationEnd() {
		return expirationEnd;
	}

	public void setExpirationEnd(String expirationEnd) {
		this.expirationEnd = expirationEnd;
	}

	public String getStorageRequirements() {
		return storageRequirements;
	}

	public void setStorageRequirements(String storageRequirements) {
		this.storageRequirements = storageRequirements;
	}

	public SupplierDTO getSupplier() {
		return supplier;
	}

	public void setSupplier(SupplierDTO supplier) {
		this.supplier = supplier;
	}

}
