package zooproject.controller.web;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import zooproject.dto.QuestionDTO;
import zooproject.service.IQuestionService;

import java.util.HashMap;
import java.util.Map;

@Controller
public class QuestionController {
    @Autowired
    private IQuestionService questionService;

    @GetMapping("/cau-hoi")
    public String showQuestionForm() {
        return "web/question"; // Name of the JSP file
    }

    @RequestMapping(value = "/cau-hoi", method = RequestMethod.POST)
    public String submitQuestion(
            @ModelAttribute("question") QuestionDTO questionDTO,
            RedirectAttributes redirectAttributes) {

        Map<String, Object> message = new HashMap<>();

        try {
            // Save the question using the service
            questionService.saveQuestion(questionDTO);

            // Set success message
            message.put("message", "Câu hỏi của bạn đã được gửi thành công!");
            message.put("type", "success");
        } catch (Exception e) {
            // Set error message
            message.put("message", "Không gửi được câu hỏi của bạn. Vui lòng thử lại.");
            message.put("type", "error");
        }

        // Add message to redirect attributes
        redirectAttributes.addFlashAttribute("message", message);

        // Redirect back to the form page
        return "redirect:/cau-hoi";
    }

}
