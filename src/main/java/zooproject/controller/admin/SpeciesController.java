package zooproject.controller.admin;

import java.io.File;
import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.commons.CommonsMultipartFile;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import zooproject.dto.SpeciesDTO;
import zooproject.service.ISpeciesService;

@Controller
public class SpeciesController {
	@Autowired
	private ISpeciesService iSpeciesService;

	private static Logger logger = Logger.getLogger(SpeciesController.class);

	// UI add info species
	@RequestMapping(value = "/admin/species/add", method = RequestMethod.GET)
	public ModelAndView addSpecies() {
		ModelAndView modelAndView = new ModelAndView("admin/species/add_species");
		return modelAndView;
	}

	// Save species
	@PostMapping("/admin/species/save")
	public String saveSpecies(@Valid @ModelAttribute("species") SpeciesDTO speciesDTO,
							  BindingResult br,
							  @RequestParam(value = "imgage") CommonsMultipartFile commonsMultipartFiles,
							  HttpServletRequest request,
							  HttpSession session, RedirectAttributes redirectAttributes) throws IOException {
		Map<String, Object> message = new HashMap<>();
		if (br.hasErrors()) {
			return "admin/species/add_species";
		}

		String nameFile = commonsMultipartFiles.getOriginalFilename();
		String nameFileNew = "";
		if (!"".equals(nameFile)) {
			String dirFile = request.getServletContext().getRealPath("/") + "template" + File.separator + "web"
					+ File.separator + "img";
			// Tạo một đối tượng File đại diện cho thư mục lưu trữ
			File fileDir = new File(dirFile + File.separator + "species");
			// Nếu thư mục không tồn tại, tạo mới nó
			if (!fileDir.exists()) {
				fileDir.mkdirs();
			}
			try {
				String[] parts = nameFile.split("\\.");

				if (parts.length == 2) {
					String fileName = parts[0]; // Chuỗi trước dấu chấm
					String extension = parts[1]; // Chuỗi sau dấu chấm
					System.out.println("Tên tập tin: " + fileName);
					System.out.println("Phần mở rộng: " + extension);
					nameFileNew = fileName + System.currentTimeMillis() + "." + extension;
				} else {
					System.out.println("Chuỗi đầu vào không hợp lệ.");
					nameFileNew = nameFile;
				}

				// Lưu tệp được tải lên vào thư mục lưu trữ
				File newFile = new File(fileDir, nameFileNew);
				commonsMultipartFiles.transferTo(newFile);
				logger.info(newFile);
				System.out.println("Upload file thành công!");
			} catch (Exception e) {
				System.out.println(e.getMessage());
				System.out.println("Upload file thất bại!");
			}
		}
		
		if(speciesDTO != null) {
			message.put("message", "Dữ liệu đã được gửi thành công!");
			message.put("type", "success");
			speciesDTO.setSpeciesImage(nameFileNew);
			iSpeciesService.insert(speciesDTO);
		} else {
			message.put("message", "Không thành công");
			message.put("type", "error");
		}
		redirectAttributes.addFlashAttribute("message", message);
		return "redirect:/admin/species/add";
	}

	// UI Show info species
	@RequestMapping(value = "/admin/species/list", method = RequestMethod.GET)
	private ModelAndView showListSpecies(@RequestParam(name = "page", defaultValue = "1", required = true) int page,
			@RequestParam(name = "limit", defaultValue = "5", required = true) int limit) {
		ModelAndView modelAndView = new ModelAndView("admin/species/list_species");
		SpeciesDTO speciesDTO = new SpeciesDTO();
		speciesDTO.setPage(page);
		speciesDTO.setLimit(limit);
		speciesDTO.setTotalItem(iSpeciesService.getTotalItem());
		speciesDTO.setTotalPage((int) Math.ceil((double) speciesDTO.getTotalItem() / speciesDTO.getLimit()));

		Pageable pageable = new PageRequest(page - 1, limit);
		speciesDTO.setListResult(iSpeciesService.findAll(pageable));
		modelAndView.addObject("species", speciesDTO);
		return modelAndView;
	}

	// Update status species
	@RequestMapping(value = "/admin/species/update-status", method = RequestMethod.GET)
	public String updateStatusSpecies(@RequestParam(value = "speciesId", required = false) Long speciesId,
			RedirectAttributes redirectAttributes) {
		Map<String, Object> message = new HashMap<>();
		if (speciesId != null) {
			message.put("message", "Cập nhật thành công!");
			message.put("type", "success");
			iSpeciesService.updateStatus(speciesId);
		} else {
			message.put("message", "Không thành công");
			message.put("type", "error");
		}
		redirectAttributes.addFlashAttribute("message", message);
		return "redirect:/admin/species/list";
	}

	// Code of hoangthanh
	@GetMapping("/admin/species/edit")
	public String editSpecies(@RequestParam("id") long id, Model model) {
		model.addAttribute("species", iSpeciesService.findById(id));
		return "admin/species/edit_species";
	}

	@PostMapping("/admin/species/update")
	public String updateSpecies(@ModelAttribute("species") SpeciesDTO speciesDTO,
			RedirectAttributes redirectAttributes,
			@RequestParam("imgage") CommonsMultipartFile file, HttpServletRequest request) throws IOException {
		Map<String, Object> message = new HashMap<>();
		String originalFilename = file.getOriginalFilename();
		String newFilename = "";

		if (originalFilename != null && !originalFilename.isEmpty()) {
			// Define the directory to save the uploaded file
			String uploadDir = request.getServletContext().getRealPath("/") + "template" + File.separator + "web"
					+ File.separator + "img" + File.separator + "species";

			File directory = new File(uploadDir);
			if (!directory.exists()) {
				directory.mkdirs();
			}

			try {
				// Generate a new filename
				String[] parts = originalFilename.split("\\.");
				if (parts.length == 2) {
					String fileName = parts[0]; // Name before the dot
					String extension = parts[1]; // Extension after the dot
					newFilename = fileName + System.currentTimeMillis() + "." + extension;
				} else {
					newFilename = originalFilename;
				}

				// Save the file
				File newFile = new File(directory, newFilename);
				file.transferTo(newFile);
				System.out.println("File uploaded successfully!");

			} catch (Exception e) {
				e.printStackTrace();
				System.out.println("File upload failed!");
			}
		} else {
			SpeciesDTO existingSpecies = iSpeciesService.findById(speciesDTO.getId());
			if (existingSpecies != null) {
				speciesDTO.setSpeciesImage(existingSpecies.getSpeciesImage());
			}
		}
		// Set the new filename if a file was uploaded
		if (!newFilename.isEmpty()) {
			speciesDTO.setSpeciesImage(newFilename);
		}
		
		try {
	        iSpeciesService.update(speciesDTO);
	        redirectAttributes.addFlashAttribute("message", "Cập nhật thành công!");
	        redirectAttributes.addFlashAttribute("type", "success");
	    } catch (Exception e) {
	        redirectAttributes.addFlashAttribute("message", "Cập nhật không thành công!");
	        redirectAttributes.addFlashAttribute("type", "error");
	    }
		redirectAttributes.addFlashAttribute("message", message);
		return "redirect:/admin/species/list";
	}

	@GetMapping("/admin/species/delete/{id}")
	public String deleteSpecies(@RequestParam("id") Long id, Model model, RedirectAttributes redirectAttributes) {
		Map<String, Object> message = new HashMap<>();
		if (id != null) {
			message.put("message", "Xóa thành công!");
			message.put("type", "success");
			iSpeciesService.deleteById(id);
		} else {
			message.put("message", "Không thành công");
			message.put("type", "error");
		}
		redirectAttributes.addFlashAttribute("message", message);
		return "redirect:/admin/species/list";
	}

	@GetMapping("/admin/species/detail")
	public String detailSpecies(@RequestParam("id") Long id, Model model) {
		model.addAttribute("species", iSpeciesService.findById(id));
		return "admin/species/detail_species";
	}

}
