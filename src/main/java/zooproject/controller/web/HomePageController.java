package zooproject.controller.web;

import java.io.IOException;
import java.nio.charset.StandardCharsets;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.CookieValue;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import zooproject.Utils.SendMail;
import zooproject.entity.CustomerEntity;
import zooproject.service.IAnimalService;
import zooproject.service.ICustomerService;
import zooproject.service.ISpeciesService;

@Controller
public class HomePageController {
	
	private ISpeciesService iSpeciesService;
	private IAnimalService iAnimalService;
	
	@Autowired
	private ICustomerService iCustomerService;
	

	@Autowired 
	public HomePageController(ISpeciesService iSpeciesService, IAnimalService iAnimalService) {
		super();
		this.iSpeciesService = iSpeciesService;
		this.iAnimalService = iAnimalService;
	}
	
    @RequestMapping(value = "/trang-chu", method = RequestMethod.GET)
    public ModelAndView home() {
        ModelAndView modelAndView = new ModelAndView("web/home");
        modelAndView.addObject("species", iSpeciesService.findAll(null));
        modelAndView.addObject("animals", iAnimalService.findAll(null));
        return modelAndView;
    }
    
    @RequestMapping(value = "/ve-chung-toi", method = RequestMethod.GET)
    public ModelAndView display(){
        ModelAndView modelAndView = new ModelAndView("web/about_us");
        return modelAndView;
    }

	@RequestMapping(value = "/gio-mo-cua", method = RequestMethod.GET)
	public ModelAndView openning() {
		ModelAndView mav = new ModelAndView("web/opening");
		return mav;
	}

	@RequestMapping(value = "/quy-dinh", method = RequestMethod.GET)
	public ModelAndView rule() {
		ModelAndView mav = new ModelAndView("web/rule");
		return mav;
	}
    
    @RequestMapping(value = "/dang-nhap", method = RequestMethod.GET)
	public ModelAndView login() {
		ModelAndView mav = new ModelAndView("web/LoginAndRegister/login");
		return mav;
	}



	/* Login and Register */
	@PostMapping("/kiem-tra-dang-nhap")
	public String loginCheck(@ModelAttribute("customer") CustomerEntity customerEntity, HttpServletRequest request,
			@RequestParam(value = "remember", required = false) String remember, HttpServletResponse respone,
			RedirectAttributes redirectAttributes,
			HttpSession session) throws IOException {
		Map<String, Object> message = new HashMap<>();
		System.out.println(customerEntity.getCustomerPassword());

		CustomerEntity customer = iCustomerService.checkLoginCustomer(customerEntity.getCustomerName(),
				generateMD5(customerEntity.getCustomerPassword()));
		if (customer != null) {
			if (remember == "on") {
				System.out.println("ok");
				session.setAttribute("customer", customer);
				Cookie cookie = new Cookie("customer_name", customer.getCustomerName());
				cookie.setMaxAge(3600);
				respone.addCookie(cookie);
			} else {
				session.setAttribute("customer", customer);
			}
			message.put("message", "Đăng nhập thành công");
			message.put("type", "success");
			redirectAttributes.addFlashAttribute("message", message);
//			respone.sendRedirect(request.getContextPath() + "/trang-chu");
			return "redirect:/trang-chu";
		} else {
			message.put("message", "Đăng nhập thất bại");
			message.put("type", "error");
			redirectAttributes.addFlashAttribute("message", message);
//			respone.sendRedirect(request.getContextPath() + "/dang-nhap");
			return "redirect:/dang-nhap";
		}
	}

	@RequestMapping(value = "/dang-xuat", method = RequestMethod.GET)
	public String logOut(HttpServletRequest request,
			@CookieValue(name = "customer_name", defaultValue = "Guest") String customer_name,
			HttpServletResponse respone, HttpSession session) throws IOException {
		Cookie cookie = new Cookie("customer_name", null);
		cookie.setMaxAge(0);
		respone.addCookie(cookie);

		HttpSession sessions = request.getSession(false); // Không tạo mới session nếu không tồn tại
		if (sessions != null) {
			sessions.invalidate(); // Xóa session
		}

		return "redirect:/trang-chu";
	}

	@PostMapping("/them-dang-ky")
	public void addRegister(HttpServletRequest request, String remember, HttpServletResponse respone,
			HttpSession session, @ModelAttribute("customerRegister") CustomerEntity customerEntity) throws IOException {
		System.out.println(customerEntity.getCustomerName());

		CustomerEntity customerRegister = new CustomerEntity();
		customerRegister.setCustomerPassword(generateMD5(customerEntity.getCustomerPassword()));
		customerRegister.setCustomerName(customerEntity.getCustomerName());
		customerRegister.setCustomerEmail(customerEntity.getCustomerEmail());
		customerRegister.setCustomerPhone(customerEntity.getCustomerPhone());
		iCustomerService.registerCustomer(customerRegister);

		// Check account
		CustomerEntity customer = iCustomerService.checkAccount(customerEntity.getCustomerEmail());

		if (customer != null) {
			if (remember == "on") {
				Cookie cookie = new Cookie("customer_name", customerEntity.getCustomerName());
				cookie.setMaxAge(3600);
				respone.addCookie(cookie);
			}
			session.setAttribute("customer", customerEntity);
			respone.sendRedirect(request.getContextPath() + "/trang-chu");
		} else {
			respone.sendRedirect(request.getContextPath() + "/dang-ky");
		}
	}

	@RequestMapping(value = "/dang-ky", method = RequestMethod.GET)
	public ModelAndView register() {
		ModelAndView mav = new ModelAndView("web/LoginAndRegister/register");
		return mav;
	}


	
	
	public static String generateMD5(String input) {
		try {
			MessageDigest md = MessageDigest.getInstance("MD5");
			byte[] hashInBytes = md.digest(input.getBytes(StandardCharsets.UTF_8));
			StringBuilder stringBuilder = new StringBuilder();
			for (byte b : hashInBytes) {
				stringBuilder.append(String.format("%02x", b));
			}

			return stringBuilder.toString();
		} catch (NoSuchAlgorithmException e) {
			e.printStackTrace();
			return null;
		}
	}

}
