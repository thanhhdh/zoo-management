package zooproject.service;

import org.springframework.data.domain.Pageable;
import zooproject.dto.AreaDTO;

import java.util.List;

public interface IAreaService {

    AreaDTO saveArea(AreaDTO areaDTO);

    List<AreaDTO> findAll(Pageable pageable);

    AreaDTO findById(Long id);

    Integer getTotalItem();

    void updateArea(AreaDTO areaDTO);

    void deleteById(Long id);

    void updateStatus(Long id);
}
