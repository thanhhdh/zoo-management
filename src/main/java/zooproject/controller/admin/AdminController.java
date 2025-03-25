package zooproject.controller.admin;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.validation.Valid;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import zooproject.dto.UserDTO;
import zooproject.security.SecurityUtils;
import zooproject.service.IUserService;

@Controller
public class AdminController {

	private static Logger logger = Logger.getLogger(AdminController.class);

	@Autowired
	IUserService userService;

//	@PreAuthorize("hasRole('ADMIN')")
	@RequestMapping(value = "/admin/account-admin/add", method = RequestMethod.GET)
	public ModelAndView addAccountAdminPage(@ModelAttribute("accountAdmin") UserDTO accountAdmin,
			@ModelAttribute("message") HashMap<String, Object> message, HttpServletRequest request) {
		ModelAndView mav = new ModelAndView("admin/admin/add-admin");
		if (request.getParameter("admin_id") != null && request.getParameter("admin_id") != "") {
			accountAdmin = userService.findByID(Long.parseLong(request.getParameter("admin_id")));
		}
		if (message != null && !message.isEmpty()) {
			String messageText = (String) message.get("message");
			String type = (String) message.get("type");
			accountAdmin.setAlertInfo(type, messageText);
			System.out.println("messageText: " + messageText);
		}
		logger.info(message);
		mav.addObject("accountAdmin", accountAdmin);
		return mav;
	}

//	@PreAuthorize("hasRole('ADMIN')")
	@PostMapping(value = "/admin/account-admin/save")
	public String saveAccountAdmin(@Valid @ModelAttribute("accountAdmin") UserDTO accountAdmin,
								   BindingResult result,
								   Model model, HttpServletRequest request,
								   RedirectAttributes redirectAttributes) {
		Map<String, Object> message = new HashMap<>();
		if (result.hasErrors()) {
			message.put("message", "Có lỗi khi thêm dữ liệu vào");
			message.put("type", "error");
			return "admin/admin/add-admin";

		} else {
			userService.saveUser(accountAdmin);
			message.put("message", "Dữ liệu đã được gửi thành công!");
			message.put("type", "success");
		}
		redirectAttributes.addFlashAttribute("message", message);
		return "redirect:/admin/account-admin/list";
	}

//	@PreAuthorize("hasAnyRole('ADMIN','MANAGER')")
	@RequestMapping(value = "/admin/account-admin/list", method = RequestMethod.GET)
	public ModelAndView listAccountAdminPage(@ModelAttribute("message") HashMap<String, Object> message) {
		ModelAndView mav = new ModelAndView("admin/admin/list-admin");

		logger.info(SecurityUtils.getSessionUser());
		
		if (message != null && !message.isEmpty()) {
			String messageText = (String) message.get("message");
			String type = (String) message.get("type");
			UserDTO userDTO = new UserDTO();
			userDTO.setAlertInfo(type, messageText);
			mav.addObject("userDTO", userDTO);

			System.out.println("messageText: " + messageText);

		}
		return mav;
	}

//	@PreAuthorize("hasAnyRole('ADMIN','MANAGER')")
	@GetMapping(value = "/admin/account-admin/load-table-admin")
	public void loadAccountAdmin(HttpServletResponse response) throws IOException {
		response.setContentType("text/plain");
		response.getWriter().write(userService.loadTableListUser());
	}

//	@PreAuthorize("hasRole('ADMIN')")
	@GetMapping(value = "/admin/account-admin/assign-roles")
	public void assignRolesAccountAdmin(HttpServletResponse response, HttpServletRequest request) throws IOException {
		Long idUser = Long.parseLong(request.getParameter("admin_id"));
		Long idRole = Long.parseLong(request.getParameter("index_roles"));
		System.out.println(idUser + "-" + idRole);
		String statusUpdate = userService.updateRoleUser(idUser, idRole);

		response.setContentType("text/plain");
		response.getWriter().write(statusUpdate);
	}

//	@PreAuthorize("hasAnyRole('ADMIN','MANAGER')")
	@GetMapping(value = "/admin/account-admin/delete")
	public void deleteAccountAdmin(HttpServletResponse response, HttpServletRequest request) throws IOException {
		Long id = Long.parseLong(request.getParameter("admin_id"));
		response.setContentType("text/plain");
		response.getWriter().write(userService.deleteAdmin(id));
	}

	@GetMapping("/admin/account-admin/search")
	public void searchAccountAdmin(@RequestParam("keyword") String keyword, HttpServletResponse response) throws IOException {
		response.setContentType("text/plain");

		// Tìm kiếm admin theo tên hoặc email
		List<UserDTO> adminList = userService.searchAdminByNameOrEmail(keyword);

		// Gọi `outputAdmin` để tạo HTML của bảng kết quả tìm kiếm
		String output = userService.outputAdmin(adminList);
		response.getWriter().write(output);
	}


}
