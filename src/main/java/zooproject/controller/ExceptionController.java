package zooproject.controller;

import java.io.IOException;

import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.ModelAttribute;

import zooproject.dto.UserDTO;
import zooproject.entity.UserEntity;
import zooproject.security.SecurityUtils;
import zooproject.service.IUserService;

@ControllerAdvice
public class ExceptionController {
	private static Logger logger = Logger.getLogger(ExceptionController.class);
	
	@Autowired
	private IUserService iUserService;
	
	@ModelAttribute("USER")
	public UserEntity getCurrentUser() {
		UserEntity userEntity = iUserService.findByUserName(SecurityUtils.getSessionUser());
		return userEntity;
	}
	
	/*
	 * @ExceptionHandler(value = {NoHandlerFoundException.class}) public void
	 * exception404Handler(Exception exception, HttpServletResponse response) throws
	 * IOException {
	 * 
	 * logger.error(exception);
	 * 
	 * response.setContentType("text/plain");
	 * response.getWriter().write("Không Tìm Thấy Đường Dẫn !"); }
	 */
//	
	@ExceptionHandler(value = {Exception.class})
	public void allExceptionHandler(Exception exception, HttpServletResponse response) throws IOException {
		logger.error(exception);

		response.setContentType("text/plain");
	    response.getWriter().write("Bug Rồi , Xem Ở Console Mà Fix Nhé !");
	}
	
	
}
