package zooproject.service;

import java.util.List;

import zooproject.dto.UserDTO;
import zooproject.entity.UserEntity;

public interface IUserService {
	void saveUser(UserDTO userDTO);

	UserEntity findByUserName(String userName);

	UserEntity findByEmail(String email);

	List<UserDTO> getListUser();

	String loadTableListUser();

	String updateRoleUser(Long idUser, Long idRole);

	UserDTO findByID(Long id);

	String deleteAdmin(Long id);

	UserDTO findById(Long id);

	List<UserDTO> searchAdminByNameOrEmail(String keyword);

	String outputAdmin(List<UserDTO> adminList);
}
