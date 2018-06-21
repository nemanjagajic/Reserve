package app.controller;

import app.model.Restaurant;
import app.repository.RestaurantRepository;
import org.apache.tomcat.util.http.fileupload.servlet.ServletFileUpload;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.List;

@Controller
@RequestMapping(value = "/restaurant")
public class RestaurantController {

    @Autowired
    RestaurantRepository restaurantRepository;

    private static final String IMAGE_FOLDER = "C:\\Users\\Lenovo\\Desktop\\IDEA workspace\\Reserve\\src\\main\\webapp\\resources\\imgs\\";

    @RequestMapping(value = "/getAll", method = RequestMethod.GET)
    public String getAll(Model m, HttpServletRequest request) {
        List<Restaurant> restaurants = restaurantRepository.findAll();
        request.getSession().setAttribute("restaurants", restaurants);
        return "redirect:/restaurants.jsp";
    }

    @RequestMapping(value = "/add", method = RequestMethod.POST)
    public String add(@RequestParam("file") MultipartFile file, Restaurant restaurant, HttpServletRequest request) {

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
        return "redirect:/adminPanel.jsp";
    }

}
