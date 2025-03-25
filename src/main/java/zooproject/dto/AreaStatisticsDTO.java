package zooproject.dto;

public class AreaStatisticsDTO {
    private String areaName;
    private Long totalAnimals;

    public AreaStatisticsDTO(String areaName, Long totalAnimals) {
        this.areaName = areaName;
        this.totalAnimals = totalAnimals;
    }

    public String getAreaName() {
        return areaName;
    }

    public void setAreaName(String areaName) {
        this.areaName = areaName;
    }

    public Long getTotalAnimals() {
        return totalAnimals;
    }

    public void setTotalAnimals(Long totalAnimals) {
        this.totalAnimals = totalAnimals;
    }
}
