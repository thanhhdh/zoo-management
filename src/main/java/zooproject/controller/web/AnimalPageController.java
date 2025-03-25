package zooproject.controller.web;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import zooproject.service.IAnimalService;
import zooproject.service.IAreaService;
import zooproject.service.ISpeciesService;
import zooproject.service.impl.AreaService;

@Controller
public class AnimalPageController {

    private IAnimalService animalService;
    private IAreaService areaService;
    private ISpeciesService speciesService;

    @Autowired
    public AnimalPageController(
            IAnimalService animalService,
            IAreaService areaService,
            ISpeciesService speciesService
    ) {
        this.animalService = animalService;
        this.areaService = areaService;
        this.speciesService = speciesService;
    }

    @GetMapping("/dong-vat")
    public String animalPage(Model model) {
        model.addAttribute("animals", animalService.findAll(null));
        model.addAttribute("areas", areaService.findAll(null));
        model.addAttribute("species", speciesService.findAll(null));
        return "web/animal";
    }


}
