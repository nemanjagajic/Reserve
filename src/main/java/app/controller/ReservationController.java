package app.controller;

import app.model.Reservation;
import app.repository.ReservationRepository;
import app.repository.RestaurantRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.servlet.http.HttpServletRequest;
import java.util.List;

@Controller
@RequestMapping(value = "/reservation")
public class ReservationController {

    @Autowired
    private ReservationRepository reservationRepository;

    @Autowired
    private RestaurantRepository restaurantRepository;

    @RequestMapping(value = "/getAllAdminTable", method = RequestMethod.GET)
    public String getAllAdminTable(HttpServletRequest request, RedirectAttributes ra) {
        List<Reservation> reservations = reservationRepository.findAll();
        request.getSession().setAttribute("reservations", reservations);
        ra.addAttribute("showReservations", true);
        return "redirect:/adminPanel.jsp";
    }

    @RequestMapping(value = "/add", method = RequestMethod.POST)
    public String add(HttpServletRequest request) {
        Reservation reservation = new Reservation(
                request.getParameter("time"),
                Integer.parseInt(request.getParameter("numberOfPersons")),
                Integer.parseInt("0"),
                UserController.loggedUser,
                restaurantRepository.getByName(request.getParameter("restaurantName"))
        );

        reservationRepository.save(reservation);
        return "redirect:/restaurants.jsp";
    }

    @RequestMapping(value = "/delete", method = RequestMethod.POST)
    public String delete(HttpServletRequest request, RedirectAttributes ra) {
        reservationRepository.delete(Integer.parseInt(request.getParameter("reservationId")));
        List<Reservation> reservations = reservationRepository.findAll();
        request.getSession().setAttribute("reservations", reservations);
        ra.addAttribute("showReservations", true);
        return "redirect:/adminPanel.jsp";
    }

}
