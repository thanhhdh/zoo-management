package zooproject.entity;

import javax.persistence.*;

@Entity
@Table(name = "tbl_medical")
public class MedicalEntity extends BaseEntity {
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "medical_id")
	private Long medicalId;

	@Column(name = "medical_name")
	private String medicalName;

	@Column(name = "medical_desc")
	private String medicalDesc;

	@Column(name = "medical_status")
	private Integer medicalStatus;

	@Column(name = "medical_surgicalHistory")
	private String medicalSurgicalHistory;

	// Lịch kiểm tra định kỳ
	@Column(name = "medical_check")
	private String medicalCheck;

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "animal_id", nullable = false)
	private AnimalEntity animal;

	public MedicalEntity() {
		super();
	}

	public Long getMedicalId() {
		return medicalId;
	}

	public void setMedicalId(Long medicalId) {
		this.medicalId = medicalId;
	}

	public String getMedicalName() {
		return medicalName;
	}

	public void setMedicalName(String medicalName) {
		this.medicalName = medicalName;
	}

	public String getMedicalDesc() {
		return medicalDesc;
	}

	public void setMedicalDesc(String medicalDesc) {
		this.medicalDesc = medicalDesc;
	}

	public Integer getMedicalStatus() {
		return medicalStatus;
	}

	public void setMedicalStatus(Integer medicalStatus) {
		this.medicalStatus = medicalStatus;
	}

	public String getMedicalSurgicalHistory() {
		return medicalSurgicalHistory;
	}

	public void setMedicalSurgicalHistory(String medicalSurgicalHistory) {
		this.medicalSurgicalHistory = medicalSurgicalHistory;
	}

	public AnimalEntity getAnimal() {
		return animal;
	}

	public void setAnimal(AnimalEntity animal) {
		this.animal = animal;
	}

	public String getMedicalCheck() {
		return medicalCheck;
	}

	public void setMedicalCheck(String medicalCheck) {
		this.medicalCheck = medicalCheck;
	}

	

}
