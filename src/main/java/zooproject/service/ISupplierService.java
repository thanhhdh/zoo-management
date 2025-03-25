package zooproject.service;

import java.util.List;

import org.springframework.data.domain.Pageable;

import zooproject.dto.SupplierDTO;

public interface ISupplierService {
	SupplierDTO insert(SupplierDTO supplierDTO);

	List<SupplierDTO> findAll(Pageable pageable);

	Integer getTotalItem();
	
	SupplierDTO findByID(Long id);
	
	void update(SupplierDTO supplierDTO);

	void delete(Long supplierId);

}
