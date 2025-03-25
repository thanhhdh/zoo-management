package zooproject.entity;

import javax.persistence.*;

import com.fasterxml.jackson.annotation.JsonIgnore;

import java.sql.Date;

@Entity
@Table(name = "tbl_task")
public class TaskEntity extends BaseEntity {
    
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "task_id")
	private Long taskId;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "user_id")
    @JsonIgnore
    private UserEntity user;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "cage_id")
    private CageEntity cage;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "food_id")
    private FoodEntity food;

    @Column(name = "food_quantity", length = 10)
    private Integer quantity;
    
    @Column(name = "task_name", columnDefinition = "varchar(50)")
    private String taskName;
    
    @Column(name = "task_decs", columnDefinition = "varchar(200)")
    private String taskDesc;
    
    @Column(name = "task_status", length = 5)
    private Integer taskStatus;
    
    @Column(name = "task_shift", columnDefinition = "varchar(20)")
    private String taskShift;
    
    @Column(name = "task_date")
    private String taskDate;

    // Getters and Setters
    public TaskEntity() {
		super();
	}

    public UserEntity getUser() {
		return user;
	}

	public Long getTaskId() {
		return taskId;
	}

	public void setTaskId(Long taskId) {
		this.taskId = taskId;
	}

	public void setTaskStatus(Integer taskStatus) {
		this.taskStatus = taskStatus;
	}

	public void setUser(UserEntity user) {
		this.user = user;
	}

	public CageEntity getCage() {
		return cage;
	}

	public void setCage(CageEntity cage) {
		this.cage = cage;
	}

	public FoodEntity getFood() {
		return food;
	}

	public void setFood(FoodEntity food) {
		this.food = food;
	}

	public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
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

    public void setTaskStatus(int taskStatus) {
        this.taskStatus = taskStatus;
    }

    public String getTaskShift() {
        return taskShift;
    }

    public void setTaskShift(String taskShift) {
        this.taskShift = taskShift;
    }

    public String getTaskDate() {
        return taskDate;
    }

    public void setTaskDate(String taskDate) {
        this.taskDate = taskDate;
    }
}
