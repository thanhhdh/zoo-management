package zooproject.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import zooproject.entity.UserEntity;

import java.util.List;

@Repository
public interface UserRepository extends JpaRepository<UserEntity, Long>{
	UserEntity findByUsername(String userName);
	UserEntity findByEmail(String email);
	UserEntity findFirstByUsername(String username);
	UserEntity findById(Long idUser);

	List<UserEntity> findByFullnameContainingOrEmailContaining(String fullname, String email);
}
