package zooproject.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import zooproject.entity.CustomerEntity;

@Repository
public interface CustomerRepository extends JpaRepository<CustomerEntity, Long> {
    CustomerEntity findByCustomerNameAndCustomerPassword(String customerName, String customerPassword);
    CustomerEntity findByCustomerEmail(String customerEmail);
}
