package zooproject.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import zooproject.entity.CustomerEntity;
import zooproject.repository.CustomerRepository;
import zooproject.service.ICustomerService;

@Service
public class CustomerService implements ICustomerService {
	@Autowired
	private CustomerRepository customerRepository;

	public CustomerEntity checkLoginCustomer(String name, String pass) {
		return customerRepository.findByCustomerNameAndCustomerPassword(name, pass);
	}

	public CustomerEntity registerCustomer(CustomerEntity customerEntity) {
		return customerRepository.save(customerEntity);
	}

	public CustomerEntity checkAccount(String email) {
		return customerRepository.findByCustomerEmail(email);
	}
}
