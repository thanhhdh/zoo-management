package zooproject.entity;

import java.util.ArrayList;
import java.util.List;

import javax.persistence.*;


@Entity(name = "tbl_users")
public class UserEntity extends BaseEntity{
	@Id 
	@GeneratedValue(strategy = GenerationType.IDENTITY) 
	private Long id;
	@Column (name= "full_name", columnDefinition = "varchar(255)")
	private String fullname;
	
	@Column (name= "user_name", columnDefinition = "varchar(255)")
	private String username;
	
	private String email;
	private String password;
	@ManyToMany(fetch = FetchType.EAGER , cascade = CascadeType.ALL)
	@JoinTable(
			name = "user_roles",
			joinColumns = {@JoinColumn(name ="user_id",referencedColumnName = "id")},
			inverseJoinColumns = {@JoinColumn(name ="role_id",referencedColumnName = "id")}
			
	)
	private List<Role> roles = new ArrayList<>();
	@OneToMany(mappedBy = "user")
	private List<TaskEntity> taskEntities;
	
	public List<TaskEntity> getTaskEntities() {
		return taskEntities;
	}

	public void setTaskEntities(List<TaskEntity> taskEntities) {
		this.taskEntities = taskEntities;
	}

	public UserEntity() {}
	
	public UserEntity(Long id, String username, String email, String password, List<Role> roles) {
		super();
		this.id = id;
		this.username = username;
		this.email = email;
		this.password = password;
		this.roles = roles;
	}

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}
	
	public String getFullname() {
		return fullname;
	}

	public void setFullname(String fullname) {
		this.fullname = fullname;
	}

	public String getUsername() {
		return username;
	}

	public void setUsername(String username) {
		this.username = username;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public List<Role> getRoles() {
		return roles;
	}

	public void setRoles(List<Role> roles) {
		this.roles = roles;
	}
	

}
