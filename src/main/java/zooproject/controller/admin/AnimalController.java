package zooproject.controller.admin;

import java.io.File;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.commons.CommonsMultipartFile;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import zooproject.dto.AnimalDTO;
import zooproject.dto.CageDTO;
import zooproject.dto.FoodDTO;
import zooproject.dto.MedicalDTO;
import zooproject.dto.SpeciesDTO;
import zooproject.entity.CageEntity;
import zooproject.repository.CageRepository;
import zooproject.service.IAnimalService;
import zooproject.service.ICageService;
import zooproject.service.IFoodService;
import zooproject.service.IMedicalService;
import zooproject.service.ISpeciesService;

@Controller
public class AnimalController {

	private IAnimalService iAnimalService;
	private ISpeciesService iSpeciesService;
	private ICageService iCageService;
	private IFoodService iFoodService;
	private AnimalDTO animalDTO;
	private SpeciesDTO speciesDTO;
	private CageDTO cageDTO;
	private FoodDTO foodDTO;
	private MedicalDTO medicalDTO;
	private IMedicalService iMedicalService;

	@Autowired
	public AnimalController(IAnimalService iAnimalService, ISpeciesService iSpeciesService, ICageService iCageService,
			IFoodService iFoodService, AnimalDTO animalDTO, SpeciesDTO speciesDTO, CageDTO cageDTO,FoodDTO foodDTO,
			MedicalDTO medicalDTO, IMedicalService iMedicalService) {
		super();
		this.iAnimalService = iAnimalService;
		this.iSpeciesService = iSpeciesService;
		this.iCageService = iCageService;
		this.iFoodService = iFoodService;
		this.animalDTO = animalDTO;
		this.speciesDTO = speciesDTO;
		this.cageDTO = cageDTO;
		this.medicalDTO = medicalDTO;
		this.iMedicalService = iMedicalService;
		this.foodDTO = foodDTO;

	}

	// UI add info food
	@RequestMapping(value = "/admin/animal/add", method = RequestMethod.GET)
	public ModelAndView addAnimal() {
		ModelAndView modelAndView = new ModelAndView("admin/animal/add_animal");
		List<SpeciesDTO> speciesDTOs = iSpeciesService.findAll(null);
		List<CageDTO> cageDTOes = iCageService.findAll(null);
		List<FoodDTO> foodDTOs = iFoodService.findAll(null);
		

		modelAndView.addObject("species", speciesDTOs);
		modelAndView.addObject("cages", cageDTOes);
		modelAndView.addObject("foods", foodDTOs);

		return modelAndView;
	}

	// Save food
	@PostMapping("/admin/animal/add")
	public String saveAnimal(@Valid @ModelAttribute("animal") AnimalDTO animalDto, BindingResult br,
			@RequestParam(value = "specieId", required = false) Long specieId,
			@RequestParam(value = "cageId", required = false) Long cageId, HttpServletRequest request,
			@RequestParam(value = "foodId", required = false) Long foodId,
			@RequestParam(value = "image") CommonsMultipartFile commonsMultipartFiles,
			RedirectAttributes redirectAttributes) {
		
		Map<String, Object> message = new HashMap<>();
		// Lấy chuồng theo ID
        CageEntity cage = iCageService.findByCageId(cageId);

        if (cage != null) {
            // Đếm số lượng động vật trong chuồng
            Long animalCount = iCageService.countAnimalsInCage(cageId);

            // So sánh số lượng động vật với dung tích của chuồng
            if (animalCount != null && cage.getCageCapacity() != null) {
                if (animalCount >= cage.getCageCapacity()) {
                    // Nếu số lượng động vật vượt quá dung tích, cập nhật trạng thái của chuồng
                    cage.setCageStatus(0); // Giả sử 0 là trạng thái disabled
                    iCageService.updateCage(cageDTO);
                    message.put("message", "Chuồng đã đầy");
        			message.put("type", "error");
                }
            }
        }
		
		if (br.hasErrors()) {
			return "admin/animal/add_animal";
		}
		String nameFile = commonsMultipartFiles.getOriginalFilename();
		String nameFileNew = "";
		// Kiểm tra xem tên tệp có tồn tại không
		if (!"".equals(nameFile)) {
			// Bây giờ fullPath chứa đường dẫn hoàn chỉnh bạn muốn
			String dirFile = request.getServletContext().getRealPath("/") + "template" + File.separator + "web"
					+ File.separator + "img";
			System.out.println(dirFile);

			// Tạo một đối tượng File đại diện cho thư mục lưu trữ
			File fileDir = new File(dirFile + File.separator + "animal");
			// Nếu thư mục không tồn tại, tạo mới nó
			if (!fileDir.exists()) {
				fileDir.mkdirs();
			}
			// In ra đường dẫn đầy đủ của thư mục
			System.out.println("Đường dẫn đầy đủ của thư mục lưu trữ: " + fileDir.getAbsolutePath());
			try {
				String[] parts = nameFile.split("\\.");

				if (parts.length == 2) {
					String fileName = parts[0]; // Chuỗi trước dấu chấm
					String extension = parts[1]; // Chuỗi sau dấu chấm
					System.out.println("Tên tập tin: " + fileName);
					System.out.println("Phần mở rộng: " + extension);
					nameFileNew = fileName + System.currentTimeMillis() + "." + extension;
				} else {
					System.out.println("Chuỗi đầu vào không hợp lệ.");
					nameFileNew = nameFile;
				}

				// Lưu tệp được tải lên vào thư mục lưu trữ
				File newFile = new File(fileDir, nameFileNew);
				commonsMultipartFiles.transferTo(newFile);
				System.out.println("Upload file thành công!");
			} catch (Exception e) {
				System.out.println(e.getMessage());
				System.out.println("Upload file thất bại!");
			}
		}

		if (specieId != null) {
			System.out.println("Species: " + specieId + ", Cage: " + cageId + ", Food: " + foodId);

			speciesDTO.setId(specieId);
			cageDTO.setId(cageId);
			foodDTO.setFoodId(foodId);


			animalDto.setSpecies(speciesDTO);
			animalDto.setCage(cageDTO);
			animalDto.setFood(foodDTO);
			animalDto.setAnimalImage(nameFileNew);
			System.out.println("sssssssssdddd" + animalDto.getSpecies().getId());

			iAnimalService.insert(animalDto);
			message.put("message", "Dữ liệu đã được gửi thành công!");
			message.put("type", "success");
		} else {
			message.put("message", "Không thành công");
			message.put("type", "error");
		}
		redirectAttributes.addFlashAttribute("message", message);
		return "redirect:/admin/animal/add";
	}

	// UI Show info animal
	@RequestMapping(value = "/admin/animal/list", method = RequestMethod.GET)
	private ModelAndView showListAnimal(@RequestParam(name = "page", defaultValue = "1", required = true) int page,
			@RequestParam(name = "limit", defaultValue = "5", required = true) int limit,
			@RequestParam(name = "speciesId", required = false) Long speciesId,
			@RequestParam(name = "foodId", required = false) Long foodId,
			@RequestParam(name = "cageId", required = false) Long cageId) {
		ModelAndView modelAndView = new ModelAndView("admin/animal/list_animal");

		animalDTO.setPage(page);
		animalDTO.setLimit(limit);
		animalDTO.setTotalItem(iAnimalService.getTotalItem());
		animalDTO.setTotalPage((int) Math.ceil((double) animalDTO.getTotalItem() / animalDTO.getLimit()));

		Pageable pageable = new PageRequest(page - 1, limit);

		// Kiểm tra nếu speciesId khác null, lọc động vật theo loài
		if (speciesId != null) {
			animalDTO.setListResult(iAnimalService.findBySpeciesId(speciesId, pageable));
		} else if (cageId != null) {
			animalDTO.setListResult(iAnimalService.findByCageId(cageId, pageable));
		} else {
			animalDTO.setListResult(iAnimalService.findAll(pageable));
		}

		medicalDTO.setListResult(iMedicalService.findAll(null));
		foodDTO.setListResult(iFoodService.findAll(null));


		List<SpeciesDTO> speciesDTOs = iSpeciesService.findAll(null);
		List<CageDTO> cageDTOes = iCageService.findAll(null);
		List<FoodDTO> foodDTOes = iFoodService.findAll(null);


		modelAndView.addObject("species", speciesDTOs);
		modelAndView.addObject("cages", cageDTOes);
		modelAndView.addObject("food", foodDTOes);
		modelAndView.addObject("animal", animalDTO);
		modelAndView.addObject("medical", medicalDTO);
	
		return modelAndView;
	}

	// Detail animal
	@RequestMapping(value = "/admin/animal/detail", method = RequestMethod.GET)
	private ModelAndView detailAnimal(@RequestParam("id") Long id) {
		ModelAndView modelAndView = new ModelAndView("admin/animal/detail_animal");

		modelAndView.addObject("animal", iAnimalService.findByID(id));
		modelAndView.addObject("medical", iMedicalService.findById(id));
		return modelAndView;
	}

	// Code of hoangthanh
	@GetMapping("/admin/animal/update-status")
	public String updateStatus(@RequestParam(name = "animalId") Long animalId, RedirectAttributes redirectAttributes) {
		Map<String, Object> message = new HashMap<>();
		if (animalId != null) {
			message.put("message", "Cập nhật thành công!");
			message.put("type", "success");
			iAnimalService.updateStatus(animalId);
		} else {
			message.put("message", "Không thành công");
			message.put("type", "error");
		}
		redirectAttributes.addFlashAttribute("message", message);
		return "redirect:/admin/animal/list";
	}

	@GetMapping("/admin/animal/edit")
	public String editAnimal(@RequestParam(value = "animalId") Long animalId, Model model) {
		model.addAttribute("animal", iAnimalService.findByID(animalId));
		model.addAttribute("species", iSpeciesService.findAll(null));
		model.addAttribute("cages", iCageService.findAll(null));
		model.addAttribute("foods", iFoodService.findAll(null));
		return "admin/animal/edit_animal";
	}

	@PostMapping("admin/animal/update")
	public String updateAnimal(@ModelAttribute("animal") AnimalDTO animalDTO, RedirectAttributes redirectAttributes,
			@RequestParam(value = "specieId", required = false) Long specieId,
			@RequestParam(value = "cageId", required = false) Long cageId,
			@RequestParam(value = "foodId", required = false) Long foodId,
			HttpServletRequest request,
			@RequestParam(value = "image") CommonsMultipartFile commonsMultipartFiles) {
		Map<String, Object> message = new HashMap<>();
		String nameFile = commonsMultipartFiles.getOriginalFilename();
		String nameFileNew = "";
		if (!"".equals(nameFile)) {
			String dirFile = request.getServletContext().getRealPath("/") + "template" + File.separator + "web"
					+ File.separator + "img";
			File fileDir = new File(dirFile + File.separator + "animal");
			if (!fileDir.exists()) {
				fileDir.mkdirs();
			}

			try {
				String[] parts = nameFile.split("\\.");
				if (parts.length == 2) {
					String fileName = parts[0];
					String extension = parts[1];
					nameFileNew = fileName + System.currentTimeMillis() + "." + extension;
				} else {
					nameFileNew = nameFile;
				}
				File newFile = new File(fileDir, nameFileNew);
				commonsMultipartFiles.transferTo(newFile);
				System.out.println("Upload Thành công");
			} catch (Exception e) {
				System.out.println(e.getMessage());
				System.out.println("Upload Thất bại");
			}
		}
		if (specieId != null) {
			System.out.println("Species: " + specieId + ", Cage: " + cageId + ", Food: " + foodId);

			speciesDTO.setId(specieId);
			cageDTO.setId(cageId);
			foodDTO.setFoodId(foodId);

			animalDTO.setSpecies(speciesDTO);
			animalDTO.setCage(cageDTO);
			animalDTO.setFood(foodDTO);

			if (!"".equals(nameFile)) {
				animalDTO.setAnimalImage(nameFileNew);
			}

			iAnimalService.updateAnimal(animalDTO);
			message.put("message", "Dữ liệu đã được gửi thành công!");
			message.put("type", "success");
		} else {
			message.put("message", "Không thành công");
			message.put("type", "error");
		}
		redirectAttributes.addFlashAttribute("message", message);
		return "redirect:/admin/animal/list";
	}

	@GetMapping("/admin/animal/delete/{animalId}")
	public String deleteAnimal(@RequestParam(value = "animalId") Long animalId, RedirectAttributes redirectAttributes) {
		Map<String, Object> message = new HashMap<>();
		if (animalId != null) {

			iAnimalService.deleteById(animalId);
			message.put("message", "Xóa thành công!");
			message.put("type", "success");
		} else {
			message.put("message", "Không thành công");
			message.put("type", "error");
		}
		redirectAttributes.addFlashAttribute("message", message);
		return "redirect:/admin/animal/list";
	}

}
