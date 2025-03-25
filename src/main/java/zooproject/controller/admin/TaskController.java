package zooproject.controller.admin;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import zooproject.dto.TaskDTO;
import zooproject.dto.UserDTO;
import zooproject.entity.UserEntity;
import zooproject.dto.CageDTO;
import zooproject.dto.FoodDTO;
import zooproject.service.ITaskService;
import zooproject.service.IUserService;
import zooproject.service.ICageService;
import zooproject.service.IFoodService;

@Controller
public class TaskController {

	private ITaskService iTaskService;
	private IUserService iUserService;
	private ICageService iCageService;
	private IFoodService iFoodService;
	private TaskDTO taskDTO;
//	private UserDTO userDTO;
	private CageDTO cageDTO;
	private FoodDTO foodDTO;

	@Autowired
	public TaskController(ITaskService iTaskService, IUserService iUserService, ICageService iCageService,
			IFoodService iFoodService, TaskDTO taskDTO, FoodDTO foodDTO, CageDTO cageDTO) {
		this.iTaskService = iTaskService;
		this.iUserService = iUserService;
		this.iCageService = iCageService;
		this.iFoodService = iFoodService;
		this.taskDTO = taskDTO;
//		this.userDTO = userDTO;
		this.foodDTO = foodDTO;
		this.cageDTO = cageDTO;
	}


	// UI add info food
	@RequestMapping(value = "/admin/task/add", method = RequestMethod.GET)
	public ModelAndView addTask() {
		ModelAndView modelAndView = new ModelAndView("admin/task/add_task");
		List<UserDTO> userDTOs = iUserService.getListUser();
		List<CageDTO> cageDTOes = iCageService.findAll(null);
		List<TaskDTO> taskDTOes = iTaskService.findAll(null);
		List<FoodDTO> foodDTOs = iFoodService.findAll(null);

		modelAndView.addObject("user", userDTOs);
		modelAndView.addObject("cages", cageDTOes);
		modelAndView.addObject("task", taskDTOes);
		modelAndView.addObject("foods", foodDTOs);

		return modelAndView;
	}

	@PostMapping("/admin/task/save")
	public String saveTask(@ModelAttribute("task") TaskDTO taskDto,
						   @RequestParam(value = "userId", required = false) Long userId,
						   @RequestParam(value = "cageId", required = false) Long cageId,
						   @RequestParam(value = "foodId", required = false) Long foodId,
						   @RequestParam(value = "quantity", required = false) Integer quantity,
						   HttpServletRequest request, RedirectAttributes redirectAttributes) {

		Map<String, Object> message = new HashMap<>();

		// Kiểm tra điều kiện đầu vào
		if (userId != null && cageId != null && foodId != null && foodId > 0 && quantity != null) {
			UserDTO userDTO = iUserService.findById(userId);
			CageDTO cageDTO = iCageService.findByID(cageId);
			FoodDTO foodDTO = iFoodService.findByID(foodId);

			if (userDTO != null && cageDTO != null && foodDTO != null) {
				if (foodDTO.getFoodQuantity() >= quantity) {
					// Thiết lập thông tin cho task
					taskDto.setUser(userDTO);
					taskDto.setCage(cageDTO);
					taskDto.setFood(foodDTO);
					taskDto.setQuantity(quantity);

					iTaskService.insert(taskDto); // Lưu task vào DB

					// Cập nhật số lượng thực phẩm nếu task status khác 0
					if (taskDto.getTaskStatus() != 0) {
						foodDTO.setFoodQuantity(foodDTO.getFoodQuantity() - quantity);
						iFoodService.insert(foodDTO); // Lưu cập nhật số lượng thực phẩm
					} else {
						foodDTO.setFoodQuantity(foodDTO.getFoodQuantity() - 0);
						iFoodService.insert(foodDTO);
					}

					message.put("message", "Dữ liệu đã được gửi thành công!");
					message.put("type", "success");
				} else {
					message.put("message", "Số lượng thực phẩm không đủ.");
					message.put("type", "error");
				}
			} else {
				message.put("message", "Thông tin không hợp lệ.");
				message.put("type", "error");
			}
		} else {
			message.put("message", "Thông tin không hợp lệ hoặc thiếu.");
			message.put("type", "error");
		}

		// Thêm thông báo vào redirectAttributes và chuyển hướng
		redirectAttributes.addFlashAttribute("message", message);
		return "redirect:/admin/task/add";
	}

	@RequestMapping(value = "/admin/task/list-task-employee", method = RequestMethod.GET)
	private ModelAndView showListTask(@ModelAttribute("USER") UserEntity currentUser) {
		ModelAndView modelAndView = new ModelAndView("admin/task/list_task_employee");
		Long employeeId = currentUser.getId();
		modelAndView.addObject("task", iTaskService.listAllById(employeeId));
		return modelAndView;
	}



	@GetMapping(value = "/admin/task/details")
	public ResponseEntity<TaskDTO> getTaskDetails(@RequestParam("id") Long taskId) {
		TaskDTO taskDTO = iTaskService.findByID(taskId);

		return ResponseEntity.ok(taskDTO);
	}

	@RequestMapping(value = "/admin/task/list-task-ad", method = RequestMethod.GET)
	private ModelAndView showList(@ModelAttribute("USER") UserEntity currentUser,
			@RequestParam(name = "page", defaultValue = "1", required = true) int page,
			@RequestParam(name = "userId", required = false) Long userId) {
		ModelAndView modelAndView = new ModelAndView("/admin/task/list_task_ad");

		// Kiểm tra nếu không có userId được chọn hoặc userId rỗng, thì hiển thị tất cả các task
		if (userId == null) {
			modelAndView.addObject("task", iTaskService.findAll(null));
		} else {
			modelAndView.addObject("task", iTaskService.listAllById(userId));
		}

		// Lấy danh sách người dùng và truyền vào model
		List<UserDTO> userDTOs = iUserService.getListUser();
		modelAndView.addObject("user", userDTOs);

		return modelAndView;
	}

	@GetMapping("/admin/task/edit")
	public String editTask(@RequestParam(value = "taskId") Long taskId, Model model) {
		model.addAttribute("task", iTaskService.findByID(taskId));
		model.addAttribute("user", iUserService.getListUser());
		model.addAttribute("cages", iCageService.findAll(null));
		model.addAttribute("foods", iFoodService.findAll(null));
		return "admin/task/edit_task";
	}

	@PostMapping("admin/task/update")
	public String updateTask(@ModelAttribute("task") TaskDTO taskDTO,
							 UserDTO userDTO,
							 RedirectAttributes redirectAttributes,
							 @RequestParam(value = "userId", required = false) Long userId,
							 @RequestParam(value = "cageId", required = false) Long cageId,
							 @RequestParam(value = "foodId", required = false) Long foodId,
							 @RequestParam(value = "quantity", required = false) Integer quantity) {

		Map<String, Object> message = new HashMap<>();

		// Kiểm tra điều kiện đầu vào
		if (userId != null && cageId != null && foodId != null && quantity != null) {
			// Thiết lập thông tin người dùng và chuồng
			userDTO.setId(userId);
			CageDTO cageDTO = new CageDTO();
			cageDTO.setId(cageId);

			// Lấy thông tin thực phẩm từ cơ sở dữ liệu
			FoodDTO foodDTO = iFoodService.findByID(foodId);
			if (foodDTO == null) {
				message.put("message", "Thực phẩm không tồn tại.");
				message.put("type", "error");
				redirectAttributes.addFlashAttribute("message", message);
				return "redirect:/admin/task/list-task-ad";
			}

			// Kiểm tra số lượng thực phẩm có đủ không
			if (foodDTO.getFoodQuantity() < quantity) {
				message.put("message", "Số lượng thực phẩm không đủ.");
				message.put("type", "error");
				redirectAttributes.addFlashAttribute("message", message);
				return "redirect:/admin/task/list-task-ad";
			}

			// Gán thông tin cho task
			taskDTO.setUser(userDTO);
			taskDTO.setCage(cageDTO);
			taskDTO.setFood(foodDTO);
			taskDTO.setQuantity(quantity);

			// Cập nhật task qua service
			iTaskService.updateTask(taskDTO);

			// Chỉ trừ số lượng thực phẩm nếu trạng thái task khác 0
			if (taskDTO.getTaskStatus() != 0) {
				foodDTO.setFoodQuantity(foodDTO.getFoodQuantity() - quantity);
				iFoodService.insert(foodDTO); // Lưu thông tin thực phẩm đã cập nhật
			} else {
				foodDTO.setFoodQuantity(foodDTO.getFoodQuantity() - 0);
				iFoodService.insert(foodDTO);
			}

			message.put("message", "Dữ liệu đã được gửi thành công!");
			message.put("type", "success");
		} else {
			message.put("message", "Thông tin không hợp lệ hoặc thiếu.");
			message.put("type", "error");
		}

		// Thêm thông báo vào redirectAttributes và chuyển hướng
		redirectAttributes.addFlashAttribute("message", message);
		return "redirect:/admin/task/list-task-ad";
	}



	@GetMapping("/admin/task/delete")
	public String deleteTask(@RequestParam(value = "taskId") Long taskId, RedirectAttributes redirectAttributes) {
		Map<String, Object> message = new HashMap<>();
		if (taskId != null) {

			iTaskService.deleteById(taskId);
			message.put("message", "Xóa thành công!");
			message.put("type", "success");
		} else {
			message.put("message", "Không thành công");
			message.put("type", "error");
		}
		redirectAttributes.addFlashAttribute("message", message);
		return "redirect:/admin/task/list-task-ad";
	}

	

}
