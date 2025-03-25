package zooproject.entity;

import java.util.List;

import javax.persistence.*;

@Entity
@Table(name = "tbl_food")
public class FoodEntity extends BaseEntity {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "food_id")
	private Long foodId;

	@Column(name = "food_name", length = 255)
	private String foodName;

	@Column(name = "food_quantity")
	private int foodQuantity;

	// Thông tin dinh dưỡng
	@Column(name = "nutritional_info", length = 255)
	private String nutritionalInfo;

	@Column(name = "expiration_start", length = 255)
	private String expirationStart;

	@Column(name = "expiration_end", length = 255)
	private String expirationEnd;

	@Column(name = "storage_requirements", length = 255)
	private String storageRequirements;

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "supplier_id")
	private SupplierEntity supplier;
	
	@OneToMany(mappedBy = "food")
	private List<TaskEntity> taskEntities;
	
	@OneToMany(mappedBy = "food")
	private List<AnimalEntity> animalEntities;

	public FoodEntity() {
		super();
	}

	public FoodEntity(Long foodId, String foodName, int foodQuantity, String nutritionalInfo,
			String expirationStart, String expirationEnd, String storageRequirements, SupplierEntity supplierEntity) {
		super();
		this.foodId = foodId;
		this.foodName = foodName;
		this.foodQuantity = foodQuantity;
		this.nutritionalInfo = nutritionalInfo;
		this.expirationStart = expirationStart;
		this.expirationEnd = expirationEnd;
		this.storageRequirements = storageRequirements;
		this.supplier = supplierEntity;
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

	public SupplierEntity getSupplierEntity() {
		return supplier;
	}

	public void setSupplierEntity(SupplierEntity supplierEntity) {
		this.supplier = supplierEntity;
	}

}
