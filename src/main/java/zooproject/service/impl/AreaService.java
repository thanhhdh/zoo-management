package zooproject.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;
import zooproject.converter.AreaConverter;
import zooproject.dto.AreaDTO;
import zooproject.entity.AreaEntity;
import zooproject.entity.CageEntity;
import zooproject.repository.AreaRepository;
import zooproject.repository.CageRepository;
import zooproject.service.IAreaService;

import java.util.ArrayList;
import java.util.List;

@Service
public class AreaService implements IAreaService {
    @Autowired
    private AreaRepository areaRepository;

    @Autowired
    private CageRepository cageRepository;

    @Autowired
    private AreaConverter areaConverter;

    @Override
    public AreaDTO saveArea(AreaDTO areaDTO) {
        AreaEntity areaEntity = areaConverter.toEntity(areaDTO);
        areaEntity = areaRepository.save(areaEntity);
        areaDTO = areaConverter.toDto(areaEntity);
        return areaDTO;
    }

    @Override
    public List<AreaDTO> findAll(Pageable pageable) {
        List<AreaDTO> areas = new ArrayList<>();
        List<AreaEntity> areasEntities = areaRepository.findAll(pageable).getContent();
        for(AreaEntity areaEntity : areasEntities) {
            AreaDTO areaDTO = areaConverter.toDto(areaEntity);
            int currentCages = cageRepository.countByAreaId(areaEntity.getAreaId());
            areaDTO.setCurrentCages(currentCages);

            areas.add(areaDTO);
        }
        return areas;
    }

    @Override
    public AreaDTO findById(Long id) {
        AreaDTO areaDTO = areaConverter.toDto(areaRepository.findOne(id));
        return areaDTO;
    }

    @Override
    public Integer getTotalItem() {
        return (int) areaRepository.count();
    }

    @Override
    public void updateArea(AreaDTO areaDTO) {
        // Tìm kiếm AreaEntity từ cơ sở dữ liệu bằng ID
        AreaEntity areaEntity = areaRepository.findOne(areaDTO.getId());

        if (areaEntity != null) {
            // Cập nhật các thuộc tính từ AreaDTO
            areaEntity.setAreaName(areaDTO.getAreaName());
            areaEntity.setAreaDesc(areaDTO.getAreaDesc());
            areaEntity.setMaxCapacity(areaDTO.getMaxCapacity());
            areaEntity.setAreaStatus(areaDTO.getAreaStatus());
            areaEntity.setAreaLocation(areaDTO.getAreaLocation());

            // Lưu lại đối tượng đã được cập nhật
            areaRepository.save(areaEntity);
        } else {
            // Xử lý nếu không tìm thấy khu vực (tùy chọn)
            throw new RuntimeException("Khu vực không tồn tại với ID: " + areaDTO.getId());
        }

    }

    @Override
    public void deleteById(Long id) {
        areaRepository.delete(id);
    }

    @Override
    public void updateStatus(Long id) {
        AreaEntity areaEntity = areaRepository.findOne(id);
        if (areaEntity.getAreaStatus() == 1) {
            areaEntity.setAreaStatus(0);
        } else {
            areaEntity.setAreaStatus(1);
        }
        areaRepository.save(areaEntity);
    }
}
