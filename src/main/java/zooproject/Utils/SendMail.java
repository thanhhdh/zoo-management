package zooproject.Utils;

import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.Multipart;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeBodyPart;
import javax.mail.internet.MimeMessage;
import javax.mail.internet.MimeMultipart;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Service;

import zooproject.dto.CartDTO;
import zooproject.entity.CouponEntity;

import java.util.List;
import java.util.Properties;

@Service
public class SendMail {

	@Autowired
	private JavaMailSender mailSender;

	public void sendMail(String email, String title, String orderCode, List<CartDTO> cartDTOs, CouponEntity couponEntity) {
	    String fromEmail = "hdhthanh.20it3@vku.udn.vn";
	    String password = "plhp uvlb jnea euif";
	    String host = "smtp.gmail.com";
	    String port = "587";

	    Properties properties = new Properties();
	    properties.put("mail.smtp.auth", "true");
	    properties.put("mail.smtp.starttls.enable", "true");
	    properties.put("mail.smtp.host", host);
	    properties.put("mail.smtp.port", port);

	    new Thread(() -> {
	        try {
	            Session session = Session.getDefaultInstance(properties, new javax.mail.Authenticator() {
	                protected PasswordAuthentication getPasswordAuthentication() {
	                    return new PasswordAuthentication(fromEmail, password);
	                }
	            });

	            // Tạo MimeMessage
	            MimeMessage message = new MimeMessage(session);

	            // Thiết lập thông tin người gửi
	            message.setFrom(new InternetAddress(fromEmail));

	            // Thiết lập thông tin người nhận
	            message.addRecipient(Message.RecipientType.TO, new InternetAddress(email));

	            // Thiết lập tiêu đề email
	            message.setSubject(title);

				// Create HTML content for the booking confirmation email
				StringBuilder htmlContent = new StringBuilder();
				htmlContent.append("<html><head>");
				htmlContent.append("<meta charset=\"UTF-8\">"); // Ensure UTF-8 encoding
				htmlContent.append("<style>")
						.append("body { font-family: Arial, sans-serif; color: #333; }")
						.append(".email-container { max-width: 600px; margin: auto; padding: 20px; border: 1px solid #ddd; border-radius: 8px; }")
						.append("h3 { color: #4CAF50; }")
						.append(".table { width: 100%; border-collapse: collapse; margin-top: 10px; }")
						.append(".table th, .table td { padding: 10px; border: 1px solid #ddd; text-align: left; }")
						.append(".table th { background-color: #f2f2f2; }")
						.append(".table tfoot td { font-weight: bold; }")
						.append(".total-row { font-size: 1.1em; color: #4CAF50; }")
						.append("</style>");
				htmlContent.append("</head><body>");
				htmlContent.append("<div class=\"email-container\">");

				htmlContent.append("<h3>Thank you for your booking!</h3>");
				htmlContent.append("<p>Your booking details are below:</p>");
				htmlContent.append("<p><strong>Order Code:</strong> ").append(orderCode).append("</p>");

				htmlContent.append("<table class='table'>");
				htmlContent.append("<thead>")
						.append("<tr><th>Item</th><th>Quantity</th><th>Price</th></tr>")
						.append("</thead><tbody>");

				double total = 0;
				for (CartDTO cart : cartDTOs) {
					htmlContent.append("<tr>")
							.append("<td>").append(cart.getTicketName()).append("</td>")
							.append("<td>").append(cart.getTicketQty()).append("</td>")
							.append("<td>").append(cart.getTicketPrice()).append("</td>")
							.append("</tr>");
					total += cart.getTicketPrice() * cart.getTicketQty();
				}



// Nếu có mã giảm giá
				if (couponEntity != null) {
					double couponDiscount = 0.0;
					String discountDisplay;
					if (couponEntity.getCouponCondition() == 1) {  // Percentage discount
						couponDiscount = total * couponEntity.getCouponNumber() / 100;
						discountDisplay = couponEntity.getCouponNumber() + "%";
					} else {  // Fixed discount
						couponDiscount = couponEntity.getCouponNumber();
						discountDisplay = couponEntity.getCouponNumber() + " đ";
					}
					total -= couponDiscount;

					htmlContent.append("<tr>")
							.append("<td colspan='2'><strong>Coupon Discount (").append(discountDisplay).append(")</strong></td>")
							.append("<td>-").append(couponDiscount).append("</td>")
							.append("</tr>");
				}

// Add total row
				htmlContent.append("</tbody><tfoot>");
				htmlContent.append("<tr class='total-row'><td colspan='2'>Total</td>")
						.append("<td>").append(total).append(" đ</td></tr>");
				htmlContent.append("</tfoot></table>");

				htmlContent.append("<p>We look forward to serving you. Thank you for choosing us!</p>");
				htmlContent.append("</div></body></html>");


				// Sử dụng Multipart để hỗ trợ cả HTML và Plain text (nếu cần)
	            MimeBodyPart mimeBodyPart = new MimeBodyPart();
	            mimeBodyPart.setContent(htmlContent.toString(), "text/html; charset=UTF-8");

	            Multipart multipart = new MimeMultipart();
	            multipart.addBodyPart(mimeBodyPart);

	            message.setContent(multipart);

	            // Gửi email
	            try (Transport transport = session.getTransport("smtp")) {
	                transport.connect(host, fromEmail, password);
	                transport.sendMessage(message, message.getAllRecipients());
	            }

	        } catch (MessagingException e) {
	            e.printStackTrace();
	        }
	    }).start();
	}

	public void sendEmailFAQ(String to, String subject, String body) {
		SimpleMailMessage message = new SimpleMailMessage();
		message.setTo(to);
		message.setSubject(subject);
		message.setText(body);
		message.setFrom("hdhthanh.20it3@vku.udn.vn");

		mailSender.send(message);
	}
}
