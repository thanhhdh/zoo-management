package zooproject.entity;

import javax.persistence.*;
import javax.validation.constraints.Min;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

@Entity
@Table(name = "tbl_animal")
public class AnimalEntity extends BaseEntity {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "animal_id")
	private Long animalId;

	@Column(name = "animal_name", length = 50, nullable = false)
	@Size(max = 50)
	private String animalName;

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "food_id")
	private FoodEntity food;

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "species_id")
	private SpeciesEntity species;

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "cage_id")
	private CageEntity cage;

	@Column(name = "animal_image", length = 255)
	@Size(max = 255)
	private String animalImage;

	@Column(name = "animal_age")
	@Min(0)
	private Integer animalAge;

	@Enumerated(EnumType.STRING)
	@Column(name = "animal_status", length = 20)
	private AnimalStatus animalStatus;

	@Column(name = "animal_reproduction")
	private String animalReproduction;

	@Column(name = "animal_allocation")
	private String animalAllocation;

	@Column(name = "animal_desc", length = 1000)
	@Size(max = 1000)
	private String animalDesc;

	@Column(name = "animal_ecological")
	private String animalEcological;

	@OneToMany(mappedBy = "animal", cascade = CascadeType.ALL, fetch = FetchType.LAZY)
	private List<MedicalEntity> medicalRecords = new ArrayList<>();

	@Column(name = "origin")
	private String origin;

	@Column(name = "date_of_entry")
	@NotNull(message = "Date of entry cannot be null")
	private LocalDate dateOfEntry;

	// Enum for animal status
	public enum AnimalStatus {
		HEALTHY, SICK, IN_QUARANTINE, UNDER_TREATMENT
	}

	public AnimalEntity() {
		super();
	}

	// Getters and Setters
	public Long getAnimalId() {
		return animalId;
	}

	public void setAnimalId(Long animalId) {
		this.animalId = animalId;
	}

	public String getAnimalName() {
		return animalName;
	}

	public void setAnimalName(String animalName) {
		this.animalName = animalName;
	}

	public FoodEntity getFood() {
		return food;
	}

	public void setFood(FoodEntity food) {
		this.food = food;
	}

	public SpeciesEntity getSpecies() {
		return species;
	}

	public void setSpecies(SpeciesEntity species) {
		this.species = species;
	}

	public CageEntity getCage() {
		return cage;
	}

	public void setCage(CageEntity cage) {
		this.cage = cage;
	}

	public String getAnimalImage() {
		return animalImage;
	}

	public void setAnimalImage(String animalImage) {
		this.animalImage = animalImage;
	}

	public Integer getAnimalAge() {
		return animalAge;
	}

	public void setAnimalAge(Integer animalAge) {
		this.animalAge = animalAge;
	}

	public AnimalStatus getAnimalStatus() {
		return animalStatus;
	}

	public void setAnimalStatus(AnimalStatus animalStatus) {
		this.animalStatus = animalStatus;
	}

	public String getAnimalReproduction() {
		return animalReproduction;
	}

	public void setAnimalReproduction(String animalReproduction) {
		this.animalReproduction = animalReproduction;
	}

	public String getAnimalAllocation() {
		return animalAllocation;
	}

	public void setAnimalAllocation(String animalAllocation) {
		this.animalAllocation = animalAllocation;
	}

	public String getAnimalDesc() {
		return animalDesc;
	}

	public void setAnimalDesc(String animalDesc) {
		this.animalDesc = animalDesc;
	}

	public String getAnimalEcological() {
		return animalEcological;
	}

	public void setAnimalEcological(String animalEcological) {
		this.animalEcological = animalEcological;
	}

	public List<MedicalEntity> getMedicalRecords() {
		return medicalRecords;
	}

	public void setMedicalRecords(List<MedicalEntity> medicalRecords) {
		this.medicalRecords = medicalRecords;
	}

	public String getOrigin() {
		return origin;
	}

	public void setOrigin(String origin) {
		this.origin = origin;
	}

	public LocalDate getDateOfEntry() {
		return dateOfEntry;
	}

	public void setDateOfEntry(LocalDate dateOfEntry) {
		this.dateOfEntry = dateOfEntry;
	}
}