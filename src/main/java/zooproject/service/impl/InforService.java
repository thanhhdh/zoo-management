package zooproject.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import zooproject.converter.InforConverter;
import zooproject.dto.InforDTO;
import zooproject.entity.InforEntity;
import zooproject.repository.InforRepository;
import zooproject.service.IInforService;

@Service
public class InforService implements IInforService {
	@Autowired
	private InforRepository inforRepository;

	@Override
	public InforEntity insert(InforEntity inforEntity) {
		// TODO Auto-generated method stub
		return inforRepository.save(inforEntity);
	}
}
