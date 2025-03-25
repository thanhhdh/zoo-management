-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Máy chủ: 127.0.0.1
-- Thời gian đã tạo: Th7 25, 2024 lúc 09:34 AM
-- Phiên bản máy phục vụ: 10.4.24-MariaDB
-- Phiên bản PHP: 8.1.6

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Cơ sở dữ liệu: `zoo_management`
--

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `tbl_roles`
--

CREATE TABLE `tbl_roles` (
  `id` bigint(20) NOT NULL,
  `name` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Đang đổ dữ liệu cho bảng `tbl_roles`
--

INSERT INTO `tbl_roles` (`id`, `name`) VALUES
(1, 'ROLE_ADMIN'),
(2, 'ROLE_MANAGER'),
(3, 'ROLE_EMPLOYEE'),
(4, 'ROLE_USERS');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `tbl_species`
--

CREATE TABLE `tbl_species` (
  `species_id` bigint(20) NOT NULL,
  `species_name` varchar(255) DEFAULT NULL,
  `species_desc` varchar(1000) DEFAULT NULL,
  `species_image` varchar(255) DEFAULT NULL,
  `species_status` int(1) NOT NULL,
  `species_allocation` varchar(1000) DEFAULT NULL,
  `species_reproduction` varchar(1000) DEFAULT NULL,
  `species_ecological` varchar(1000) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `created_by` varchar(255) DEFAULT NULL,
  `updated_by` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Đang đổ dữ liệu cho bảng `tbl_species`
--

INSERT INTO `tbl_species` (`species_id`, `species_name`, `species_desc`, `species_image`, `species_status`, `species_allocation`, `species_reproduction`, `species_ecological`, `created_at`, `updated_at`, `created_by`, `updated_by`) VALUES
(1, 'Động vật có vú', 'Cấu tạo cơ thể: Động vật có vú có xương sống, hệ thần kinh phát triển cao, có lông mao bao phủ cơ thể ở mức độ khác nhau tùy loài. Chúng có tim bốn ngăn và hệ tuần hoàn kín. Tuyến sữa: Đây là đặc điểm phân biệt của lớp động vật này, cho phép chúng nuôi dưỡng con non bằng sữa mẹ. Hệ hô hấp: Chúng có phổi phát triển, giúp hô hấp hiệu quả hơn.', 'animals_hero_antelope.jpg', 1, 'Phân bố địa lý: Động vật có vú phân bố rộng rãi trên khắp hành tinh, từ vùng cực băng giá, sa mạc khô cằn, rừng nhiệt đới ẩm ướt đến các đại dương sâu thẳm. Môi trường sống: Chúng có thể sống ở nhiều môi trường khác nhau, bao gồm trên cạn, dưới nước và trên không. Một số loài như dơi có khả năng bay, trong khi cá voi và cá heo sống hoàn toàn dưới nước.', 'Cách sinh sản: Động vật có vú sinh sản chủ yếu qua cách thức sinh con (viviparous), tức là phôi thai phát triển bên trong cơ thể mẹ cho đến khi sinh ra. Một số ít loài như thú mỏ vịt và echidna lại đẻ trứng (oviparous). Chăm sóc con non: Sau khi sinh, con non được nuôi dưỡng bằng sữa mẹ, điều này giúp chúng phát triển nhanh chóng và tăng cơ hội sống sót.', 'Vai trò sinh thái: Động vật có vú đóng vai trò quan trọng trong các hệ sinh thái. Chúng có thể là động vật săn mồi, động vật ăn cỏ, hoặc các loài sống ký sinh. Mối quan hệ với môi trường: Chúng ảnh hưởng và bị ảnh hưởng bởi môi trường sống của mình, tham gia vào các chuỗi thức ăn và góp phần vào việc duy trì cân bằng sinh thái. Tương tác với con người: Nhiều loài động vật có vú có mối quan hệ gần gũi với con người, từ thú cưng đến động vật nuôi lấy thịt, lông, sữa. Một số loài khác lại được bảo vệ và giữ gìn vì chúng đang đối mặt với nguy cơ tuyệt chủng do hoạt động của con người.', '2024-07-25 03:16:39', '2024-07-25 03:22:38', 'admin', 'admin'),
(3, 'TEST', 'TEST', 'animals_hero_antelope.jpg', 0, 'TEST', 'test', 'test', '2024-07-25 06:30:33', '2024-07-25 06:30:33', 'admin', 'admin'),
(4, 'TEST', 'TEST', 'animals_hero_antelope.jpg', 0, 'TEST', 'test', 'TEST', '2024-07-25 06:30:45', '2024-07-25 06:30:45', 'admin', 'admin'),
(5, 'TEST', 'TEST', 'animals_hero_antelope.jpg', 0, 'TEST', 'test', 'TEST', '2024-07-25 06:30:57', '2024-07-25 06:30:57', 'admin', 'admin'),
(6, 'Động vật có vú', 'TEST', 'animals_hero_antelope.jpg', 0, 'TEST', 'test', 'TEST', '2024-07-25 06:31:08', '2024-07-25 06:31:08', 'admin', 'admin'),
(7, 'TEST', 'TEST', 'animals_hero_antelope.jpg', 0, 'TEST', 'test', 'TEST', '2024-07-25 06:42:30', '2024-07-25 06:42:30', 'admin', 'admin');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `tbl_users`
--

CREATE TABLE `tbl_users` (
  `id` bigint(20) NOT NULL,
  `created_at` datetime DEFAULT NULL,
  `created_by` varchar(255) DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `updated_by` varchar(255) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `full_name` varchar(255) DEFAULT NULL,
  `password` varchar(255) DEFAULT NULL,
  `user_name` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Đang đổ dữ liệu cho bảng `tbl_users`
--

INSERT INTO `tbl_users` (`id`, `created_at`, `created_by`, `updated_at`, `updated_by`, `email`, `full_name`, `password`, `user_name`) VALUES
(17, '2024-07-18 22:42:54', 'admin', '2024-07-18 22:42:54', 'admin', 'tan@gmail.com', 'Tân Đôn', '$2a$10$MXWie3XxpKHpDPQPeejlS.KFlEus9cHVHmkfkUU9BsWABiI3KTt7a', 'manager'),
(18, '2024-07-18 22:44:30', 'admin', '2024-07-18 22:44:30', 'admin', 'phunhuanhuynh2003@gmail.com', 'Huỳnh Nhuận', '$2a$10$kPo1YBrpxhSSE2sc7btTz.q/vIZKrm.GpOLmG1P1/33wd/g9JKE9C', 'admin'),
(19, '2024-07-18 22:46:56', 'admin', '2024-07-18 22:46:56', 'admin', 'huy@gmail.com', 'Huy ', '$2a$10$CvajojaMWdBD6ItqzN8UbOMSMoEUwuXpBfzLSdHLiXxB4aS2KKHYm', 'employee');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `user_roles`
--

CREATE TABLE `user_roles` (
  `user_id` bigint(20) NOT NULL,
  `role_id` bigint(20) NOT NULL,
  `id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Đang đổ dữ liệu cho bảng `user_roles`
--

INSERT INTO `user_roles` (`user_id`, `role_id`, `id`) VALUES
(18, 1, 17),
(19, 3, 24),
(17, 2, 26);

--
-- Chỉ mục cho các bảng đã đổ
--

--
-- Chỉ mục cho bảng `tbl_roles`
--
ALTER TABLE `tbl_roles`
  ADD PRIMARY KEY (`id`);

--
-- Chỉ mục cho bảng `tbl_species`
--
ALTER TABLE `tbl_species`
  ADD PRIMARY KEY (`species_id`);

--
-- Chỉ mục cho bảng `tbl_users`
--
ALTER TABLE `tbl_users`
  ADD PRIMARY KEY (`id`);

--
-- Chỉ mục cho bảng `user_roles`
--
ALTER TABLE `user_roles`
  ADD PRIMARY KEY (`id`),
  ADD KEY `FK_5q4rc4fh1on6567qk69uesvyf` (`role_id`),
  ADD KEY `FK_g1uebn6mqk9qiaw45vnacmyo2` (`user_id`);

--
-- AUTO_INCREMENT cho các bảng đã đổ
--

--
-- AUTO_INCREMENT cho bảng `tbl_roles`
--
ALTER TABLE `tbl_roles`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT cho bảng `tbl_species`
--
ALTER TABLE `tbl_species`
  MODIFY `species_id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT cho bảng `tbl_users`
--
ALTER TABLE `tbl_users`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=20;

--
-- AUTO_INCREMENT cho bảng `user_roles`
--
ALTER TABLE `user_roles`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=27;

--
-- Các ràng buộc cho các bảng đã đổ
--

--
-- Các ràng buộc cho bảng `user_roles`
--
ALTER TABLE `user_roles`
  ADD CONSTRAINT `FK_5q4rc4fh1on6567qk69uesvyf` FOREIGN KEY (`role_id`) REFERENCES `tbl_roles` (`id`),
  ADD CONSTRAINT `FK_g1uebn6mqk9qiaw45vnacmyo2` FOREIGN KEY (`user_id`) REFERENCES `tbl_users` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
