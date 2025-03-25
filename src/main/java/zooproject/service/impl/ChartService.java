package zooproject.service.impl;

import org.jfree.chart.ChartFactory;
import org.jfree.chart.ChartUtils;
import org.jfree.chart.JFreeChart;
import org.jfree.chart.plot.PlotOrientation;
import org.jfree.data.category.CategoryDataset;
import org.jfree.data.category.DefaultCategoryDataset;
import org.springframework.stereotype.Service;

import java.awt.*;
import java.awt.image.BufferedImage;
import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.util.Map;

@Service
public class ChartService {

    public byte[] createChart(Map<Long, Integer> foodQuantities) throws IOException {
        CategoryDataset dataset = createDataset(foodQuantities);
        JFreeChart chart = ChartFactory.createBarChart(
            "Food Consumption",  // Title
            "Food ID",           // X-Axis Label
            "Total Quantity",    // Y-Axis Label
            dataset,             // Dataset
            PlotOrientation.VERTICAL,
            true,                // Show legend
            true,                // Use tooltips
            false                // Configure chart to generate URLs
        );

        // Create an image of the chart
        BufferedImage chartImage = chart.createBufferedImage(800, 600, BufferedImage.TYPE_INT_RGB, null);
        ByteArrayOutputStream baos = new ByteArrayOutputStream();
        ChartUtils.writeBufferedImageAsPNG(baos, chartImage);
        return baos.toByteArray();
    }

    private CategoryDataset createDataset(Map<Long, Integer> foodQuantities) {
        DefaultCategoryDataset dataset = new DefaultCategoryDataset();

        for (Map.Entry<Long, Integer> entry : foodQuantities.entrySet()) {
            Long foodId = entry.getKey();
            Integer quantity = entry.getValue();
            dataset.addValue(quantity, "Food", "Food ID " + foodId);
        }

        return dataset;
    }
}

