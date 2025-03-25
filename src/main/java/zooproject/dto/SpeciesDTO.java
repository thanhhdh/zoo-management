package zooproject.dto;

import org.springframework.stereotype.Component;
import javax.validation.constraints.NotEmpty;


import javax.validation.constraints.NotEmpty;


@Component
public class SpeciesDTO extends AbstractDTO<SpeciesDTO>{
	private Long id;
	@NotEmpty(message = "Trường này không được để trống")
	private String speciesName;
	@NotEmpty(message = "Trường này không được để trống")
	private String specieDesc;
	private String speciesImage;
	private int speciesStatus;
	@NotEmpty(message = "Trường này không được để trống")
	private String speciesAllocation;
	@NotEmpty(message = "Trường này không được để trống")
	private String speciesReproduction;
	@NotEmpty(message = "Trường này không được để trống")
	private String speciesEcological;

	
	public SpeciesDTO() {
		super();
	}
	public SpeciesDTO(Long id, String speciesName, String specieDesc, String speciesImage, int speciesStatus, String speciesAllocation,
			String speciesReproduction, String speciesEcological) {
		super();
		this.id = id; 
		this.speciesName = speciesName;
		this.specieDesc = specieDesc;
		this.speciesImage = speciesImage;
		this.speciesStatus = speciesStatus;
		this.speciesAllocation = speciesAllocation;
		this.speciesReproduction = speciesReproduction;
		this.speciesEcological = speciesEcological;
	}
	public Long getId() {
		return id;
	}
	public void setId(Long id) {
		this.id = id;
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
	
	
	
}
