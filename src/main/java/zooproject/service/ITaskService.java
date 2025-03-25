package zooproject.service;

import java.io.InputStream;
import java.util.List;
import java.util.Map;

import org.springframework.data.domain.Pageable;

import zooproject.dto.TaskDTO;

public interface ITaskService {
	TaskDTO insert(TaskDTO taskDTO);

	List<TaskDTO> findAll(Pageable pageable);

	Integer getTotalItem();

	TaskDTO findByID(Long id);

	List<TaskDTO> listAllById(Long id);

	TaskDTO updateTask(TaskDTO taskDTO);

	void deleteById(Long taskId);

	void saveTasks(List<TaskDTO> taskDTOs);

	Map<String, Integer> getTotalFoodQuantity();

}
