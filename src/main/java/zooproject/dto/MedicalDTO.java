package zooproject.dto;

import org.springframework.stereotype.Component;

import java.time.LocalDate;

@Component
public class MedicalDTO extends AbstractDTO<MedicalDTO> {

	private Long medicalId;               // ID của hồ sơ y tế
	private String medicalName;           // Tên của hồ sơ y tế
	private String medicalDesc;           // Mô tả hồ sơ
	private Integer medicalStatus;        // Trạng thái (ví dụ: Hoàn thành, Đang tiến hành)
	private String medicalSurgicalHistory; // Lịch sử phẫu thuật, điều trị
	private String medicalCheck;          // Lịch kiểm tra định kỳ
	private AnimalDTO animal;             // Liên kết với động vật

	// Ngày kiểm tra sức khỏe gần nhất
	private LocalDate lastCheckupDate;

	// Ngày kiểm tra sức khỏe tiếp theo
	private LocalDate nextCheckupDate;

	public MedicalDTO() {
		super();
	}

	// Getters and Setters
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

	public String getMedicalCheck() {
		return medicalCheck;
	}

	public void setMedicalCheck(String medicalCheck) {
		this.medicalCheck = medicalCheck;
	}

	public AnimalDTO getAnimal() {
		return animal;
	}

	public void setAnimal(AnimalDTO animal) {
		this.animal = animal;
	}

	public LocalDate getLastCheckupDate() {
		return lastCheckupDate;
	}

	public void setLastCheckupDate(LocalDate lastCheckupDate) {
		this.lastCheckupDate = lastCheckupDate;
	}

	public LocalDate getNextCheckupDate() {
		return nextCheckupDate;
	}

	public void setNextCheckupDate(LocalDate nextCheckupDate) {
		this.nextCheckupDate = nextCheckupDate;
	}
}
