package zooproject.dto;

import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.stereotype.Component;
import zooproject.entity.AnimalEntity.AnimalStatus;

import javax.validation.constraints.*;

import java.time.LocalDate;

@Component
public class AnimalDTO extends AbstractDTO<AnimalDTO> {
	private Long animalId;

	@NotEmpty(message = "Animal name cannot be empty")
	@Size(max = 50)
	private String animalName;

	private SpeciesDTO species;
	private CageDTO cage;
	private FoodDTO food;

	@Size(max = 255, message = "Image URL must be less than 255 characters")
	private String animalImage;

	@NotNull(message = "Age cannot be null")
	@Min(value = 0, message = "Age must be at least 0")
	@Max(value = 150, message = "Age must be at most 150")
	private Integer animalAge;

	@NotNull(message = "Animal status cannot be null")
	private AnimalStatus animalStatus; // Updated to enum type

	@Size(max = 1000, message = "Reproduction info must be less than 1000 characters")
	private String animalReproduction;

	@Size(max = 1000, message = "Allocation info must be less than 1000 characters")
	private String animalAllocation;

	@Size(max = 1000, message = "Description must be less than 1000 characters")
	private String animalDesc;

	@Size(max = 1000, message = "Ecological info must be less than 1000 characters")
	private String animalEcological;

	@Size(max = 1000, message = "Origin must be less than 1000 characters")
	private String origin;

	@NotNull(message = "Date of entry cannot be null")
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private LocalDate dateOfEntry;

	// Constructors, Getters, and Setters
	public AnimalDTO() {
		super();
	}

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

	public SpeciesDTO getSpecies() {
		return species;
	}

	public void setSpecies(SpeciesDTO species) {
		this.species = species;
	}

	public CageDTO getCage() {
		return cage;
	}

	public void setCage(CageDTO cage) {
		this.cage = cage;
	}

	public FoodDTO getFood() {
		return food;
	}

	public void setFood(FoodDTO food) {
		this.food = food;
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
