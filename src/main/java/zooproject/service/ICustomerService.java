package zooproject.service;

import zooproject.entity.CustomerEntity;

public interface ICustomerService {
	CustomerEntity checkLoginCustomer(String name, String pass);

	CustomerEntity registerCustomer(CustomerEntity customerEntity);

	CustomerEntity checkAccount(String email);
}
