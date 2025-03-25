package zooproject.controller.admin;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import zooproject.converter.OrderConverter;
import zooproject.dto.OrderDTO;
import zooproject.entity.OrderDetailEntity;
import zooproject.entity.OrderEntity;
import zooproject.service.IOrderDetailService;
import zooproject.service.IOrderService;

import java.util.Collections;
import java.util.List;
import java.util.stream.Collectors;

@Controller
public class OrderController {
	@Autowired
	private IOrderService iOrderService;

	@Autowired
	private OrderConverter orderConverter;
	
	@Autowired
	private IOrderDetailService iOrderDetailService;

	@RequestMapping(value = "/admin/order/view-order", method = RequestMethod.GET)
	public ModelAndView viewOrder(@RequestParam(name = "page", defaultValue = "1") int page,
								  @RequestParam(name = "limit", defaultValue = "5") int limit) {
		ModelAndView mav = new ModelAndView("admin/order/view_order");

		OrderDTO orderDTO = new OrderDTO();
		orderDTO.setPage(page);
		orderDTO.setLimit(limit);
		orderDTO.setTotalItem(iOrderService.getTotalItem());
		orderDTO.setTotalPage((int) Math.ceil((double) orderDTO.getTotalItem() / orderDTO.getLimit()));

		Pageable pageable = new PageRequest(page - 1, limit);
		orderDTO.setListResult(iOrderService.listAll(pageable));

		mav.addObject("orders", orderDTO); // Thêm vào ModelAndView
		return mav;
	}
	
	@RequestMapping(value = "/admin/order/view-order-detail", method = RequestMethod.GET)
	public ModelAndView viewOrderDetail(@RequestParam(value = "order_code") String orderCode) {
		ModelAndView mav = new ModelAndView("admin/order/view_detail_order");

		mav.addObject("order_byId", iOrderService.listOrderDetail(orderCode));

		mav.addObject("order_detail", iOrderDetailService.listOrderDetailById(orderCode));
		return mav;
	}

	@RequestMapping(value = "/admin/order/cancel-order", method = RequestMethod.GET)
	public ModelAndView cancelOrder(@RequestParam(name = "order_code") String orderCode) {
		ModelAndView mav = new ModelAndView("admin/order/cancel-order");

		OrderEntity order = iOrderService.findByOrderCode(orderCode);
		if (order != null) {
			order.setOrderStatus(OrderEntity.OrderStatus.CANCELLED);
			iOrderService.saveOrder(order);
			mav.addObject("order", order);
			mav.addObject("message", "Đơn hàng đã được hủy thành công.");
		} else {
			mav.addObject("error", "Không tìm thấy đơn hàng.");
		}

		return mav;
	}

	@RequestMapping(value = "/admin/order/confirm-order", method = RequestMethod.GET)
	public ModelAndView confirmOrder(@RequestParam(name = "order_code") String orderCode) {
		ModelAndView mav = new ModelAndView("admin/order/confirm-order");
		OrderEntity order = iOrderService.findByOrderCode(orderCode);
		if (order != null) {
			order.setOrderStatus(OrderEntity.OrderStatus.COMPLETED);
			iOrderService.saveOrder(order);
			mav.addObject("order", order);
			mav.addObject("message", "Đơn hàng đã được xác nhận thành công.");
		} else {
			mav.addObject("error", "Không tìm thấy đơn hàng.");
		}

		return mav;
	}

	@RequestMapping("/admin/order/print-order")
	public ModelAndView printOrder(@RequestParam("order_code") String orderCode) {
		ModelAndView mav = new ModelAndView("/admin/order/print-order");
		OrderEntity order = iOrderService.listOrderDetail(orderCode);
		List<OrderDetailEntity> orderDetails = iOrderDetailService.listOrderDetailById(orderCode);

		mav.addObject("order_byId", order);
		mav.addObject("order_detail", orderDetails);
		return mav;
	}

	@RequestMapping(value = "/admin/order/search", method = RequestMethod.GET)
	public ModelAndView searchOrder(@RequestParam("keyword") String keyword) {
		ModelAndView mav = new ModelAndView("admin/order/view_order");
		List<OrderEntity> orderEntities = iOrderService.searchOrdersByCode(keyword);
		List<OrderDTO> orderDTOs = orderEntities.stream()
				.map(orderConverter::toDto)
				.collect(Collectors.toList());

		OrderDTO orderDTO = new OrderDTO();
		orderDTO.setListResult(orderDTOs);
		mav.addObject("orders", orderDTO);
		return mav;
	}

}
