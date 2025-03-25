package zooproject.dto;

import java.sql.Date;
import java.time.LocalDateTime;


import org.springframework.stereotype.Component;

import com.fasterxml.jackson.annotation.JsonIgnore;

@Component
public class TaskDTO extends AbstractDTO<TaskDTO> {
	private Long id;
	@JsonIgnore
	private UserDTO user;
	private CageDTO cage;
	private FoodDTO food;
	private int quantity;
	private String taskName;
	private String taskDesc;
	private int taskStatus;
	private String taskShift;
	private String taskDate;
	

	public TaskDTO() {
		super();
	}

	public UserDTO getUser() {
		return user;
	}

	public void setUser(UserDTO user) {
		this.user = user;
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
	
	public Long getId() {
		return id;
	}


	public void setId(Long id) {
		this.id = id;
	}


	public String getTaskName() {
		return taskName;
	}


	public void setTaskName(String taskName) {
		this.taskName = taskName;
	}


	public String getTaskDesc() {
		return taskDesc;
	}


	public void setTaskDesc(String taskDesc) {
		this.taskDesc = taskDesc;
	}


	public int getTaskStatus() {
		return taskStatus;
	}

	public int getQuantity() {
		return quantity;
	}

	public void setQuantity(int quantity) {
		this.quantity = quantity;
	}


	public String getTaskShift() {
		return taskShift;
	}

	public void setTaskShift(String taskShift) {
		this.taskShift = taskShift;
	}

	public void setTaskStatus(int taskStatus) {
		this.taskStatus = taskStatus;
	}
	public String getTaskDate() {
		return taskDate;
	}

	public void setTaskDate(String taskDate) {
		this.taskDate = taskDate;
	}

	

	
}