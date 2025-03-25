package zooproject.controller.admin;

import java.time.LocalDate;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.view.RedirectView;

import zooproject.dto.CageDTO;
import zooproject.security.SecurityUtils;
import zooproject.service.*;

@Controller
public class DashBoardController {
	@Autowired
	private IAnimalService iAnimalService;

	@Autowired
	private ISpeciesService iSpeciesService;

	@Autowired
	private ICouponService iCouponService;
	@Autowired
	private IAreaService iAreaService;
	@Autowired
	private IQuestionService iQuestionService;

	@Autowired
	private IFoodService iFoodService;

	@Autowired
	private IOrderService iOrderService;

	@Autowired
	private ITaskService iTaskService;

	private static Logger logger = Logger.getLogger(DashBoardController.class);

	@RequestMapping(value = "/", method = RequestMethod.GET)
	public RedirectView firstPage() {
		RedirectView redirectView = new RedirectView();
		redirectView.setUrl("admin/dashboard");

		logger.info(SecurityUtils.getAuthoritties());
		logger.info(SecurityUtils.getSessionUser());
		return redirectView;
	}

	@PreAuthorize("hasAnyRole('ROLE_ADMIN', 'ROLE_MANAGER')")
	@RequestMapping(value = "admin/dashboard", method = RequestMethod.GET)
	public String showDashboard(Model model) {
		// Thêm dữ liệu cơ bản
		model.addAttribute("species", iSpeciesService.getTotalItem());
		model.addAttribute("aniaml", iAnimalService.getTotalItem());
		model.addAttribute("orders", iOrderService.getTotalItem());
		model.addAttribute("areas", iAreaService.getTotalItem());
		model.addAttribute("questions", iQuestionService.getTotalItem());
		model.addAttribute("foodMap", iTaskService.getTotalFoodQuantity());
		model.addAttribute("orderCountMap", iOrderService.getOrderCountByDayOfWeek());
		model.addAttribute("speciesCountMap", iAnimalService.getTotalFoodQuantity());

		// Thống kê mã giảm giá
		model.addAttribute("validCoupons", iCouponService.countValidCoupons());
		model.addAttribute("expiredCoupons", iCouponService.countExpiredCoupons());
		model.addAttribute("couponConditionMap", iCouponService.getCouponCountByCondition());

		// Thống kê sức khỏe động vật
		Map<String, Long> animalHealthStats = iAnimalService.getAnimalStatisticsByStatus();
		model.addAttribute("animalHealthStats", animalHealthStats);

		// Thong ke doanh thu theo thang
		Map<String, Double> monthlyRevenue = iOrderService.getMonthlyRevenue();

		// Tách keys (tháng) và values (doanh thu) để truyền qua JSP
		List<String> months = new ArrayList<>(monthlyRevenue.keySet());
		List<Double> revenues = new ArrayList<>(monthlyRevenue.values());

		model.addAttribute("months", months);
		model.addAttribute("revenues", revenues);

		return "admin/dashboard/dashboard"; // Trả về file JSP
	}


	@PreAuthorize("hasAnyRole('ROLE_ADMIN', 'ROLE_MANAGER')")
	@GetMapping("/admin/dashboard/order-statistics")
	@ResponseBody
	public Map<String, Object> getOrderStatistics() {
		Map<String, Object> statistics = new HashMap<>();

		// Thống kê đơn hàng theo trạng thái
		Map<String, Long> orderStatusStatistics = iOrderService.getOrderStatistics();
		statistics.put("statusStatistics", orderStatusStatistics);

		// Thống kê số lượng đơn hàng theo tháng
		Map<String, Long> orderCountByMonth = iOrderService.getOrderCountByMonth();
		statistics.put("monthlyStatistics", orderCountByMonth);

		// Thống kê số lượng đơn hàng theo ngày
		Map<String, Long> orderCountByDay = iOrderService.getOrderCountByDay();
		statistics.put("dailyStatistics", orderCountByDay);

		return statistics;
	}

	@PreAuthorize("hasAnyRole('ROLE_ADMIN', 'ROLE_MANAGER')")
	@GetMapping("/admin/dashboard/food-statistics")
	@ResponseBody
	public Map<String, Object> getFoodStatistics() {
		Map<String, Object> statistics = new HashMap<>();

		// Lấy thống kê số lượng thức ăn
		Map<String, Integer> foodStats = iFoodService.getFoodStatistics();
		statistics.put("foodStats", foodStats);

		// Lấy số lượng thức ăn hết hàng
		Long outOfStockCount = iFoodService.getOutOfStockFoodCount();
		statistics.put("outOfStock", outOfStockCount);

		return statistics;
	}




}
