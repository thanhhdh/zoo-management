package zooproject.entity;

import java.util.List;

import javax.persistence.*;

@Entity
@Table(name = "tbl_cage")
public class CageEntity extends BaseEntity {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "cage_id")
	private Long cageId;

	@Column(name = "cage_name", columnDefinition = "varchar(255)")
	private String cageName;

	@Column(name = "cage_decs", columnDefinition = "varchar(1000)")
	private String cageDesc;

//	@Column(name = "cage_area", columnDefinition = "varchar(255)")
//	private String cageArea;

	@Column(name = "cage_capacity", columnDefinition = "int(11)")
	private Integer cageCapacity;

	@Column(name = "cage_status", columnDefinition = "int(1)")
	private Integer cageStatus;

	// Quan hệ ManyToOne với AreaEntity
	@ManyToOne
	@JoinColumn(name = "area_id", nullable = false)
	private AreaEntity area;

	@OneToMany(mappedBy = "cage")
	private List<AnimalEntity> animalEntities;
	@OneToMany(mappedBy = "cage")
	private List<TaskEntity> taskEntities;

	@Transient
	private String animalCount;

	public List<TaskEntity> getTaskEntities() {
		return taskEntities;
	}

	public void setTaskEntities(List<TaskEntity> taskEntities) {
		this.taskEntities = taskEntities;
	}

	public Long getCageId() {
		return cageId;
	}

	public void setCageId(Long cageId) {
		this.cageId = cageId;
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


	public AreaEntity getArea() {
		return area;
	}

	public void setArea(AreaEntity area) {
		this.area = area;
	}

	public Integer getCageCapacity() {
		return cageCapacity;
	}

	public void setCageCapacity(Integer cageCapacity) {
		this.cageCapacity = cageCapacity;
	}

	public Integer getCageStatus() {
		return cageStatus;
	}

	public void setCageStatus(Integer cageStatus) {
		this.cageStatus = cageStatus;
	}



	public List<AnimalEntity> getAnimalEntities() {
		return animalEntities;
	}

	public void setAnimalEntities(List<AnimalEntity> animalEntities) {
		this.animalEntities = animalEntities;
	}

	public String getAnimalCount() {
		return animalCount;
	}

	public void setAnimalCount(String animalCount) {
		this.animalCount = animalCount;
	}

}
