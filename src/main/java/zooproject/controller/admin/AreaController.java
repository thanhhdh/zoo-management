package zooproject.controller.admin;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import zooproject.dto.AreaDTO;
import zooproject.service.IAreaService;

import javax.validation.Valid;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/admin/areas")
public class AreaController {
    @Autowired
    private IAreaService areaService;

    @GetMapping("/list")
    public String showListArea(Model model,
                               @RequestParam(name = "page", defaultValue = "1", required = true) int page,
                               @RequestParam(name = "limit", defaultValue = "5", required = true) int limit) {
        AreaDTO areaDTO = new AreaDTO();
        areaDTO.setPage(page);
        areaDTO.setLimit(limit);
        areaDTO.setTotalItem(areaService.getTotalItem());
        areaDTO.setTotalPage((int) Math.ceil((double) areaDTO.getTotalItem() / areaDTO.getLimit()));

        Pageable pageable = new PageRequest(page - 1, limit);
        areaDTO.setListResult(areaService.findAll(pageable));
        model.addAttribute("areas", areaDTO);
        return "admin/areas/list_area";
    }

    // UI add new area
    @GetMapping("/add")
    public String addAreaForm(Model model) {
        model.addAttribute("area", new AreaDTO());
        return "admin/areas/add_area";
    }

    // Save new area
    @PostMapping("/save")
    public String saveArea(@Valid @ModelAttribute("area") AreaDTO areaDTO,
                           RedirectAttributes redirectAttributes) {
        Map<String, Object> message = new HashMap<>();
        if (areaDTO != null) {
            if (areaDTO.getAreaStatus() == 0) {
                areaDTO.setAreaStatus(1); // Gán giá trị mặc định nếu chưa có
            }
            areaService.saveArea(areaDTO);
            message.put("message", "Thêm khu vực thành công!");
            message.put("type", "success");
        } else {
            message.put("message", "Thêm khu vực thất bại!");
            message.put("type", "error");
        }
        redirectAttributes.addFlashAttribute("message", message);
        return "redirect:/admin/areas/list";
    }

    @GetMapping("/update-status")
    public String updateStatus(@RequestParam("id") Long id,
                               RedirectAttributes redirectAttributes) {
        Map<String, Object> message = new HashMap<>();
        if(id != null) {
            message.put("message", "Cập nhật thành công!");
            message.put("type", "success");
            areaService.updateStatus(id);
        } else {
            message.put("message", "Không thành công");
            message.put("type", "error");
        }
        redirectAttributes.addFlashAttribute("message", message);
        return "redirect:/admin/areas/list";
    }

    // UI edit area
    @GetMapping("/edit")
    public String editAreaForm(@RequestParam("id") Long id, Model model) {
        AreaDTO areaDTO = areaService.findById(id);
        model.addAttribute("area", areaDTO);
        return "admin/areas/edit_area";
    }

    // Update area
    @PostMapping("/update")
    public String updateArea(@Valid @ModelAttribute("area") AreaDTO areaDTO,
                             RedirectAttributes redirectAttributes) {
        Map<String, Object> message = new HashMap<>();
        if (areaDTO != null) {
            areaService.updateArea(areaDTO);
            message.put("message", "Cập nhật khu vực thành công!");
            message.put("type", "success");
        } else {
            message.put("message", "Cập nhật khu vực thất bại!");
            message.put("type", "error");
        }
        redirectAttributes.addFlashAttribute("message", message);
        return "redirect:/admin/areas/list";
    }

    // Delete area
    @GetMapping("/delete")
    public String deleteArea(@RequestParam("id") Long id, RedirectAttributes redirectAttributes) {
        Map<String, Object> message = new HashMap<>();
        if (id != null) {
            areaService.deleteById(id);
            message.put("message", "Xóa khu vực thành công!");
            message.put("type", "success");
        } else {
            message.put("message", "Xóa khu vực thất bại!");
            message.put("type", "error");
        }
        redirectAttributes.addFlashAttribute("message", message);
        return "redirect:/admin/areas/list";
    }

}
