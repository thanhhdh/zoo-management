package zooproject.service;

import org.springframework.data.domain.Pageable;
import zooproject.dto.QuestionDTO;
import zooproject.entity.QuestionEntity;

import java.util.List;

public interface IQuestionService {
    QuestionDTO saveQuestion(QuestionDTO questionDTO);

    QuestionDTO findById(Long id);

    void deleteById(Long id);

    Integer getTotalItem();

    List<QuestionDTO> findAll(Pageable pageable);

    void replyToQuestion(Long id, String response);

    List<QuestionEntity> findNewMessages();
}
