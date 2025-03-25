package zooproject.controller.web;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import zooproject.dto.CartDTO;
import zooproject.dto.CouponDTO;
import zooproject.entity.CouponEntity;
import zooproject.service.ICouponService;

@Controller
public class TicketController {
	@Autowired
	private ICouponService iCouponService;

	@RequestMapping(value = "/dat-ve", method = RequestMethod.GET)
	public ModelAndView datVe(HttpSession session) {
		ModelAndView modelAndView = new ModelAndView("web/ticket");
		return modelAndView;
	}

	@RequestMapping(value = "/gio-hang", method = RequestMethod.GET)
	public ModelAndView cart(HttpSession session) {
		ModelAndView mav = new ModelAndView("web/cart");
		List<CartDTO> cartList = (List<CartDTO>) session.getAttribute("cart");
		CouponEntity couponEntity = (CouponEntity) session.getAttribute("coupon");

		if (couponEntity != null) {
			mav.addObject("coupon", couponEntity);
			System.out.println("coupon; " + couponEntity.getCouponNumber());
		} else {
			mav.addObject("coupon", null);
		}
		mav.addObject("cart", cartList);
		return mav;
	}

	@RequestMapping(value = "/them-ve", method = RequestMethod.POST)
	public String addTicket(HttpServletRequest request, HttpServletResponse response,
			@ModelAttribute("ticket") CartDTO cartDTO, HttpSession session, RedirectAttributes redirectAttributes) {
		Map<String, Object> message = new HashMap<>();
		List<CartDTO> cartList = (List<CartDTO>) session.getAttribute("cart");
		if (cartList == null) {
			cartList = new ArrayList<CartDTO>();
		}

		boolean check = false;
		for (CartDTO caDto : cartList) {
			if (caDto.getTicketName().equals(cartDTO.getTicketName())) {
				caDto.setTicketQty(caDto.getTicketQty() + 1);
				check = true;
				message.put("message", "Thêm số lượng vé thành công");
				message.put("type", "success");
				break;
			}
		}

		if (!check) {
			CartDTO cart = new CartDTO();
			cart.setTicketName(cartDTO.getTicketName());
			cart.setTicketPrice(cartDTO.getTicketPrice());
			cart.setTicketQty(1);
			cartList.add(cart);
			message.put("message", "Thêm vé thành công");
			message.put("type", "success");
		}

		session.setAttribute("cart", cartList);
		redirectAttributes.addFlashAttribute("message", message);
		return "redirect:/dat-ve";
	}

	@RequestMapping(value = "/xoa-ve", method = RequestMethod.GET)
	public String deleteCart(HttpSession session, HttpServletRequest request, HttpServletResponse respone,
			@RequestParam(value = "nameTicket", required = false) String nameTicket,
			RedirectAttributes redirectAttributes) throws IOException {
		Map<String, Object> message = new HashMap<>();
		List<CartDTO> listCartEntities = (List<CartDTO>) session.getAttribute("cart");

		for (CartDTO caEntity : listCartEntities) {
			if (caEntity.getTicketName().equals(nameTicket)) {
				listCartEntities.remove(caEntity);
				session.setAttribute("cart", listCartEntities);
				message.put("message", "Xóa vé thành công");
				message.put("type", "success");
				break;
			}
		}
		redirectAttributes.addFlashAttribute("message", message);
		return "redirect:/gio-hang";
	}
	
	@RequestMapping(value = "/cap-nhat-gio-hang", method = RequestMethod.GET)
	@ResponseBody
	public Map<String, Object> updateCart(HttpSession session, HttpServletRequest request, HttpServletResponse response,
	        @RequestParam(value = "ticket_name") String ticket_name, @RequestParam(value = "ticket_qty") int ticket_qty)
	        throws IOException {
	    List<CartDTO> lCartDTOs = (List<CartDTO>) session.getAttribute("cart");

	    int price_food = 0;
	    int total = 0;
	    int coupon_price = 0;

	    for (CartDTO cartDTO : lCartDTOs) {
	        if (cartDTO.getTicketName().equals(ticket_name)) {
	        	cartDTO.setTicketQty(ticket_qty);
	        }
	        price_food += cartDTO.getTicketQty() * cartDTO.getTicketPrice();
	    }
	    total += price_food;

	    // Lấy giá trị của coupon và feeship từ session
	    CouponEntity couponEntity = (CouponEntity) session.getAttribute("coupon");

	    
	    if (couponEntity != null ) { // TH1: TH này là chỉ ở giỏ hàng
	        if (couponEntity.getCouponCondition() == 1) {
	            coupon_price = total * couponEntity.getCouponNumber() / 100;
	            total -= coupon_price;
	        } else if (couponEntity.getCouponCondition() == 2) {
	        	coupon_price = couponEntity.getCouponNumber();
	            total -= couponEntity.getCouponNumber();
	        }
	    } 

	    // Lưu giá mới của sản phẩm vào session
	    session.setAttribute("cart", lCartDTOs);
	    

	    Map<String, Object> responseMap = new HashMap<>();
	    responseMap.put("price", price_food);
	    responseMap.put("total", total);
	    responseMap.put("coupon_price", coupon_price);
	    return responseMap;
	}

	@RequestMapping(value = "/kiem-tra-ma-giam", method = RequestMethod.POST)
	public String checkCoupon(HttpSession session, @ModelAttribute("coupon") CouponEntity coupon,
			RedirectAttributes redirectAttributes) throws IOException {
		Map<String, Object> message = new HashMap<>();

		if (coupon == null || coupon.getCouponCode() == null || coupon.getCouponCode().trim().isEmpty()) {
			message.put("message", "Mã giảm giá không được để trống");
			message.put("type", "error");
		} else {
			CouponEntity couponEntity = iCouponService.checkCoupon(coupon.getCouponCode());
			if (couponEntity != null) {
				message.put("message", "Áp mã thành công");
				message.put("type", "success");
				session.setAttribute("coupon", couponEntity);
				session.setMaxInactiveInterval(300);
			} else {
				message.put("message", "Mã giảm giá không tồn tại hoặc không hợp lệ");
				message.put("type", "error");
				session.setAttribute("coupon", null);
			}
		}

		redirectAttributes.addFlashAttribute("message", message);
		return "redirect:/gio-hang";
	}

}
