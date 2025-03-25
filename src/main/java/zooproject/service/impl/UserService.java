package zooproject.service.impl;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collections;
import java.util.List;
import java.util.Optional;

import javax.persistence.EntityManager;
import javax.servlet.ServletContext;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import zooproject.config.Constant;
import zooproject.converter.UserConverter;
import zooproject.dto.CageDTO;
import zooproject.dto.UserDTO;
import zooproject.entity.Role;
import zooproject.entity.UserEntity;
import zooproject.repository.RoleRepository;
import zooproject.repository.UserRepository;
import zooproject.security.SecurityUtils;
import zooproject.service.IUserService;

@Service
public class UserService implements IUserService {

	private static Logger logger = Logger.getLogger(UserService.class);

	private UserRepository userRepository;
	private RoleRepository roleRepository;
	private PasswordEncoder passwordEncoder;
	private EntityManager entityManager;
	private UserConverter userConverter;
	private ServletContext servletContext;

	@Autowired
	public UserService(UserRepository userRepository, RoleRepository roleRepository,
			PasswordEncoder passwordEncoder, EntityManager entityManager, UserConverter userConverter,
			ServletContext servletContext) {
		super();
		this.userRepository = userRepository;
		this.roleRepository = roleRepository;
		this.passwordEncoder = passwordEncoder;
		this.entityManager = entityManager;
		this.userConverter = userConverter;
		this.servletContext = servletContext;
	}

	@Override
	@Transactional
	public void saveUser(UserDTO userDTO) {
		UserEntity userEntity = null;

		// Kiểm tra nếu userDTO có ID, thì lấy user từ database
		if (userDTO.getId() != null) {
			userEntity = userRepository.findById(userDTO.getId());
		}

		// Nếu userEntity vẫn là null, nghĩa là không tìm thấy, tạo mới
		if (userEntity == null) {
			userEntity = new UserEntity();
			userEntity.setPassword(passwordEncoder.encode(userDTO.getPassword())); // Mã hóa mật khẩu khi tạo mới
		}

		// Thiết lập thông tin từ DTO vào entity
		userEntity.setFullname(userDTO.getFullname());
		userEntity.setUsername(userDTO.getUsername());
		userEntity.setEmail(userDTO.getEmail());

		// Đặt vai trò cho người dùng
		String roleName = getRoleNameByType(userDTO.getTypeRole());
		Role role = roleRepository.findByName(roleName);
		if (role != null && !entityManager.contains(role)) {
			role = entityManager.merge(role);
		}
		userEntity.setRoles(new ArrayList<>(Arrays.asList(role))); // Chuyển thành ArrayList có thể sửa đổi

		try {
			userRepository.save(userEntity);
			System.out.println("User saved successfully: " + userEntity);
		} catch (Exception e) {
			System.out.println("Error saving user: " + e.getMessage());
			throw e;
		}
	}

	@Override
	@Transactional
	public String updateRoleUser(Long idUser, Long idRole) {
		Optional<UserEntity> optionalUser = Optional.ofNullable(userRepository.findById(idUser));
		if (!optionalUser.isPresent()) {
			throw new RuntimeException("User not found");
		}

		UserEntity userEntity = optionalUser.get();

		// Kiểm tra quyền của người dùng
		if (userEntity.getUsername().equals(SecurityUtils.getSessionUser())) {
			return "permission_error";
		}

		// Xóa tất cả vai trò hiện tại của người dùng
		userEntity.getRoles().clear();

		// Tìm kiếm vai trò mới
		String roleName = getRoleNameByType(idRole);
		Role role = roleRepository.findByName(roleName);

		// Nếu vai trò không nằm trong EntityManager, thực hiện merge
		if (role != null && !entityManager.contains(role)) {
			role = entityManager.merge(role);
		}

		// Đặt vai trò mới cho người dùng
		userEntity.setRoles(new ArrayList<>(Arrays.asList(role))); // Tạo danh sách có thể sửa đổi

		// Lưu người dùng
		userEntity = userRepository.save(userEntity);

		// Trả về giá trị tương ứng dựa trên vai trò
		return getRoleNameByType(userEntity.getRoles().get(0).getId());
	}

	private String getRoleNameByType(Long type) {
		switch (Integer.parseInt(type.toString())) {
		case Constant.IS_ROLE_ADMIN:
			return "ROLE_ADMIN";
		case Constant.IS_ROLE_MANAGER:
			return "ROLE_MANAGER";
		case Constant.IS_ROLE_EMPLOYEE:
			return "ROLE_EMPLOYEE";
		default:
			throw new IllegalArgumentException("Invalid role type: " + type);
		}
	}

	@Override
	public String outputAdmin(List<UserDTO> admins) {

		logger.info(SecurityUtils.getAuthoritties().get(0));

		String contextPath = servletContext.getContextPath();
		StringBuilder output = new StringBuilder();
		for (UserDTO admin : admins) {
			if (admin.getRoles() != null && !admin.getRoles().isEmpty()) {
				if (admin.getRoles().get(0).getId() == 4) {
					continue;
				}
				output.append("<tr>").append("<td>").append(admin.getId()).append("</td>").append("<td>")
						.append(admin.getFullname()).append("</td>").append("<td>").append(admin.getUsername())
						.append("</td>").append("<td>").append(admin.getEmail()).append("</td>").append("<td>")
						.append("<input type='radio' class='form-check-input' name='roles").append(admin.getId())
						.append("' ");
				if (admin.getRoles().get(0).getId() == 1) {
					output.append("checked ");
				}
				output.append("value='1' data-admin_id='").append(admin.getId()).append("'>").append("</td>")
						.append("<td>").append("<input type='radio' class='form-check-input' name='roles")
						.append(admin.getId()).append("' ");
				if (admin.getRoles().get(0).getId() == 2) {
					output.append("checked ");
				}
				output.append("value='2' data-admin_id='").append(admin.getId()).append("'>").append("</td>")
						.append("<td>").append("<input type='radio' class='form-check-input' name='roles")
						.append(admin.getId()).append("' ");
				if (admin.getRoles().get(0).getId() == 3) {
					output.append("checked ");
				}
				output.append("value='3' data-admin_id='").append(admin.getId()).append("'>").append("</td>")
						.append("<td>").append("<div style='margin-top: 10px'>")
						.append("<button type='button' class='btn-sm btn-gradient-dark btn-rounded btn-fw btn-delete-admin-roles' data-admin_id='")
						.append(admin.getId()).append("'>Xóa Quyền</button>").append("</div>")
						.append("<div style='margin-top: 10px'>").append("<a href='").append(contextPath)
						.append("/admin/account-admin/add?admin_id=").append(admin.getId())
						.append("'><button type='button' class='btn-sm btn-gradient-danger btn-dangee btn-fw'>Chỉnh sửa</button></a>")
						.append("</div>").append("</td>").append("</tr>");
			}
		}

		return output.toString();
	}

	@Override
	public UserEntity findByUserName(String userName) {
		// TODO Auto-generated method stub
		return userRepository.findByUsername(userName);
	}

	@Override
	public UserEntity findByEmail(String email) {
		// TODO Auto-generated method stub
		return userRepository.findByEmail(email);
	}

	@Override
	public List<UserDTO> getListUser() {
		// TODO Auto-generated method stub
		List<UserDTO> userDTOs = new ArrayList<>();
		List<UserEntity> userEntities = userRepository.findAll();
		for (UserEntity userEntity : userEntities) {
			userDTOs.add(userConverter.toDto(userEntity));
		}
		return userDTOs;
	}

	@Override
	public String loadTableListUser() {
		// TODO Auto-generated method stub
		List<UserDTO> userDTOs = getListUser();
		return outputAdmin(userDTOs);
	}

	@Override
	public UserDTO findByID(Long id) {
		UserDTO cageDTO = userConverter.toDto(userRepository.findOne(id));
		return cageDTO;
	}

	@Override
	public String deleteAdmin(Long id) {
		// TODO Auto-generated method stub
		UserEntity userEntity = userRepository.findById(id);
		if (userEntity.getUsername().equals(SecurityUtils.getSessionUser())) {
			return "error_delete_admin";
		} else {
			userEntity.getRoles().clear();
			userRepository.delete(userEntity);
			return "true";
		}

	}
	@Override
	public UserDTO findById(Long id) {
		UserDTO userDTO = userConverter.toDto(userRepository.findOne(id));
		return userDTO;
	}

	@Override
	public List<UserDTO> searchAdminByNameOrEmail(String keyword) {
		List<UserEntity> admins = userRepository.findByFullnameContainingOrEmailContaining(keyword, keyword);
		List<UserDTO> adminDTOs = new ArrayList<>();
		for (UserEntity admin : admins) {
			adminDTOs.add(userConverter.toDto(admin));
		}
		return adminDTOs;
	}

}
