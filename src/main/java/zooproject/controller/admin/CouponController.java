package zooproject.controller.admin;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import zooproject.dto.CageDTO;
import zooproject.dto.CouponDTO;
import zooproject.service.ICouponService;

@Controller
public class CouponController {
	@Autowired
	private ICouponService iCouponService;

	// UI add info coupon
	@RequestMapping(value = "/admin/coupon/add", method = RequestMethod.GET)
	public ModelAndView addCoupon() {
		ModelAndView modelAndView = new ModelAndView("admin/coupon/add_coupon");
		return modelAndView;
	}

	// Save coupon
	@PostMapping("/admin/coupon/save")
	public String saveCoupon(@ModelAttribute("coupon") CouponDTO couponDTO, RedirectAttributes redirectAttributes) {
		Map<String, Object> message = new HashMap<>();
		if (couponDTO != null) {
			iCouponService.insert(couponDTO);
			message.put("message", "Dữ liệu đã được gửi thành công!");
			message.put("type", "success");
		} else {
			message.put("message", "Không thành công");
			message.put("type", "error");
		}
		redirectAttributes.addFlashAttribute("message", message);
		return "redirect:/admin/coupon/add";
	}

	// UI Show info coupon
	@RequestMapping(value = "/admin/coupon/list", method = RequestMethod.GET)
	public ModelAndView showListCoupon(@RequestParam(name = "page", defaultValue = "1", required = true) int page,
			@RequestParam(name = "limit", defaultValue = "5", required = true) int limit) {
		ModelAndView modelAndView = new ModelAndView("admin/coupon/list_coupon");
		CouponDTO couponDTO = new CouponDTO();
		couponDTO.setPage(page);
		couponDTO.setLimit(limit);
		couponDTO.setTotalItem(iCouponService.getTotalItem());
		couponDTO.setTotalPage((int) Math.ceil((double) couponDTO.getTotalItem() / couponDTO.getLimit()));

		Pageable pageable = new PageRequest(page - 1, limit);
		couponDTO.setListResult(iCouponService.findAll(pageable));
		modelAndView.addObject("coupons", couponDTO);
		return modelAndView;
	}

	@GetMapping("/admin/coupon/update")
	public String updateCoupon(@RequestParam(name = "couponId") Long couponId, Model model) {
		model.addAttribute("coupon", iCouponService.findById(couponId));
		return "admin/coupon/edit_coupon";
	}

	@PostMapping("/admin/coupon/update")
	public String updateCoupon(
			@ModelAttribute("coupon") CouponDTO couponDTO,
			RedirectAttributes redirectAttributes) {
		Map<String, Object> message = new HashMap<>();
		if (couponDTO != null) {
			iCouponService.updateCoupon(couponDTO);
			message.put("message", "Cập nhật mã giảm giá thành công!");
			message.put("type", "success");
		} else {
			message.put("message", "Cập nhật mã giảm giá thất bại!");
			message.put("type", "error");
		}
		redirectAttributes.addFlashAttribute("message", message);
		return "redirect:/admin/coupon/list";
	}

	@GetMapping("/admin/coupon/delete/{couponId}")
	public String deleteCoupon(@RequestParam(value = "couponId") Long couponId, RedirectAttributes redirectAttributes) {
		Map<String, Object> message = new HashMap<>();
		if (couponId != null) {

			iCouponService.deleteById(couponId);
			message.put("message", "Xóa thành công!");
			message.put("type", "success");
		} else {
			message.put("message", "Không thành công");
			message.put("type", "error");
		}
		redirectAttributes.addFlashAttribute("message", message);
		return "redirect:/admin/coupon/list";
	}
}
