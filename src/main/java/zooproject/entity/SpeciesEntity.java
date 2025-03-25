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
@Table(name = "tbl_species")
public class SpeciesEntity extends BaseEntity{
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "species_id")
	private Long speciesId;

	@Column(name = "species_name",columnDefinition = "varchar(255)")
	private String speciesName;

	@Column(name = "species_desc", columnDefinition = "varchar(1000)")
	private String specieDesc;

	@Column(name = "species_image", columnDefinition = "varchar(255)")
	private String speciesImage;
	
	@Column(name = "species_status", columnDefinition = "int(1)")
	private int speciesStatus;
	
	@Column(name = "species_allocation", columnDefinition = "varchar(255)")
	private String speciesAllocation;

	@Column(name = "species_reproduction", columnDefinition = "varchar(255)")
	private String speciesReproduction;
	
	@Column(name = "species_ecological", columnDefinition = "varchar(255)")
	private String speciesEcological;
	
    @OneToMany(mappedBy = "species") 
	private List<AnimalEntity> animalEntities;
	
	public SpeciesEntity() {
		super();
	}

	public SpeciesEntity(Long speciesId, String speciesName, String specieDesc, String speciesImage,
			String speciesAllocation, String speciesReproduction, String speciesEcological) {
		super();
		this.speciesId = speciesId;
		this.speciesName = speciesName;
		this.specieDesc = specieDesc;
		this.speciesImage = speciesImage;
		this.speciesAllocation = speciesAllocation;
		this.speciesReproduction = speciesReproduction;
		this.speciesEcological = speciesEcological;
	}

	public Long getSpeciesId() {
		return speciesId;
	}

	public void setSpeciesId(Long speciesId) {
		this.speciesId = speciesId;
	}

	public String getSpeciesName() {
		return speciesName;
	}

	public void setSpeciesName(String speciesName) {
		this.speciesName = speciesName;
	}

	public String getSpecieDesc() {
		return specieDesc;
	}

	public void setSpecieDesc(String specieDesc) {
		this.specieDesc = specieDesc;
	}

	public String getSpeciesImage() {
		return speciesImage;
	}

	public void setSpeciesImage(String speciesImage) {
		this.speciesImage = speciesImage;
	}

	public String getSpeciesAllocation() {
		return speciesAllocation;
	}

	public void setSpeciesAllocation(String speciesAllocation) {
		this.speciesAllocation = speciesAllocation;
	}

	public String getSpeciesReproduction() {
		return speciesReproduction;
	}

	public void setSpeciesReproduction(String speciesReproduction) {
		this.speciesReproduction = speciesReproduction;
	}

	public String getSpeciesEcological() {
		return speciesEcological;
	}

	public void setSpeciesEcological(String speciesEcological) {
		this.speciesEcological = speciesEcological;
	}

	public int getSpeciesStatus() {
		return speciesStatus;
	}

	public void setSpeciesStatus(int speciesStatus) {
		this.speciesStatus = speciesStatus;
	}

	public List<AnimalEntity> getAnimalEntities() {
		return animalEntities;
	}

	public void setAnimalEntities(List<AnimalEntity> animalEntities) {
		this.animalEntities = animalEntities;
	}
	
	
	
}