package zooproject.service.impl;

import java.io.InputStream;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.transaction.annotation.Transactional;

import org.hibernate.Hibernate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Lazy;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;

import zooproject.converter.CageConverter;
import zooproject.converter.FoodConverter;
import zooproject.converter.TaskConverter;
import zooproject.converter.UserConverter;
import zooproject.dto.AnimalDTO;
import zooproject.dto.CageDTO;
import zooproject.dto.FoodDTO;
import zooproject.dto.SpeciesDTO;
import zooproject.dto.TaskDTO;
import zooproject.dto.UserDTO;
import zooproject.entity.AnimalEntity;
import zooproject.entity.CageEntity;
import zooproject.entity.FoodEntity;
import zooproject.entity.TaskEntity;
import zooproject.entity.UserEntity;
import zooproject.repository.CageRepository;
import zooproject.repository.FoodRepository;
import zooproject.repository.TaskRepository;
import zooproject.repository.UserRepository;
import zooproject.service.ITaskService;
import zooproject.service.IUserService;

@Service
public class TaskService implements ITaskService {
	@Autowired
	private TaskRepository taskRepository;

	@Autowired
	private TaskConverter taskConverter;

	@Autowired
	private UserConverter userConverter;

	@Autowired
	private IUserService userService;

	@Autowired
	private CageConverter cageConverter;

	@Autowired
	private CageService cageService;

	@Autowired
	private FoodConverter foodConverter;

	@Autowired
	private FoodService foodService;

	@Autowired
	private UserRepository userRepository;

	@Autowired
	private CageRepository cageRepository;

	@Autowired
	private FoodRepository foodRepository;

	@Override
	public TaskDTO insert(TaskDTO taskDTO) {
		// Lấy thông tin người dùng và chuồng thú
		UserDTO userDTO = userService.findByID((long) taskDTO.getUser().getId());
		CageDTO cageDTO = cageService.findByID((long) taskDTO.getCage().getId());

		// Chuyển đổi DTO sang Entity
		TaskEntity taskEntity = taskConverter.toEntity(taskDTO);
		taskEntity.setUser(userConverter.toEntity(userDTO));
		taskEntity.setCage(cageConverter.toEntity(cageDTO));

		// Lấy thông tin thực phẩm và kiểm tra số lượng
		if (taskDTO.getFood() != null) {
			FoodDTO foodDTO = foodService.findByID((long) taskDTO.getFood().getFoodId());
			if (foodDTO == null) {
				throw new RuntimeException("Food not found");
			}

			// Cập nhật số lượng thực phẩm
			int updatedQuantity = foodDTO.getFoodQuantity() - taskDTO.getFood().getFoodQuantity();
			if (updatedQuantity < 0) {
				throw new RuntimeException("Insufficient quantity of food");
			}

			// Cập nhật thông tin thực phẩm
			foodDTO.setFoodQuantity(updatedQuantity);
			foodService.insert(foodDTO); // Lưu lại thông tin thực phẩm đã cập nhật

			// Thiết lập thực phẩm cho task
			taskEntity.setFood(foodConverter.toEntity(foodDTO));
		}

		// Lưu task vào cơ sở dữ liệu
		taskEntity = taskRepository.save(taskEntity);

		// Chuyển đổi Entity sang DTO
		taskDTO = taskConverter.toDto(taskEntity);
		return taskDTO;
	}

	@Transactional(readOnly = true)
	@Override
	public List<TaskDTO> findAll(Pageable pageable) {
		List<TaskDTO> taskDTOs = new ArrayList<>();
		List<TaskEntity> taskEntities = taskRepository.findAll(pageable).getContent();

		// Khởi tạo thuộc tính lazy nếu cần thiết
		for (TaskEntity taskEntity : taskEntities) {
			Hibernate.initialize(taskEntity.getUser());
			Hibernate.initialize(taskEntity.getCage());
			taskDTOs.add(taskConverter.toDto(taskEntity));
		}

		return taskDTOs;
	}

	@Override
	public Integer getTotalItem() {
		// TODO Auto-generated method stub
		return (int) taskRepository.count();
	}

	@Override
	public TaskDTO findByID(Long id) {
		// TODO Auto-generated method stub
		TaskDTO taskDTO = taskConverter.toDto(taskRepository.findOne(id));
		return taskDTO;
	}

	@Override
	public List<TaskDTO> listAllById(Long id) {
		List<TaskDTO> taskDTOs = new ArrayList<>();
		List<TaskEntity> taskEntities = taskRepository.findByUserId(id);

		for (TaskEntity taskEntity : taskEntities) {
			taskDTOs.add(taskConverter.toDto(taskEntity));
		}
		return taskDTOs;
	}

	@Override
	public void deleteById(Long taskId) {

		taskRepository.delete(taskId);
	}

	@Override
	public TaskDTO updateTask(TaskDTO taskDTO) {

		UserDTO userDTO = userService.findById((long) taskDTO.getUser().getId());
		CageDTO cageDTO = cageService.findByID((long) taskDTO.getCage().getId());

		TaskEntity taskEntity = taskRepository.findOne(taskDTO.getId());
		taskEntity.setTaskName(taskDTO.getTaskName());
		taskEntity.setQuantity(taskDTO.getQuantity());
		taskEntity.setTaskDate(taskDTO.getTaskDate());
		taskEntity.setTaskShift(taskDTO.getTaskShift());
		taskEntity.setTaskStatus(taskDTO.getTaskStatus());
		taskEntity.setTaskDesc(taskDTO.getTaskDesc());

		taskEntity.setUser(userConverter.toEntity(userDTO));
		taskEntity.setCage(cageConverter.toEntity(cageDTO));
		if (taskDTO.getFood() != null) {
			FoodDTO foodDTO = foodService.findByID((long) taskDTO.getFood().getFoodId());
			if (foodDTO == null) {
				throw new RuntimeException("Food not found");
			}

			// Cập nhật số lượng thực phẩm
			int updatedQuantity = foodDTO.getFoodQuantity() - taskDTO.getFood().getFoodQuantity();
			if (updatedQuantity < 0) {
				throw new RuntimeException("Insufficient quantity of food");
			}

			// Cập nhật thông tin thực phẩm
			foodDTO.setFoodQuantity(updatedQuantity);
			foodService.insert(foodDTO); // Lưu lại thông tin thực phẩm đã cập nhật

			// Thiết lập thực phẩm cho task
			taskEntity.setFood(foodConverter.toEntity(foodDTO));
		}

		taskEntity = taskRepository.save(taskEntity);
		taskDTO = taskConverter.toDto(taskEntity);
		return taskDTO;
	}

	@Override
	public void saveTasks(List<TaskDTO> taskDTOs) {
		for (TaskDTO dto : taskDTOs) {
			TaskEntity entity = new TaskEntity();
			entity.setTaskName(dto.getTaskName());
			UserEntity userEntity = userRepository.findOne(dto.getUser().getId());
			entity.setUser(userEntity);

			CageEntity cageEntity = cageRepository.findOne(dto.getCage().getId());
			entity.setCage(cageEntity);

			FoodEntity foodEntity = foodRepository.findOne(dto.getFood().getFoodId());
			entity.setFood(foodEntity);

			entity.setQuantity(dto.getQuantity());
			entity.setTaskDesc(dto.getTaskDesc());
			entity.setTaskStatus(dto.getTaskStatus());
			entity.setTaskShift(dto.getTaskShift());
			entity.setTaskDate(dto.getTaskDate());

			taskRepository.save(entity);
		}

	}

	@Override
	public Map<String, Integer> getTotalFoodQuantity() {
	    List<Object[]> results = taskRepository.findTotalFoodQuantity();
	    Map<String, Integer> foodQuantityMap = new HashMap<>();

	    for (Object[] result : results) {
	        Long foodId = ((Number) result[0]).longValue(); // Convert từ Object sang Long
	        String foodName = foodRepository.findOne(foodId).getFoodName(); // Lấy foodName từ foodId	        
	        Integer totalQuantity = ((Number) result[1]).intValue(); // Convert từ Object sang Integer
	        String foodKey = foodId + "." + foodName; // Tạo key kết hợp foodId và foodName
	        foodQuantityMap.put(foodKey, totalQuantity);
	    }

	    return foodQuantityMap;
	}




}
