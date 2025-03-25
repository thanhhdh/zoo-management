package zooproject.controller.admin;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import zooproject.dto.AnimalDTO;
import zooproject.dto.MedicalDTO;
import zooproject.service.IAnimalService;
import zooproject.service.IMedicalService;

@Controller
@RequestMapping("/admin/medical")
public class MedicalController {

	@Autowired
	private IMedicalService medicalService;

	@Autowired
	private IAnimalService animalService;

	// UI: Thêm mới hồ sơ y tế
	@GetMapping("/add")
	public ModelAndView addMedical(@RequestParam("animalId") Long animalId) {
		ModelAndView modelAndView = new ModelAndView("admin/medical/add_medical");
		MedicalDTO medicalDTO = new MedicalDTO();
		AnimalDTO animalDTO = new AnimalDTO();
		animalDTO.setAnimalId(animalId); // Gắn ID động vật vào AnimalDTO
		medicalDTO.setAnimal(animalDTO); // Liên kết AnimalDTO vào MedicalDTO
		modelAndView.addObject("medical", medicalDTO);
		return modelAndView;
	}

	// Lưu hồ sơ y tế mới
	@PostMapping("/save")
	public String saveMedical(@ModelAttribute("medical") MedicalDTO medicalDTO,
							  RedirectAttributes redirectAttributes) {
		Map<String, Object> message = new HashMap<>();
		try {
			if (medicalDTO != null) {
				medicalService.insert(medicalDTO); // Lưu hồ sơ y tế
				message.put("message", "Hồ sơ y tế đã được thêm thành công!");
				message.put("type", "success");
			} else {
				throw new IllegalArgumentException("Dữ liệu không hợp lệ.");
			}
		} catch (Exception e) {
			message.put("message", "Thêm hồ sơ y tế không thành công: " + e.getMessage());
			message.put("type", "error");
		}
		redirectAttributes.addFlashAttribute("message", message);
		return "redirect:/admin/animal/list";
	}

	@GetMapping("/list")
	public String listMedicalRecords(@RequestParam("animalId") Long animalId, Model model) {
		// Lấy thông tin động vật
		List<MedicalDTO> medicalRecords = medicalService.findByAnimalId(animalId);

		// Lấy thông tin động vật
		AnimalDTO animal = animalService.findByID(animalId);

		// Gửi dữ liệu đến JSP
		model.addAttribute("animal", animal);
		model.addAttribute("medicalRecords", medicalRecords);

		return "admin/medical/list_medical";
	}


	// UI: Chỉnh sửa hồ sơ y tế
	@GetMapping("/edit")
	public ModelAndView editMedical(@RequestParam("medicalId") Long medicalId, RedirectAttributes redirectAttributes) {
		ModelAndView modelAndView = new ModelAndView();
		try {
			MedicalDTO medicalDTO = medicalService.findById(medicalId);
			if (medicalDTO == null) {
				throw new IllegalArgumentException("Không tìm thấy hồ sơ y tế.");
			}
			modelAndView.setViewName("admin/medical/edit_medical");
			modelAndView.addObject("medical", medicalDTO);
		} catch (Exception e) {
			Map<String, Object> message = new HashMap<>();
			message.put("message", "Không thể chỉnh sửa hồ sơ y tế: " + e.getMessage());
			message.put("type", "error");
			redirectAttributes.addFlashAttribute("message", message);
			modelAndView.setViewName("redirect:/admin/animal/list");
		}
		return modelAndView;
	}

	// Cập nhật hồ sơ y tế
	@PostMapping("/update")
	public String updateMedical(@ModelAttribute("medical") MedicalDTO medicalDTO,
								RedirectAttributes redirectAttributes) {
		Map<String, Object> message = new HashMap<>();
		try {
			if (medicalDTO != null) {
				medicalService.update(medicalDTO); // Cập nhật hồ sơ y tế
				message.put("message", "Hồ sơ y tế đã được cập nhật thành công!");
				message.put("type", "success");

				// Lấy animalId từ DTO
				Long animalId = medicalDTO.getAnimal().getAnimalId();

				// Điều hướng về danh sách hồ sơ y tế của động vật
				return "redirect:/admin/medical/list?animalId=" + animalId;
			} else {
				throw new IllegalArgumentException("Dữ liệu không hợp lệ.");
			}
		} catch (Exception e) {
			message.put("message", "Cập nhật hồ sơ y tế không thành công: " + e.getMessage());
			message.put("type", "error");
		}
		redirectAttributes.addFlashAttribute("message", message);

		// Trường hợp lỗi, điều hướng về danh sách chung
		return "redirect:/admin/medical/list";
	}


	@GetMapping("/delete/{medicalId}")
	public String deleteMedical(@PathVariable("medicalId") Long medicalId,
								@RequestParam("animalId") Long animalId,
								RedirectAttributes redirectAttributes) {
		Map<String, Object> message = new HashMap<>();
		try {
			// Xóa hồ sơ y tế theo ID
			medicalService.deleteMedicalById(medicalId);

			message.put("message", "Xóa hồ sơ y tế thành công!");
			message.put("type", "success");
		} catch (Exception e) {
			message.put("message", "Lỗi khi xóa hồ sơ y tế: " + e.getMessage());
			message.put("type", "error");
		}

		// Thêm thông báo vào RedirectAttributes
		redirectAttributes.addFlashAttribute("message", message);

		// Điều hướng lại danh sách hồ sơ y tế của động vật
		return "redirect:/admin/medical/list?animalId=" + animalId;
	}








//	Code of Hoang Thanh
//	@GetMapping("/admin/medical/edit")
//	public String editMedical(@RequestParam("animalId") Long animalId, Model model) {
//		//MedicalDTO medicalDTO = medicalService.findAnimalById(animalId);
//		model.addAttribute("medical", medicalService.findById(animalId));
//		return "admin/medical/edit_medical";
//	}
//
//	@PostMapping("/admin/medical/update")
//	public String updateMedical(@ModelAttribute("medical") MedicalDTO medicalDTO,
//	 							RedirectAttributes redirectAttributes) {
//		Map<String, Object> message = new HashMap<>();
//		if (medicalDTO != null) {
//
//			medicalService.update(medicalDTO);
//			message.put("message", "Dữ liệu đã được gửi thành công!");
//			message.put("type", "success");
//		} else {
//			message.put("message", "Không thành công");
//			message.put("type", "error");
//		}
//		redirectAttributes.addFlashAttribute("message", message);
//		return "redirect:/admin/animal/list";
//	}

}
