<%@ page language="java" contentType="text/html; charset=UTF-8"
		 pageEncoding="UTF-8"%>
<html>
<head>
<title>Home | Zoo</title>

<link
	href="https://fonts.googleapis.com/css2?family=Lalezar&display=swap"
	rel="stylesheet">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/animate.css/4.1.1/animate.min.css" />
	<!-- Bootstrap CSS -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
	<!-- jQuery -->
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<!-- Toastr CSS -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/toastr.min.css">
<!-- Toastr JS -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/toastr.min.js"></script>
<%--<script src="https://cdn.tailwindcss.com"></script>--%>
	<!-- Bootstrap JS -->

<script>
	function message_toastr(type, content) {
		toastr.options = {
			"closeButton" : true,
			"debug" : true,
			"newestOnTop" : false,
			"progressBar" : true,
			"positionClass" : "toast-top-right",
			"preventDuplicates" : true,
			"showDuration" : "300",
			"hideDuration" : "1000",
			"timeOut" : "5000",
			"extendedTimeOut" : "1000",
			"showEasing" : "swing",
			"hideEasing" : "linear",
			"showMethod" : "fadeIn",
			"hideMethod" : "fadeOut"
		};
		toastr[type](content);
	}
</script>
	<script src="https://www.gstatic.com/dialogflow-console/fast/messenger/bootstrap.js?v=1"></script>
<%--	<df-messenger--%>
<%--			intent="WELCOME"--%>
<%--			chat-title="management_zoo"--%>
<%--			agent-id="99821f56-f780-49b4-a575-112d4b9b2999"--%>
<%--			language-code="vi"--%>
<%--	></df-messenger>--%>
	<style>
		.hero-section {
			height: 100vh;
			background: url('${pageContext.request.contextPath}/template/web/assets/img/animal_banner/tiger_banner.jpg') center/cover no-repeat;
			display: flex;
			flex-direction: column;
			justify-content: center;
			align-items: center;
			color: white;
			text-shadow: 2px 2px 4px rgba(0, 0, 0, 0.5);
		}

		.hero-button {
			background-color: #28a745;
			color: white;
			border: none;
			padding: 10px 20px;
			font-size: 1.5rem;
			border-radius: 50px;
			transition: all 0.3s ease;
		}

		.hero-button:hover {
			background-color: #218838;
			transform: scale(1.05);
		}

		.animal-section {
			background: url('${pageContext.request.contextPath}/template/web/assets/img/background/lines_seamless_pattern.jpg') center/cover repeat;
			padding: 50px 0;
		}

		.animal-card img {
			height: 200px;
			object-fit: cover;
		}

		.animal-card:hover .card-body {
			color: white;
		}

		.about-section {
			height: 100vh;
			background: url('${pageContext.request.contextPath}/template/web/assets/img/animal_banner/hippo_panner.jpg') center/cover no-repeat;
			display: flex;
			margin-bottom: 50px;
			flex-direction: column;
			justify-content: center;
			align-items: center;
			color: white;
			text-shadow: 2px 2px 4px rgba(0, 0, 0, 0.5);
		}

		.animal-section {
			height: 100vh;
			background: url('${pageContext.request.contextPath}/template/web/assets/img/animal_banner/header_panda.jpeg') center/cover no-repeat;
			display: flex;
			margin-bottom: 50px;
			flex-direction: column;
			justify-content: center;
			align-items: center;
			color: white;
			text-shadow: 2px 2px 4px rgba(0, 0, 0, 0.5);
		}

		.about-us {
			background: #f9f9f9;
		}

		.section-title {
			font-size: 2.5rem;
			font-weight: bold;
			color: #2d6a4f;
		}

		.section-subtitle {
			font-size: 1.2rem;
			color: #ffffff;
		}

		.mission-card, .vision-card, .about-card, .team-card {
			background: #ffffff;
			border: 1px solid #e0e0e0;
			min-height: 200px;
			border-radius: 10px;
			box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
		}

		.mission-title, .vision-title {
			font-size: 1.5rem;
			font-weight: bold;
			color: #1b4332;
		}

		.mission-text, .vision-text {
			font-size: 1rem;
			color: #495057;
		}

		.list-group-item {
			font-size: 1rem;
			color: #343a40;
			background: transparent;
		}

		a {
			color: #1b4332;
			text-decoration: none;
		}

		a:hover {
			text-decoration: underline;
		}

	/* Page Animal Style	*/
		.animals {
			background: #f8f9fa;
		}

		.section-title {
			font-size: 2.5rem;
			font-weight: bold;
			color: #1b4332;
		}

		.animal-card {
			border: 1px solid #e0e0e0;
			border-radius: 10px;
			box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
			transition: transform 0.3s;
		}

		.animal-card:hover {
			transform: translateY(-5px);
		}

		.card-title {
			font-size: 1.5rem;
			font-weight: bold;
			color: #2d6a4f;
		}

		.card-text {
			font-size: 1rem;
			color: #495057;
		}

		.btn-primary {
			background-color: #2d6a4f;
			border: none;
		}

		.btn-primary:hover {
			background-color: #1b4332;
		}

		.category-box {
			padding: 20px;
			border-radius: 10px;
			transition: transform 0.3s;
		}

		.category-box:hover {
			transform: scale(1.05);
		}
		img.category-icon {
			width: 100px;
			height: 100px;
		}
		.category-icon {
			margin-bottom: 15px;
		}
		/*	Page Animal End Style*/

		/* Style Chatbot*/
		/* Chatbot Container */
		.chatbot-container {
			position: fixed;
			bottom: 90px;
			right: 20px;
			width: 360px;
			height: 500px;
			background: #ffffff;
			border-radius: 15px;
			box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
			font-family: Arial, sans-serif;
			display: flex;
			flex-direction: column;
			overflow: hidden;
			z-index: 1000;
		}

		/* Hidden Class for Chatbot */
		.hidden {
			display: none;
		}

		/* Chat Header */
		.chat-header {
			background-color: #007bff;
			color: #ffffff;
			text-align: center;
			padding: 15px;
			border-top-left-radius: 15px;
			border-top-right-radius: 15px;
			display: flex;
			justify-content: space-between;
			align-items: center;
		}

		.chat-header h5 {
			margin: 0;
			font-size: 18px;
		}

		.close-chat {
			background: none;
			border: none;
			color: #ffffff;
			font-size: 18px;
			cursor: pointer;
		}

		/* Chat Body */
		.chat-body {
			flex: 1;
			overflow-y: auto;
			background-color: #f8f9fa;
			padding: 15px;
			display: flex;
			flex-direction: column;
			gap: 10px;
		}

		.chat-log {
			display: flex;
			flex-direction: column;
			gap: 10px;
		}

		.chat-message {
			max-width: 75%;
			padding: 10px;
			border-radius: 15px;
			font-size: 14px;
			line-height: 1.5;
		}

		.user-message {
			align-self: flex-end;
			background-color: #007bff;
			color: #ffffff;
		}

		.bot-response {
			align-self: flex-start;
			background-color: #eeeeee;
			color: #000000;
		}

		.bot-response img {
			width: 210px;
			height: auto;
			border-radius: 20px;
		}

		/* Chat Footer */
		.chat-footer {
			display: flex;
			align-items: center;
			padding: 10px;
			background-color: #ffffff;
			border-top: 1px solid #dddddd;
		}

		.chat-input {
			flex: 1;
			border: 1px solid #dddddd;
			border-radius: 15px;
			padding: 10px;
			font-size: 14px;
			margin-right: 10px;
			width: 270px;
		}

		.chat-send-btn {
			background-color: #007bff;
			color: #ffffff;
			border: none;
			padding: 10px 15px;
			border-radius: 15px;
			cursor: pointer;
			font-size: 14px;
		}

		.chat-send-btn:hover {
			background-color: #0056b3;
		}

		/* Widget Icon */
		.widget-icon {
			position: fixed;
			bottom: 20px;
			right: 20px;
			width: 60px;
			height: 60px;
			background: #007bff;
			color: #ffffff;
			border-radius: 50%;
			display: flex;
			justify-content: center;
			align-items: center;
			box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
			cursor: pointer;
			z-index: 1000;
		}

		.widget-icon i, .close-chat i {
			font-size: 24px; /* Kích thước icon */
			cursor: pointer;
		}

		hr {
			margin: 0;
		}

		/* End Style Chatbot*/

	</style>
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
</head>
<body style="font-family: 'Lalezar', sans-serif">

	<%@include file="/common/web/header.jsp"%>
	<dec:body />
	<!-- Chatbox UI -->
	<!-- Chatbot Widget -->
	<div id="chatbot-widget">
		<!-- Chatbot Icon (Minimized State) -->
		<div id="widgetIcon" class="widget-icon">
			<i class="fa fa-plus"></i>
		</div>

		<!-- Chatbot Container (Expanded State) -->
		<div id="chatbotContainer" class="chatbot-container hidden">
			<div class="chat-header">
				<h5>Zoo Chatbot</h5>
				<button id="closeChat" class="close-chat">
					<i class="fa fa-times"></i>
				</button>
			</div>
			<div class="chat-body">
				<div id="chat-log" class="chat-log">
					<!-- Chat messages appear here -->
				</div>
			</div>
			<div class="chat-footer">
				<form id="chat-form" class="chat-form">
					<input
							type="text"
							id="chat-input"
							placeholder="Nhập tin nhắn của bạn ở đây..."
							autocomplete="off"
							class="chat-input"
					/>
					<button type="submit" class="chat-send-btn">
						<i class="mdi mdi-send"></i>
						Gửi
					</button>
				</form>
			</div>
		</div>
	</div>
	<!-- End Chatbot Widget -->
	<%@include file="/common/web/footer.jsp"%>



	<script src="https://code.jquery.com/jquery-3.6.0.js"></script>
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>

<%-- Chatbot sccript	--%>
	<!-- Chatbot Script -->
	<script>
		const widgetIcon = document.getElementById("widgetIcon");
		const chatbotContainer = document.getElementById("chatbotContainer");
		const closeChat = document.getElementById("closeChat");
		const chatForm = document.getElementById("chat-form");
		const chatInput = document.getElementById("chat-input");
		const chatLog = document.getElementById("chat-log");

		// Toggle Chatbot Visibility
		widgetIcon.addEventListener("click", () => {
			chatbotContainer.classList.toggle("hidden");
			const icon = widgetIcon.querySelector("i");
			if (chatbotContainer.classList.contains("hidden")) {
				icon.classList.remove("fa-times");
				icon.classList.add("fa-plus");
			} else {
				icon.classList.remove("fa-plus");
				icon.classList.add("fa-times");
			}
		});

		closeChat.addEventListener("click", () => {
			chatbotContainer.classList.add("hidden");
			const icon = widgetIcon.querySelector("i");
			icon.classList.remove("fa-times");
			icon.classList.add("fa-plus");
		});

		// Chatbot Form Submission
		chatForm.addEventListener("submit", async (e) => {
			e.preventDefault();
			const userMessage = chatInput.value.trim();
			if (!userMessage) return;

			// Append user's message
			const userMsg = document.createElement("div");
			userMsg.classList.add("chat-message", "user-message");
			userMsg.textContent = userMessage;
			chatLog.appendChild(userMsg);
			chatInput.value = "";
			chatLog.scrollTop = chatLog.scrollHeight;

			// Fetch bot response
			try {
				const response = await fetch("http://localhost:5000/chat", {
					method: "POST",
					headers: { "Content-Type": "application/json" },
					body: JSON.stringify({ message: userMessage }),
				});

				const data = await response.json();
				const botMsg = document.createElement("div");
				botMsg.classList.add("chat-message", "bot-response");
				botMsg.innerHTML = data.response; // Use innerHTML for rendering HTML
				chatLog.appendChild(botMsg);
				chatLog.scrollTop = chatLog.scrollHeight;
			} catch (error) {
				console.error("Error fetching bot response:", error);
				const botError = document.createElement("div");
				botError.classList.add("chat-message", "bot-response");
				botError.textContent = "Sorry, I encountered an issue. Please try again later.";
				chatLog.appendChild(botError);
			}
		});
	</script>
<%-- End chatbot script	--%>

	<script>
		// JavaScript to change navbar style on scroll
		window.addEventListener('scroll', function () {
			const navbar = document.getElementById('navbar');
			const scrollTarget = document.getElementById('scrollTarget');
			const scrollTargetPosition = scrollTarget.offsetTop;

			if (window.scrollY >= scrollTargetPosition) {
				navbar.classList.add('fixed-top');
			} else {
				navbar.classList.remove('fixed-top');
			}
		});
	</script>
	<script>
		// JavaScript to scroll to target on button click
		document.getElementById('scrollButton').addEventListener('click', function () {
			const scrollTarget = document.getElementById('scrollTarget');
			scrollTarget.scrollIntoView({behavior: 'smooth'});
		});
	</script>


	<script type="text/javascript">
		$(document).ready(function() {
			<c:if test="${not empty message}">
			var message = "${message.message}";
			var type = "${message.type}";
			message_toastr(type, message, "Thông Báo");
			</c:if>
		});
	</script>
</body>

</html>
