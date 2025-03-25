package zooproject.dto;

import org.springframework.stereotype.Component;
import zooproject.entity.AreaEntity;

import javax.validation.constraints.Min;
import javax.validation.constraints.NotBlank;

@Component
public class AreaDTO extends AbstractDTO<AreaDTO> {
    private Long id;

    @NotBlank(message = "Tên khu vực không được bỏ trống")
    private String areaName;

    @NotBlank(message = "Mô tả không được bỏ trống")
    private String areaDesc;

    // Số lượng chuồng trong khu vực
    @Min(value = 0, message = "Số lượng chuồng không được nhỏ hơn 0")
    private Integer currentCages;

    // Sức chứa tối đa của khu vực
    @Min(value = 1, message = "Sức chứa không được nhỏ hơn 1")
    private Integer maxCapacity;

    // Trạng thái của khu vực (có thể là 1 - đang hoạt động, 0 - không hoạt động)
    private Integer areaStatus;

    // Vị trí của khu vực
    @NotBlank(message = "Vị trí không được bỏ trống")
    private String areaLocation;

    // Constructor mặc định
    public AreaDTO() {
        super();
    }

    // Constructor có tham số
    public AreaDTO(Long id, String areaName, String areaDesc, int currentCages, int maxCapacity, int areaStatus, String areaLocation) {
        super();
        this.id = id;
        this.areaName = areaName;
        this.areaDesc = areaDesc;
        this.currentCages = currentCages;
        this.maxCapacity = maxCapacity;
        this.areaStatus = areaStatus;
        this.areaLocation = areaLocation;
    }

    // Getters và Setters
    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
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

    public Integer getCurrentCages() {
        return currentCages;
    }

    public void setCurrentCages(Integer currentCages) {
        this.currentCages = currentCages;
    }

    public Integer getMaxCapacity() {
        return maxCapacity;
    }

    public void setMaxCapacity(Integer maxCapacity) {
        this.maxCapacity = maxCapacity;
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
}