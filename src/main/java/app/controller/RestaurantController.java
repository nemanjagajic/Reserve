package app.controller;

import app.model.Restaurant;
import app.repository.RestaurantRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import javax.servlet.http.HttpServletRequest;
import java.util.List;

@Controller
public class RestaurantController {

    @Autowired
    RestaurantRepository restaurantRepository;

    @RequestMapping(value = "/getAllRestaurants", method = RequestMethod.GET)
    public String getAllRestaurants(Model m, HttpServletRequest request) {
        List<Restaurant> restaurants = restaurantRepository.findAll();
        request.getSession().setAttribute("restaurants", restaurants);
        return "redirect:/restaurants.jsp";
    }

}
