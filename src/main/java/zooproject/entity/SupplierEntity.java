package zooproject.entity;

import java.util.List;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.OneToMany;
import javax.persistence.Table;

@Entity
@Table(name = "tbl_supplier")
public class SupplierEntity extends BaseEntity {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "supplier_id")
	private Long supplierId;

	@Column(name = "supplier_name", columnDefinition = "varchar(255)")
	private String supplierName;

	@Column(name = "supplier_phone", columnDefinition = "varchar(10)")
	private String supplierPhone;

	@Column(name = "supplier_email", columnDefinition = "varchar(50)")
	private String supplierEmail;

	@Column(name = "supplier_address", columnDefinition = "varchar(255)")
	private String supplierAddress;

	@Column(name = "supplier_desc", columnDefinition = "varchar(1000)")
	private String supplierDesc;

	@OneToMany(mappedBy = "supplier")
	private List<FoodEntity> foodEntities;

	public SupplierEntity() {
		super();
	}

	public SupplierEntity(Long supplierId, String supplierName, String supplierPhone, String supplierEmail,
			String supplierAddress, String supplierDesc, List<FoodEntity> foodEntities) {
		super();
		this.supplierId = supplierId;
		this.supplierName = supplierName;
		this.supplierPhone = supplierPhone;
		this.supplierEmail = supplierEmail;
		this.supplierAddress = supplierAddress;
		this.supplierDesc = supplierDesc;
		this.foodEntities = foodEntities;
	}

	public List<FoodEntity> getFoodEntities() {
		return foodEntities;
	}

	public void setFoodEntities(List<FoodEntity> foodEntities) {
		this.foodEntities = foodEntities;
	}

	public Long getSupplierId() {
		return supplierId;
	}

	public void setSupplierId(Long supplierId) {
		this.supplierId = supplierId;
	}

	public String getSupplierName() {
		return supplierName;
	}

	public void setSupplierName(String supplierName) {
		this.supplierName = supplierName;
	}

	public String getSupplierPhone() {
		return supplierPhone;
	}

	public void setSupplierPhone(String supplierPhone) {
		this.supplierPhone = supplierPhone;
	}

	public String getSupplierEmail() {
		return supplierEmail;
	}

	public void setSupplierEmail(String supplierEmail) {
		this.supplierEmail = supplierEmail;
	}

	public String getSupplierAddress() {
		return supplierAddress;
	}

	public void setSupplierAddress(String supplierAddress) {
		this.supplierAddress = supplierAddress;
	}

	public String getSupplierDesc() {
		return supplierDesc;
	}

	public void setSupplierDesc(String supplierDesc) {
		this.supplierDesc = supplierDesc;
	}
}
