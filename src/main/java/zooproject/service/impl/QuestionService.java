package zooproject.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;
import zooproject.converter.QuestionConverter;
import zooproject.dto.AreaDTO;
import zooproject.dto.QuestionDTO;
import zooproject.dto.SpeciesDTO;
import zooproject.entity.AreaEntity;
import zooproject.entity.QuestionEntity;
import zooproject.entity.SpeciesEntity;
import zooproject.entity.SupplierEntity;
import zooproject.repository.QuestionRepository;
import zooproject.service.IQuestionService;

import java.util.ArrayList;
import java.util.List;

@Service
public class QuestionService implements IQuestionService {
    @Autowired
    private QuestionRepository questionRepository;
    @Autowired
    private QuestionConverter questionConverter;

    @Override
    public QuestionDTO saveQuestion(QuestionDTO questionDTO) {
        QuestionEntity questionEntity = questionConverter.toEntity(questionDTO);
        questionEntity = questionRepository.save(questionEntity);
        questionDTO = questionConverter.toDto(questionEntity);
        return questionDTO;
    }

    @Override
    public QuestionDTO findById(Long id) {
        QuestionDTO questionDTO = questionConverter.toDto(questionRepository.findOne(id));
        return questionDTO;
    }

    @Override
    public void deleteById(Long id) {
        questionRepository.delete(id);
    }

    @Override
    public Integer getTotalItem() {
        return (int) questionRepository.count();
    }

    @Override
    public List<QuestionDTO> findAll(Pageable pageable) {
        List<QuestionDTO> questionDTOs = new ArrayList<QuestionDTO>();
        List<QuestionEntity> questionEntities = questionRepository.findAll(pageable).getContent();
        for(QuestionEntity questionEntity: questionEntities) {
            questionDTOs.add(questionConverter.toDto(questionEntity));
        }
        return questionDTOs;
    }

    @Override
    public void replyToQuestion(Long id, String response) {
        QuestionEntity question = questionRepository.findOne(id);
        question.setResponse(response);
        question.setStatus("Replied");
        questionRepository.save(question);
    }

    @Override
    public List<QuestionEntity> findNewMessages() {
        return questionRepository.findByResponseIsNull();
    }

}
