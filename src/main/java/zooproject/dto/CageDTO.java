package zooproject.dto;

import org.springframework.stereotype.Component;

import javax.validation.constraints.*;

@Component
public class CageDTO extends AbstractDTO<CageDTO> {
	private Long id;
	@NotBlank(message = "Tên chuồng không được bỏ trống")
	private String cageName;
	@NotBlank(message = "Mô tả không được bỏ trống")
	private String cageDesc;
	private AreaDTO area;
	private int cageCapacity;
	private int cageStatus;
	private String animalCount;

	public CageDTO() {
		super();
	}

	public CageDTO(Long id, String cageName, String cageDesc, AreaDTO area, int cageCapacity, int cageStatus) {
		super();
		this.id = id;
		this.cageName = cageName;
		this.cageDesc = cageDesc;
		this.area = area;
		this.cageCapacity = cageCapacity;
		this.cageStatus = cageStatus;
	}

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public int getCageStatus() {
		return cageStatus;
	}

	public void setCageStatus(int cageStatus) {
		this.cageStatus = cageStatus;
	}

	public String getCageName() {
		return cageName;
	}

	public void setCageName(String cageName) {
		this.cageName = cageName;
	}

	public String getCageDesc() {
		return cageDesc;
	}

	public void setCageDesc(String cageDesc) {
		this.cageDesc = cageDesc;
	}

	public AreaDTO getArea() {
		return area;
	}

	public void setArea(AreaDTO area) {
		this.area = area;
	}
	public int getCageCapacity() {
		return cageCapacity;
	}

	public void setCageCapacity(int cageCapacity) {
		this.cageCapacity = cageCapacity;
	}

	public String getAnimalCount() {
		return animalCount;
	}

	public void setAnimalCount(String animalCount) {
		this.animalCount = animalCount;
	}
}
