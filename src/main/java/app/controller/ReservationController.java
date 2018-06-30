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
import java.util.ArrayList;
import java.util.Collections;
import java.util.LinkedList;
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
        Collections.reverse(reservations);
        request.getSession().setAttribute("reservations", reservations);
        ra.addAttribute("showReservations", true);
        return "redirect:/adminPanel.jsp";
    }

    @RequestMapping(value = "/getAllManagerTable", method = RequestMethod.GET)
    public String getAllManagerTable(HttpServletRequest request, RedirectAttributes ra) {
        List<Reservation> reservations = reservationRepository.findAllByRestaurant(UserController.loggedUser.getRestaurants().iterator().next());
        Collections.reverse(reservations);
        request.getSession().setAttribute("reservations", reservations);
        ra.addAttribute("showReservations", true);
        return "redirect:/managerPanel.jsp";
    }

    @RequestMapping(value = "/add", method = RequestMethod.POST)
    public String add(HttpServletRequest request, RedirectAttributes ra) {
        if (UserController.loggedUser != null) {
            Reservation reservation = new Reservation(
                    request.getParameter("time"),
                    Integer.parseInt(request.getParameter("numberOfPersons")),
                    Integer.parseInt("0"),
                    UserController.loggedUser,
                    restaurantRepository.getByName(request.getParameter("restaurantName"))
            );

            reservationRepository.save(reservation);
            return "redirect:/user/getProfile";
        }

        ra.addAttribute("login", true);
        return "redirect:/index.jsp";
    }

    @RequestMapping(value = "/delete", method = RequestMethod.POST)
    public String delete(HttpServletRequest request, RedirectAttributes ra) {
        reservationRepository.delete(Integer.parseInt(request.getParameter("reservationId")));
        ra.addAttribute("showReservations", true);
        List<Reservation> reservations;
        if (UserController.loggedUser.getRole().equals("admin")) {
            reservations = reservationRepository.findAll();
            Collections.reverse(reservations);
            request.getSession().setAttribute("reservations", reservations);
            return "redirect:/adminPanel.jsp";
        } else {
            reservations = reservationRepository.findAllByRestaurant(UserController.loggedUser.getRestaurants().iterator().next());
            Collections.reverse(reservations);
            request.getSession().setAttribute("reservations", reservations);
            return "redirect:/managerPanel.jsp";
        }
    }

    @RequestMapping(value = "/accept", method = RequestMethod.POST)
    public String accept(HttpServletRequest request, RedirectAttributes ra) {
        Reservation reservation = reservationRepository.findById(Integer.parseInt(request.getParameter("reservationId")));
        reservation.setAccepted(1);
        reservationRepository.save(reservation);
        List<Reservation> reservations = reservationRepository.findAllByRestaurant(UserController.loggedUser.getRestaurants().iterator().next());
        Collections.reverse(reservations);
        request.getSession().setAttribute("reservations", reservations);
        ra.addAttribute("showReservations", true);
        return "redirect:/managerPanel.jsp";
    }

    @RequestMapping(value = "/decline", method = RequestMethod.POST)
    public String decline(HttpServletRequest request, RedirectAttributes ra) {
        Reservation reservation = reservationRepository.findById(Integer.parseInt(request.getParameter("reservationId")));
        reservation.setAccepted(2);
        reservationRepository.save(reservation);
        List<Reservation> reservations = reservationRepository.findAllByRestaurant(UserController.loggedUser.getRestaurants().iterator().next());
        Collections.reverse(reservations);
        request.getSession().setAttribute("reservations", reservations);
        ra.addAttribute("showReservations", true);
        return "redirect:/managerPanel.jsp";
    }

}
