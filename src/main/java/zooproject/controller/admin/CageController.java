package zooproject.controller.admin;

import java.awt.geom.Area;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
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
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import zooproject.dto.AreaDTO;
import zooproject.dto.CageDTO;
import zooproject.entity.CageEntity;
import zooproject.service.IAreaService;
import zooproject.service.ICageService;

@Controller
public class CageController {

	private ICageService iCageService;
	private IAreaService iAreaService;
	private AreaDTO areaDTO;

	@Autowired
	public CageController(ICageService iCageService, IAreaService iAreaService, AreaDTO areaDTO) {
		this.iCageService = iCageService;
		this.iAreaService = iAreaService;
		this.areaDTO = areaDTO;
	}

	private static Logger logger =  Logger.getLogger(CageController.class);

	// UI add info cage
	@RequestMapping(value = "/admin/cage/add", method = RequestMethod.GET)
	public ModelAndView addCage(HttpServletRequest request) {
		ModelAndView modelAndView = new ModelAndView("admin/cage/add_cage");
		List<AreaDTO> areas = iAreaService.findAll(null);
		modelAndView.addObject("areas", areas);
		return modelAndView;
	}

	// Save cage
	@PostMapping("/admin/cage/save")
	public String saveCage(@Valid @ModelAttribute("cage") CageDTO cageDTO,
						   @RequestParam(value = "areaId", required = false) Long areaId,
						   BindingResult br,
						   RedirectAttributes redirectAttributes) {
		if (br.hasErrors()) {
			return "admin/cage/add_cage";
		}
		Map<String, Object> message = new HashMap<>();
		if(cageDTO != null) {
			areaDTO.setId(areaId);
			cageDTO.setArea(areaDTO);
			message.put("message", "Dữ liệu thành công!");
			message.put("type", "success");
			iCageService.insert(cageDTO);
		} else {
			message.put("message", "Không thành công");
			message.put("type", "error");
		}
		redirectAttributes.addFlashAttribute("message", message);
		return "redirect:/admin/cage/add";
	}

	// UI Show info cage
	@RequestMapping(value = "/admin/cage/list", method = RequestMethod.GET)
	private ModelAndView showListCage(@RequestParam(name = "page", defaultValue = "1", required = true) int page,
			@RequestParam(name = "limit", defaultValue = "5", required = true) int limit) {
		ModelAndView modelAndView = new ModelAndView("admin/cage/list_cage");
		CageDTO cageDTO = new CageDTO();
		cageDTO.setPage(page);
		cageDTO.setLimit(limit);
		cageDTO.setTotalItem(iCageService.getTotalItem());
		cageDTO.setTotalPage((int) Math.ceil((double) cageDTO.getTotalItem() / cageDTO.getLimit()));

		Pageable pageable = new PageRequest(page - 1, limit);
		cageDTO.setListResult(iCageService.findAll(pageable));
		modelAndView.addObject("cage", cageDTO);
		return modelAndView;
	}
	
	// Code of hoangthanh
	@GetMapping("/admin/cage/update-status")
	public String updateStatus(@RequestParam("id") Long id,
			RedirectAttributes redirectAttributes) {
		Map<String, Object> message = new HashMap<>();
		if(id != null) {
			message.put("message", "Cập nhật thành công!");
			message.put("type", "success");
			iCageService.updateStatus(id);
		} else {
			message.put("message", "Không thành công");
			message.put("type", "error");
		}
		redirectAttributes.addFlashAttribute("message", message);
		return "redirect:/admin/cage/list";
	}

	// update cage
	@GetMapping("/admin/cage/edit")
	public String editCage(@RequestParam("id") Long id, Model model) {
		model.addAttribute("cage", iCageService.findByID(id));
		model.addAttribute("areas", iAreaService.findAll(null));
		return "admin/cage/edit_cage";
	}

	@PostMapping("/admin/cage/update")
	public String updateCage(@ModelAttribute("cage") CageDTO cageDTO,
			@RequestParam("id") Long id,
			@RequestParam(value = "areaId", required = false) Long areaId,
			RedirectAttributes redirectAttributes) {

		Map<String, Object> message = new HashMap<>();

		areaDTO.setId(areaId);
		cageDTO.setArea(areaDTO);

		message.put("message", "Cập nhật thành công!");
		message.put("type", "success");
		iCageService.updateCage(cageDTO);
		redirectAttributes.addFlashAttribute("message", message);
		return "redirect:/admin/cage/list";
	}

	@GetMapping("/admin/cage/delete/{id}")
	public String deleteCage(@RequestParam("id") Long id,
			RedirectAttributes redirectAttributes) {

		Map<String, Object> message = new HashMap<>();
		if(id != null) {
			if (iCageService.isCageInUse(id)) {
				message.put("message", "Không thể xóa chuồng vì có động vật đang sử dụng.");
				message.put("type", "error");
			} else {
				iCageService.deleteById(id);
				message.put("message", "Xóa thành công!");
				message.put("type", "success");
			}
		} else {
			message.put("message", "Không thành công");
			message.put("type", "error");
		}
		redirectAttributes.addFlashAttribute("message", message);
		return "redirect:/admin/cage/list";
	}

}
