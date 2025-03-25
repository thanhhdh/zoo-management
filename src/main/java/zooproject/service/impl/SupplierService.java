package zooproject.service.impl;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;

import zooproject.converter.SupplierConverter;
import zooproject.dto.SupplierDTO;
import zooproject.entity.SupplierEntity;
import zooproject.repository.SupplierRepository;
import zooproject.service.ISupplierService;

import javax.persistence.EntityNotFoundException;

@Service
public class SupplierService implements ISupplierService{
	@Autowired
	private SupplierRepository supplierRepository;
	
	@Autowired
	private SupplierConverter supplierConverter;
	
	@Override
	public SupplierDTO insert(SupplierDTO supplierDTO) {
		SupplierEntity supplierEntity = supplierConverter.toEntity(supplierDTO);
		supplierEntity = supplierRepository.save(supplierEntity);
		supplierDTO = supplierConverter.toDto(supplierEntity);
		return supplierDTO;
	}

	@Override
	public List<SupplierDTO> findAll(Pageable pageable) {
		List<SupplierDTO> supplierDTOs = new ArrayList<SupplierDTO>();
		List<SupplierEntity> supplierEntities = supplierRepository.findAll(pageable).getContent();
		for(SupplierEntity supplierEntity: supplierEntities) {
			supplierDTOs.add(supplierConverter.toDto(supplierEntity));
		}
		return supplierDTOs;
	}

	@Override
	public Integer getTotalItem() {
		// TODO Auto-generated method stub
		return (int) supplierRepository.count();
	}

	@Override
	public SupplierDTO findByID(Long id) {
		SupplierDTO supplierDTO = supplierConverter.toDto(supplierRepository.findOne(id));
		return supplierDTO;
	}
	
	@Override
	public void update(SupplierDTO supplierDTO) {
		SupplierEntity supplier = supplierRepository.findOne(supplierDTO.getSupplierId());
		if(supplier == null) {
			throw new EntityNotFoundException("Supplier not found");
		}
		supplier.setSupplierName(supplierDTO.getSupplierName());
		supplier.setSupplierPhone(supplierDTO.getSupplierPhone());
		supplier.setSupplierEmail(supplierDTO.getSupplierEmail());
		supplier.setSupplierAddress(supplierDTO.getSupplierAddress());
		supplier.setSupplierDesc(supplierDTO.getSupplierDesc());
		supplierRepository.save(supplier);
	}

	@Override
	public void delete(Long supplierId) {
		supplierRepository.delete(supplierId);
	}

}
