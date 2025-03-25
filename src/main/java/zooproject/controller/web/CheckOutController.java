package zooproject.controller.web;

import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.*;

import javax.crypto.Mac;
import javax.crypto.spec.SecretKeySpec;
import javax.mail.MessagingException;
import javax.mail.Multipart;
import javax.mail.internet.MimeBodyPart;
import javax.mail.internet.MimeMultipart;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.codec.binary.Hex;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import zooproject.Utils.SendMail;
import zooproject.dto.CartDTO;
import zooproject.entity.CouponEntity;
import zooproject.entity.CustomerEntity;
import zooproject.entity.InforEntity;
import zooproject.entity.OrderDetailEntity;
import zooproject.entity.OrderEntity;
import zooproject.entity.PaymentEntity;
import zooproject.service.ICouponService;
import zooproject.service.IInforService;
import zooproject.service.IOrderDetailService;
import zooproject.service.IOrderService;
import zooproject.service.IPaymentService;

@Controller
public class CheckOutController {
	@Autowired
	private IInforService iInforService;

	@Autowired
	private IPaymentService iPaymentService;

	@Autowired
	private IOrderService iOrderService;

	@Autowired
	private IOrderDetailService iOrderDetailService;

	@Autowired
	private ICouponService iCouponService;

	@Autowired
	private SendMail sendMail;

	@RequestMapping(value = "/thu-tuc-thanh-toan", method = RequestMethod.GET)
	public ModelAndView datVe(HttpSession session) {
		ModelAndView modelAndView = new ModelAndView("web/checkout/check_out");
		return modelAndView;
	}

	@PostMapping("/thong-tin-ca-nhan")
	public void infoDelivery(HttpServletRequest request, @ModelAttribute("infor") InforEntity inforEntity,
			HttpSession session, HttpServletResponse respone) throws IOException {
		if (inforEntity != null) {
			session.setAttribute("infor", inforEntity);
		}
		respone.sendRedirect(request.getContextPath() + "/thanh-toan");
	}

	@RequestMapping(value = "/thanh-toan", method = RequestMethod.GET)
	public ModelAndView payMent(HttpSession session) {
		ModelAndView mav = new ModelAndView("web/checkout/payment");

		List<CartDTO> cartItems = (List<CartDTO>) session.getAttribute("cart");

		CouponEntity couponEntity = (CouponEntity) session.getAttribute("coupon");

		mav.addObject("cartItems", cartItems);
		if (couponEntity != null) {
			mav.addObject("coupon", couponEntity);
			System.out.println("coupon; " + couponEntity.getCouponNumber());
		} else {
			mav.addObject("coupon", null);
		}
		return mav;
	}

	@RequestMapping(value = "/dat-hang", method = RequestMethod.GET)
	public String order(
			@RequestParam("payment_method") String paymentMethod,
			HttpServletRequest request, HttpServletResponse response, HttpSession session,
						RedirectAttributes redirectAttributes) throws Exception {
		Map<String, Object> message = new HashMap<>();

		// Retrieve session entities
		InforEntity inforEntity = (InforEntity) session.getAttribute("infor");
		CustomerEntity customerEntity = (CustomerEntity) session.getAttribute("customer");
		CouponEntity couponEntity = (CouponEntity) session.getAttribute("coupon");
		List<CartDTO> cartDTOs = (List<CartDTO>) session.getAttribute("cart");

		// Save InforEntity
		iInforService.insert(inforEntity);

		// Save PaymentEntity
		PaymentEntity paymentEntity = new PaymentEntity();
		paymentEntity.setPaymentMethod(paymentMethod); // Use selected payment method
		paymentEntity.setPaymentStatus("0");
		iPaymentService.insert(paymentEntity);

		// Save OrderEntity
		String orderCode = "TAT" + (new Random().nextInt(90000) + 10000);
		OrderEntity order = new OrderEntity();
		order.setOrderCode(orderCode);
		order.setInforId(inforEntity);
		order.setPaymentId(paymentEntity);
		CustomerEntity customerEntity2 = new CustomerEntity();
		customerEntity2.setCustomerId(0L);
		order.setCustomerId(customerEntity2);
		order.setOrderCoupon(couponEntity != null ? couponEntity.getCouponCode() : "0");
		order.setCouponPrice(couponEntity != null ? couponEntity.getCouponNumber() : 0);
		order.setOrderStatus(OrderEntity.OrderStatus.PENDING);
		iOrderService.saveOrder(order); // Save OrderEntity first to generate ID

		// Debug: Check saved OrderEntity ID
		System.out.println("OrderEntity ID after saving: " + order.getOrderId());

		// Save OrderDetailEntity list
		for (CartDTO cartDTO : cartDTOs) {
			OrderDetailEntity orderDetailEntity = new OrderDetailEntity();
			orderDetailEntity.setOrder(order);  // Set the OrderEntity reference
			orderDetailEntity.setOrderCode(orderCode);
			orderDetailEntity.setTicketName(cartDTO.getTicketName());
			orderDetailEntity.setTicketPrice(cartDTO.getTicketPrice());
			orderDetailEntity.setTicketSalesQuantity(cartDTO.getTicketQty());
			order.getOrderDetails().add(orderDetailEntity);
			iOrderDetailService.saveOrderDetail(orderDetailEntity);
		}

		// Post-order processing (e.g., clearing session, handling coupon)
		if ("1".equals(paymentMethod)) {
			if (couponEntity != null) {
				iCouponService.deleteQtyCoupon(couponEntity.getCouponCode());
				session.setAttribute("coupon", null);
			}
			session.setAttribute("cart", null);
			message.put("message", "Đặt hàng thành công, kiểm tra email!");
			message.put("type", "success");

		} else if ("2".equals(paymentMethod)) {
			String vnp_TmnCode = "E4O1Y1D0";
			String vnp_HashSecret = "9VIM7QJ0KZIUE4M5NP5ICLRHSU6PC5O7";
			String vnp_Url = "https://sandbox.vnpayment.vn/paymentv2/vpcpay.html";
			String vnp_Version = "2.1.0";
			String vnp_Command = "pay";

			// Ensure the amount is properly formatted as an integer in VND * 100
			String amount = String.valueOf((long) (order.getTotalAmount() * 100));

			String vnp_ReturnUrl = "http://localhost:8080/zooproject/trang-chu";
			String vnp_IpAddr = request.getRemoteAddr();

			DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyyMMddHHmmss");
			String vnp_CreateDate = LocalDateTime.now().format(formatter);

			// Prepare parameters for VNPay
			Map<String, String> vnp_Params = new HashMap<>();
			vnp_Params.put("vnp_Version", vnp_Version);
			vnp_Params.put("vnp_Command", vnp_Command);
			vnp_Params.put("vnp_TmnCode", vnp_TmnCode);
			vnp_Params.put("vnp_Amount", amount);
			vnp_Params.put("vnp_CurrCode", "VND");
			vnp_Params.put("vnp_TxnRef", orderCode);
			vnp_Params.put("vnp_OrderInfo", "Thanh toán đơn hàng " + orderCode);
			vnp_Params.put("vnp_Locale", "vn");
			vnp_Params.put("vnp_ReturnUrl", vnp_ReturnUrl);
			vnp_Params.put("vnp_IpAddr", vnp_IpAddr);
			vnp_Params.put("vnp_OrderType", "other");
			vnp_Params.put("vnp_CreateDate", vnp_CreateDate);

			String queryUrl = createQueryUrl(vnp_Params);
			String secureHash = hmacSHA512(vnp_HashSecret, queryUrl);

			String paymentUrl = vnp_Url + "?" + queryUrl + "&vnp_SecureHash=" + secureHash;

			System.out.println("VNPay Payment URL: " + paymentUrl);

			return "redirect:" + paymentUrl;
		}

		// Send email notification and redirect with a message
		sendMail.sendMail(inforEntity.getEmail(), "Zoo - Đặt Vé Thành Công", orderCode, cartDTOs, couponEntity);
		redirectAttributes.addFlashAttribute("message", message);
		return "redirect:/trang-chu";
	}


	public String createQueryUrl(Map<String, String> params) throws UnsupportedEncodingException {
		List<String> fieldNames = new ArrayList<>(params.keySet());
		Collections.sort(fieldNames);
		StringBuilder sb = new StringBuilder();
		for (String fieldName : fieldNames) {
			String fieldValue = params.get(fieldName);
			if ((fieldValue != null) && (fieldValue.length() > 0)) {
				sb.append(URLEncoder.encode(fieldName, "UTF-8"));
				sb.append('=');
				sb.append(URLEncoder.encode(fieldValue, "UTF-8"));
				sb.append('&');
			}
		}
		// Xóa ký tự '&' cuối cùng
		return sb.substring(0, sb.length() - 1);
	}

	public String hmacSHA512(String key, String data) throws Exception {
		Mac hmacSHA512 = Mac.getInstance("HmacSHA512");
		SecretKeySpec secretKey = new SecretKeySpec(key.getBytes(), "HmacSHA512");
		hmacSHA512.init(secretKey);
		return Hex.encodeHexString(hmacSHA512.doFinal(data.getBytes("UTF-8")));
	}



}
