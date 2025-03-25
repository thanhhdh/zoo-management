package zooproject.controller.admin;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import zooproject.Utils.SendMail;
import zooproject.dto.QuestionDTO;
import zooproject.service.IQuestionService;

import java.util.HashMap;
import java.util.Map;

@Controller
@RequestMapping("/admin/questions")
public class AdminQuestionController {
    @Autowired
    private IQuestionService questionService;

    @Autowired
    private SendMail sendMail;


    // List all questions
    @GetMapping("/list")
    public String listQuestions(Model model,
                                @RequestParam(name = "page", defaultValue = "1", required = true) int page,
                                @RequestParam(name = "limit", defaultValue = "5", required = true) int limit) {
        QuestionDTO questionDTO = new QuestionDTO();
        questionDTO.setPage(page);
        questionDTO.setLimit(limit);
        questionDTO.setTotalItem(questionService.getTotalItem());
        questionDTO.setTotalPage((int) Math.ceil((double) questionDTO.getTotalItem() / questionDTO.getLimit()));

        Pageable pageable = new PageRequest(page - 1, limit);
        questionDTO.setListResult(questionService.findAll(pageable));
        model.addAttribute("questions", questionDTO);

        return "admin/question/list_question";
    }

    // View question details
    @GetMapping("/view/{id}")
    public String viewQuestion(@PathVariable("id") Long id, Model model) {
        QuestionDTO question = questionService.findById(id);
        model.addAttribute("question", question);
        return "admin/question/question_view";
    }

    // Delete a question
    @GetMapping("/delete/{id}")
    public String deleteQuestion(@PathVariable("id") Long id, RedirectAttributes redirectAttributes) {
        Map<String, Object> message = new HashMap<>();
        try {
            questionService.deleteById(id);
            message.put("message", "Question deleted successfully!");
            message.put("type", "success");
        } catch (Exception e) {
            message.put("message", "Failed to delete the question: " + e.getMessage());
            message.put("type", "error");
        }
        redirectAttributes.addFlashAttribute("message", message);
        return "redirect:/admin/questions/list";
    }

    @PostMapping("/reply")
    public String replyToQuestion(
            @RequestParam("id") Long id,
            @RequestParam("email") String email,
            @RequestParam("response") String response,
            RedirectAttributes redirectAttributes) {
        Map<String, Object> message = new HashMap<>();

        try {
            QuestionDTO question = questionService.findById(id);
            if (question == null) {
                throw new IllegalArgumentException("Question not found with ID: " + id);
            }

            // Append the original question to the response
            String fullResponse = String.format(
                    "Câu hỏi:\n\n%s\n\nPhản hồi:\n\n%s",
                    question.getContent(),
                    response
            );

            sendMail.sendEmailFAQ(email, "ZooVKU phản hồi câu hỏi", fullResponse);
            questionService.replyToQuestion(id, response);

            message.put("message", "Trả lời đã được gửi thành công!");
            message.put("type", "success");
        } catch (Exception e) {
            message.put("message", "Phản hồi thất bại: " + e.getMessage());
            message.put("type", "error");
        }
        redirectAttributes.addFlashAttribute("message", message);
        return "redirect:/admin/questions/list";
    }


}
