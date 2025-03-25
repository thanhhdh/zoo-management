package zooproject.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import zooproject.service.IUserService;

@Controller
public class AuthController {

	@Autowired
	IUserService userService;

	@RequestMapping(value = "auth/login", method = RequestMethod.GET)
	public ModelAndView homePage() {
		ModelAndView mav = new ModelAndView("admin/auth/login");
		return mav;
	}

}
