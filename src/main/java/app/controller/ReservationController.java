package app.controller;

import app.model.Reservation;
import app.repository.ReservationRepository;
import app.repository.RestaurantRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import javax.servlet.http.HttpServletRequest;

@Controller
@RequestMapping(value = "/reservation")
public class ReservationController {

    @Autowired
    ReservationRepository reservationRepository;

    @Autowired
    RestaurantRepository restaurantRepository;

    @RequestMapping(value = "/add", method = RequestMethod.POST)
    public String add(HttpServletRequest request) {
        Reservation reservation = new Reservation(
                request.getParameter("time"),
                Integer.parseInt(request.getParameter("numberOfPersons")),
                Byte.parseByte("0"),
                UserController.loggedUser,
                restaurantRepository.getByName(request.getParameter("restaurantId"))
        );

        reservationRepository.save(reservation);
        return "redirect:/restaurants.jsp";
    }

}
