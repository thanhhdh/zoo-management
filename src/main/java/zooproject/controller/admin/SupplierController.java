package zooproject.controller.admin;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import zooproject.dto.SupplierDTO;
import zooproject.service.ISupplierService;

import javax.validation.Valid;

@Controller
public class SupplierController {
	@Autowired
	private ISupplierService iSupplierService;

	// UI add info supplier
	@RequestMapping(value = "/admin/supplier/add", method = RequestMethod.GET)
	public ModelAndView addSpecies() {
		ModelAndView modelAndView = new ModelAndView("admin/supplier/add_supplier");
		return modelAndView;
	}

	@PostMapping("/admin/supplier/save")
	public String saveSupplier(@Valid @ModelAttribute("supplier") SupplierDTO supplierDTO,
			BindingResult br,
			RedirectAttributes redirectAttributes) {
		if(br.hasErrors()) {
			return "admin/supplier/add_supplier";
		}
		Map<String, Object> message = new HashMap<>();
		if (supplierDTO.getSupplierName() != null) {
			iSupplierService.insert(supplierDTO);
			message.put("message", "Dữ liệu đã được gửi thành công!");
			message.put("type", "success");
		} else {
			message.put("message", "Tên nhà cung cấp không được để trống!");
			message.put("type", "error");
		}
		redirectAttributes.addFlashAttribute("message", message);
		return "redirect:/admin/supplier/add";
	}

	// UI Show info supplier
	@RequestMapping(value = "/admin/supplier/list", method = RequestMethod.GET)
	private ModelAndView showListSupplier(
			@RequestParam(name = "page", defaultValue = "1", required = true) int page,
			@RequestParam(name = "limit", defaultValue = "5", required = true) int limit) {
		ModelAndView modelAndView = new ModelAndView("admin/supplier/list_supplier");
		SupplierDTO supplierDTO = new SupplierDTO();
		supplierDTO.setPage(page);
		supplierDTO.setLimit(limit);
		supplierDTO.setTotalItem(iSupplierService.getTotalItem());
		supplierDTO.setTotalPage((int) Math.ceil((double) supplierDTO.getTotalItem() / supplierDTO.getLimit()));

		Pageable pageable = new PageRequest(page - 1, limit);
		supplierDTO.setListResult(iSupplierService.findAll(pageable));
		modelAndView.addObject("suppliers", supplierDTO);
		return modelAndView;
	}

	// Code of tantin
	@RequestMapping(value = "/admin/supplier/edit", method = RequestMethod.GET)
	public ModelAndView editSupplier(@RequestParam("id") Long id) {
		ModelAndView modelAndView = new ModelAndView("admin/supplier/edit_supplier");
		SupplierDTO supplierDTO = iSupplierService.findByID(id);
		modelAndView.addObject("supplier", supplierDTO);
		return modelAndView;
	}

	@PostMapping("/admin/supplier/update")
	public String updateSupplier(@ModelAttribute("supplier") SupplierDTO supplierDTO,
			RedirectAttributes redirectAttributes) {
		Map<String, Object> message = new HashMap<String, Object>();
		if (supplierDTO != null) {
			message.put("message", "Cập nhập thành công");
			message.put("type", "success");
			iSupplierService.update(supplierDTO);
		} else {
			message.put("message", "Cập nhập không thành công");
			message.put("type", "error");
		}
		redirectAttributes.addFlashAttribute("message", message);
		return "redirect:/admin/supplier/list";
	}

	@GetMapping("/admin/supplier/delete")
	public String deleteSupplier(@ModelAttribute("id") Long supplierId, RedirectAttributes redirectAttributes) {
		System.out.println("Supplier ID: " + supplierId);
		Map<String, Object> message = new HashMap<String, Object>();
		try {
			iSupplierService.delete(supplierId);
			message.put("message", "Xóa thành công");
			message.put("type", "succes");
		} catch (Exception e) {
			message.put("message", "Xóa không thành công");
			message.put("type", "error");
		}
		redirectAttributes.addFlashAttribute("message", message);
		return "redirect:/admin/supplier/list";
	}

}
