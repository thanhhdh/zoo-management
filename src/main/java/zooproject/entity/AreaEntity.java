package zooproject.entity;

import javax.persistence.*;
import javax.validation.constraints.Min;
import java.util.List;

@Entity
@Table(name = "tbl_area")
public class AreaEntity extends BaseEntity {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "area_id")
    private Long areaId;

    @Column(name = "area_name", columnDefinition = "varchar(255)")
    private String areaName;

    @Column(name = "area_desc", columnDefinition = "varchar(1000)")
    private String areaDesc;

    @Min(value = 1, message = "Sức chứa không được nhỏ hơn 1")
    @Column(name = "max_capacity")
    private Integer maxCapacity;

    @Column(name = "current_cages")
    private Integer currentCages;

    @Column(name = "area_status")
    private Integer areaStatus;

    // Quan hệ OneToMany với CageEntity
    @OneToMany(mappedBy = "area", cascade = CascadeType.ALL, fetch = FetchType.LAZY)
    private List<CageEntity> cageEntities;

    @Column(name = "area_location")
    private String areaLocation;

    @Min(value = 1, message = "Sức chứa không được nhỏ hơn 1")
    public Integer getMaxCapacity() {
        return maxCapacity;
    }

    public void setMaxCapacity(@Min(value = 1, message = "Sức chứa không được nhỏ hơn 1") Integer maxCapacity) {
        this.maxCapacity = maxCapacity;
    }

    public Integer getCurrentCages() {
        return currentCages;
    }

    public void setCurrentCages(Integer currentCages) {
        this.currentCages = currentCages;
    }

    public Integer getAreaStatus() {
        return areaStatus;
    }

    public void setAreaStatus(Integer areaStatus) {
        this.areaStatus = areaStatus;
    }

    public String getAreaLocation() {
        return areaLocation;
    }

    public void setAreaLocation(String areaLocation) {
        this.areaLocation = areaLocation;
    }

    // Getters và Setters
    public Long getAreaId() {
        return areaId;
    }

    public void setAreaId(Long areaId) {
        this.areaId = areaId;
    }

    public String getAreaName() {
        return areaName;
    }

    public void setAreaName(String areaName) {
        this.areaName = areaName;
    }

    public String getAreaDesc() {
        return areaDesc;
    }

    public void setAreaDesc(String areaDesc) {
        this.areaDesc = areaDesc;
    }

    public List<CageEntity> getCageEntities() {
        return cageEntities;
    }

    public void setCageEntities(List<CageEntity> cageEntities) {
        this.cageEntities = cageEntities;
    }
}
