package zooproject.controller.admin;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import zooproject.dto.FoodDTO;
import zooproject.dto.SpeciesDTO;
import zooproject.dto.SupplierDTO;
import zooproject.service.IFoodService;
import zooproject.service.ISpeciesService;
import zooproject.service.ISupplierService;

import javax.validation.Valid;

@Controller
public class FoodController {

	private ISupplierService iSupplierService;

	private ISpeciesService iSpeciesService;

	private IFoodService iFoodService;

	private SupplierDTO supplierDTO;

	private FoodDTO foodDTO;

	@Autowired
	public FoodController(ISupplierService iSupplierService, ISpeciesService iSpeciesService, IFoodService iFoodService,
			SupplierDTO supplierDTO, FoodDTO foodDTO) {
		super();
		this.iSupplierService = iSupplierService;
		this.iSpeciesService = iSpeciesService;
		this.iFoodService = iFoodService;
		this.supplierDTO = supplierDTO;
		this.foodDTO = foodDTO;
	}

	// UI add info food
	@RequestMapping(value = "/admin/food/add", method = RequestMethod.GET)
	public ModelAndView addSpecies() {
		ModelAndView modelAndView = new ModelAndView("admin/food/add_food");
		// List nhà cung cấp
		List<SupplierDTO> listSupplier = iSupplierService.findAll(null);

		// List loài
		List<SpeciesDTO> listSpecies = iSpeciesService.findAll(null);
		modelAndView.addObject("supplier", listSupplier);

		return modelAndView;
	}

	// Save food
	@PostMapping("/admin/food/save")
	public String saveFood(@Valid @ModelAttribute("food") FoodDTO foodDto,
			BindingResult br,
			@RequestParam(value = "supplierId", required = false) Long supplierId,
			RedirectAttributes redirectAttributes) {
		if (br.hasErrors()) {
			return "admin/food/add_food";
		}
		Map<String, Object> message = new HashMap<>();
		if (foodDto != null) {
			supplierDTO.setSupplierId(supplierId);

			// Set id supplier vào foodDto
			foodDto.setSupplier(supplierDTO);
			iFoodService.insert(foodDto);

			message.put("message", "Dữ liệu đã được gửi thành công!");
			message.put("type", "success");
		} else {
			message.put("message", "Không thành công");
			message.put("type", "error");
		}
		redirectAttributes.addFlashAttribute("message", message);
		return "redirect:/admin/food/add";
	}

	// List food
	@RequestMapping(value = "/admin/food/list", method = RequestMethod.GET)
	private ModelAndView showListFood(@RequestParam(name = "page", defaultValue = "1", required = true) int page,
			@RequestParam(name = "limit", defaultValue = "5", required = true) int limit) {
		ModelAndView modelAndView = new ModelAndView("admin/food/list_food");

		foodDTO.setPage(page);
		foodDTO.setLimit(limit);
		foodDTO.setTotalItem(iFoodService.getTotalItem());
		foodDTO.setTotalPage((int) Math.ceil((double) foodDTO.getTotalItem() / foodDTO.getLimit()));

		Pageable pageable = new PageRequest(page - 1, limit);
		foodDTO.setListResult(iFoodService.findAll(pageable));
		modelAndView.addObject("foods", foodDTO);
		return modelAndView;
	}
	
	
	// Code of tantin
	// edit
	@RequestMapping(value = "/admin/food/edit", method = RequestMethod.GET)
	public ModelAndView editFood(@RequestParam(name = "id") Long id) {
		ModelAndView modelAndView = new ModelAndView("admin/food/edit_food");
		FoodDTO foodDTO = iFoodService.findByID(id);
		if (foodDTO != null) {
			List<SupplierDTO> listSupplier = iSupplierService.findAll(null);
			List<SpeciesDTO> listSpecies = iSpeciesService.findAll(null);
			modelAndView.addObject("food", foodDTO);
			modelAndView.addObject("supplier", listSupplier);
			modelAndView.addObject("species", listSpecies);
		}
		return modelAndView;
	}

	// update
	@PostMapping("/admin/food/update")
	public String updateFood(@ModelAttribute("food") FoodDTO foodDTO,
			@RequestParam(value = "supplierId", required = false) Long supplierId,
			RedirectAttributes redirectAttributes) {
		Map<String, Object> message = new HashMap<>();
		try {
			if (foodDTO != null) {
				if (supplierId != null) {
					SupplierDTO supplierDTO = iSupplierService.findByID(supplierId);
					if (supplierDTO != null) {
						foodDTO.setSupplier(supplierDTO);
					} else {
						message.put("message", "Nhà cung cấp không tồn tại");
						message.put("type", "error");
						redirectAttributes.addFlashAttribute("message", message);
						return "redirect:/admin/food/edit?id=" + foodDTO.getFoodId();
					}
				}
				iFoodService.update(foodDTO);
				message.put("message", "Dữ liệu được cập nhật thành công");
				message.put("type", "success");
			} else {
				message.put("message", "Dữ liệu không hợp lệ");
				message.put("type", "error");
			}
		} catch (Exception e) {
			message.put("message", "Lỗi hệ thống: " + e.getMessage());
			message.put("type", "error");
		}
		redirectAttributes.addFlashAttribute("message", message);
		return "redirect:/admin/food/list";
	}

	@RequestMapping(value = "/admin/food/delete", method = RequestMethod.GET)
	public String deleteFood(@RequestParam("id") Long id, RedirectAttributes redirectAttributes) {
		Map<String, Object> message = new HashMap<>();
		try {
			iFoodService.delete(id);
			message.put("message", "Xóa thành công!");
			message.put("type", "success");
		} catch (Exception e) {
			message.put("message", "Lỗi hệ thống: " + e.getMessage());
			message.put("type", "error");
		}
		redirectAttributes.addFlashAttribute("message", message);
		return "redirect:/admin/food/list";
	}

}
