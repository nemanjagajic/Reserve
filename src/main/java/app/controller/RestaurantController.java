package app.controller;

import app.model.Restaurant;
import app.repository.ReservationRepository;
import app.repository.RestaurantRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.servlet.http.HttpServletRequest;
import javax.transaction.Transactional;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.List;

@Controller
@RequestMapping(value = "/restaurant")
@Transactional
public class RestaurantController {

    @Autowired
    private RestaurantRepository restaurantRepository;

    @Autowired
    private ReservationRepository reservationRepository;

    private static final String IMAGE_FOLDER = "C:\\Users\\Lenovo\\Desktop\\IDEA workspace\\Reserve\\src\\main\\webapp\\resources\\imgs\\";

    @RequestMapping(value = "/getAll", method = RequestMethod.GET)
    public String getAll(HttpServletRequest request) {
        List<Restaurant> restaurants = restaurantRepository.findAll();
        request.getSession().setAttribute("restaurants", restaurants);
        return "redirect:/restaurants.jsp";
    }

    @RequestMapping(value = "/getAllAdminTable", method = RequestMethod.GET)
    public String getAllAdminTable(HttpServletRequest request, RedirectAttributes ra) {
        List<Restaurant> restaurants = restaurantRepository.findAll();
        request.getSession().setAttribute("restaurants", restaurants);
        ra.addAttribute("showTable", true);
        return "redirect:/adminPanel.jsp?";
    }

    @RequestMapping(value = "/add", method = RequestMethod.POST)
    public String add(@RequestParam("file") MultipartFile file, Restaurant restaurant, RedirectAttributes ra) {

        try {
            // Get the file and save it
            String fileName = file.getOriginalFilename();
            if (!fileName.equals("")) {
                byte[] bytes = file.getBytes();
                Path path = Paths.get(IMAGE_FOLDER + fileName);
                Files.write(path, bytes);
                restaurant.setImage("resources/imgs/" + fileName);
            } else {
                restaurant.setImage("resources/imgs/no_image_available.jpeg");
            }
        } catch (IOException e) {
            e.printStackTrace();
        }

        Restaurant restaurantAdded = restaurantRepository.save(restaurant);
        if (restaurantAdded != null) {
            ra.addAttribute("successfullyAddedRestaurant", true);
        } else {
            ra.addAttribute("successfullyAddedRestaurant", false);
        }

        return "redirect:/adminPanel.jsp";
    }

    @RequestMapping(value = "/delete", method = RequestMethod.POST)
    public String delete(HttpServletRequest request, RedirectAttributes ra) {
        reservationRepository.deleteAllByRestaurant(restaurantRepository.getById(Integer.parseInt(request.getParameter("restaurantId"))));
        restaurantRepository.delete(Integer.parseInt(request.getParameter("restaurantId")));
        List<Restaurant> restaurants = restaurantRepository.findAll();
        request.getSession().setAttribute("restaurants", restaurants);
        ra.addAttribute("showTable", true);
        return "redirect:/adminPanel.jsp";
    }

}
