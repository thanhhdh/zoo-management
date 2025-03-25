package zooproject.dto;

import java.util.ArrayList;
import java.util.List;

import zooproject.entity.Role;

import javax.validation.constraints.NotBlank;

public class UserDTO extends AbstractDTO<UserDTO>{
	private Long id;
	@NotBlank(message = "Trường này không được để trống")
	private String fullname;
	@NotBlank(message = "Trường này không được để trống")
	private String username;
	@NotBlank(message = "Trường này không được để trống")
	private String email;
	private String password;
	private Long typeRole;
	private List<Role> roles = new ArrayList<>();
	public UserDTO() {
		super();
	}
	
	
	public UserDTO(Long id, String fullname, String username, String email, String password, Long typeRole) {
		super();
		this.id = id;
		this.fullname = fullname;
		this.username = username;
		this.email = email;
		this.password = password;
		this.typeRole = typeRole;
	}
	
	public List<Role> getRoles() {
		return roles;
	}


	public void setRoles(List<Role> roles) {
		this.roles = roles;
	}


	public Long getTypeRole() {
		return typeRole;
	}


	public void setTypeRole(Long typeRole) {
		this.typeRole = typeRole;
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
	
}
