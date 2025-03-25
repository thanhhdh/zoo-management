<%--
  Created by IntelliJ IDEA.
  User: hdhth
  Date: 12/12/2024
  Time: 2:30 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Quy định và Nội quy</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f0f4f8;
            color: #333;
        }

        .rules-header {
            background: linear-gradient(rgba(0, 0, 0, 0.6), rgba(0, 0, 0, 0.6)), url('https://via.placeholder.com/1920x400') no-repeat center center;
            background-size: cover;
            color: #fff;
            text-align: center;
            padding: 80px 20px;
        }

        .rules-header h1 {
            font-size: 3.5rem;
            font-weight: bold;
            margin-bottom: 10px;
        }

        .rules-header p {
            font-size: 1.2rem;
            margin-top: 10px;
        }

        .rules-container {
            background-color: #fff;
            padding: 40px;
            border-radius: 10px;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
            margin-top: -50px;
        }

        .rules-container h3 {
            font-weight: bold;
            margin-bottom: 25px;
            color: #0056b3;
        }

        .rules-container ul {
            padding-left: 20px;
        }

        .rules-container ul li {
            margin-bottom: 15px;
            font-size: 1.1rem;
        }

        .rules-container ul li::before {
            content: "\2022";
            color: #0056b3;
            font-weight: bold;
            display: inline-block;
            width: 1em;
            margin-left: -1em;
        }
    </style>
</head>
<body>


<div class="container py-5">
    <header class="rules-header text-center">
        <h1>Quy định và Nội quy</h1>
        <p>Những hướng dẫn nhằm đảm bảo một chuyến tham quan an toàn và thú vị cho mọi người.</p>
    </header>
    <div class="rules-container">
        <h3>Quy định chung</h3>
        <ul>
            <li>Không tự ý cho động vật ăn nếu không có hướng dẫn từ nhân viên sở thú.</li>
            <li>Giữ khoảng cách an toàn với chuồng trại động vật.</li>
            <li>Vứt rác đúng nơi quy định.</li>
            <li>Không được hút thuốc trong khu vực sở thú.</li>
            <li>Luôn tuân thủ các hướng dẫn của nhân viên sở thú.</li>
        </ul>

        <h3>Những vật dụng bị cấm</h3>
        <ul>
            <li>Vũ khí các loại.</li>
            <li>Đồ uống có cồn.</li>
            <li>Loa lớn hoặc thiết bị gây ồn.</li>
            <li>Máy bay không người lái hoặc thiết bị bay.</li>
        </ul>

        <h3>Hành vi của khách tham quan</h3>
        <ul>
            <li>Tôn trọng khách tham quan khác, tránh gây ồn ào hoặc mất trật tự.</li>
            <li>Luôn để mắt đến trẻ em.</li>
            <li>Không leo trèo hàng rào hoặc cản trở.</li>
            <li>Không cố gắng chạm vào hoặc trêu chọc động vật.</li>
        </ul>

        <h3>Quy trình khẩn cấp</h3>
        <ul>
            <li>Trong trường hợp khẩn cấp, liên hệ ngay với nhân viên sở thú gần nhất.</li>
            <li>Thực hiện theo kế hoạch sơ tán nếu được hướng dẫn.</li>
            <li>Giữ bình tĩnh và hỗ trợ người khác nếu cần.</li>
        </ul>
    </div>
</div>
</body>
</html>
