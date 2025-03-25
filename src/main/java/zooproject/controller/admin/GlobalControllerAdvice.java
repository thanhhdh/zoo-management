package zooproject.controller.admin;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ModelAttribute;
import zooproject.converter.FoodConverter;
import zooproject.converter.OrderConverter;
import zooproject.converter.QuestionConverter;
import zooproject.dto.FoodDTO;
import zooproject.dto.OrderDTO;
import zooproject.dto.QuestionDTO;
import zooproject.entity.FoodEntity;
import zooproject.entity.OrderEntity;
import zooproject.entity.QuestionEntity;
import zooproject.service.IOrderService;
import zooproject.service.impl.FoodService;
import zooproject.service.impl.QuestionService;

import java.util.List;
import java.util.stream.Collectors;

@ControllerAdvice
public class GlobalControllerAdvice {
    @Autowired
    private IOrderService orderService;

    @Autowired
    private QuestionService questionService;

    @Autowired
    private FoodService foodService;

    @Autowired
    private OrderConverter orderConverter;

    @Autowired
    private QuestionConverter questionConverter;

    @Autowired
    private FoodConverter foodConverter;

    @ModelAttribute("newOrders")
    public List<OrderDTO> provideNewOrders() {
        // Lấy danh sách các đơn hàng mới
        List<OrderEntity> newOrders = orderService.findNewOrders(OrderEntity.OrderStatus.PENDING);

        // Chuyển đổi sang DTO để gửi đến view
        return newOrders.stream()
                .map(orderConverter::toDto)
                .collect(Collectors.toList());
    }

    @ModelAttribute("newMessages")
    public List<QuestionDTO> provideNewMessages() {
        List<QuestionEntity> newMessages = questionService.findNewMessages();

        return newMessages.stream()
                .map(questionConverter::toDto)
                .collect(Collectors.toList());
    }

    @ModelAttribute("outOfStockFoods")
    public List<FoodDTO> provideOutOfStockFoods() {
        List<FoodEntity> outOfStockFoods = foodService.findLowStockFoods(5); // Thức ăn <= 5 được xem là sắp hết
        return outOfStockFoods.stream()
                .map(foodConverter::toDto)
                .collect(Collectors.toList());
    }



}
