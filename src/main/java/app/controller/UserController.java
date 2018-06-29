package app.controller;

import app.model.Reservation;
import app.model.User;
import app.repository.ReservationRepository;
import app.repository.RestaurantRepository;
import app.repository.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.servlet.http.HttpServletRequest;
import java.util.List;

@Controller
@RequestMapping(value = "/user")
public class UserController {

    @Autowired
    private UserRepository userRepository;

    @Autowired
    private RestaurantRepository restaurantRepository;

    @Autowired
    private ReservationRepository reservationRepository;

    public static User loggedUser;

    @RequestMapping(value = "/register", method = RequestMethod.POST)
    public String register(User user, HttpServletRequest request, RedirectAttributes ra) {
        ra.addAttribute("register", true);
        // Check if username or email already exists
        if (userRepository.findByUsername(user.getUsername()) != null || userRepository.findByEmail(user.getEmail()) != null) {
            ra.addAttribute("successfullyRegistered", false);
        } else {
            User userToAdd = new User(
                    user.getUsername(),
                    user.getName(),
                    user.getLastName(),
                    user.getEmail(),
                    user.getPhone(),
                    user.getPassword(),
                    user.getRole()
            );
            if (userRepository.save(userToAdd) != null) {
                ra.addAttribute("successfullyRegistered", true);
            }
        }
        return "redirect:/index.jsp";
    }

    @RequestMapping(value = "/login", method = RequestMethod.POST)
    public String login(HttpServletRequest request, RedirectAttributes ra) {
        String username = request.getParameter("username");
        String password = request.getParameter("password");

        User user = userRepository.findByUsername(username);
        if (user == null) {
            ra.addAttribute("login", true);
            ra.addAttribute("loginFailed", 1); // 1 -> username not found
            request.getSession().setAttribute("username", username);
        } else if (!user.getPassword().equals(password)) {
            ra.addAttribute("login", true);
            ra.addAttribute("loginFailed", 2); // 2 -> incorrect password
            request.getSession().setAttribute("username", username);
        } else {
            request.getSession().setAttribute("successfullyLoggedIn", true);
            request.getSession().setAttribute("username", username);
            request.getSession().setAttribute("restaurants", restaurantRepository.findAll());
            if (user.getRole() != null && user.getRole().equals("admin")) {
                request.getSession().setAttribute("admin", true);
            }
            loggedUser = user;
            return "redirect:/restaurants.jsp";
        }
        return "redirect:/index.jsp";
    }

    @RequestMapping(value = "/logout", method = RequestMethod.GET)
    public String logout(HttpServletRequest request) {
        request.getSession().invalidate();
        loggedUser = null;
        return "redirect:/index.jsp";
    }

    @RequestMapping(value = "/getProfile", method = RequestMethod.GET)
    public String getProfile(HttpServletRequest request) {
        List<Reservation> myReservations = reservationRepository.findAllByUser(loggedUser);
        request.getSession().setAttribute("user", loggedUser);
        request.getSession().setAttribute("myReservations", myReservations);
        return "redirect:/profile.jsp";
    }
}
