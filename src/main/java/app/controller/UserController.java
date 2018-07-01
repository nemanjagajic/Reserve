package app.controller;

import app.model.Comment;
import app.model.Reservation;
import app.model.User;
import app.repository.CommentRepository;
import app.repository.ReservationRepository;
import app.repository.RestaurantRepository;
import app.repository.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.servlet.http.HttpServletRequest;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.Collections;
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

    @Autowired
    private CommentRepository commentRepository;

    private static final String IMAGE_FOLDER = "C:\\Users\\Lenovo\\Desktop\\IDEA workspace\\Reserve\\src\\main\\webapp\\resources\\imgs\\";

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
                    user.getRole(),
                    "resources/imgs/default-user-image.png"
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
            List<Comment> comments = commentRepository.findAll();
            Collections.reverse(comments);
            request.getSession().setAttribute("comments", comments);
            if (user.getRole() != null && user.getRole().equals("admin")) {
                request.getSession().setAttribute("admin", true);
            }
            if (user.getRole() != null && user.getRole().equals("manager")) {
                request.getSession().setAttribute("manager", true);
                // Fetch the first managed restaurant (at this point, the only one)
                request.getSession().setAttribute("managedRestaurant", user.getRestaurants().iterator().next());
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
        Collections.reverse(myReservations);
        request.getSession().setAttribute("myReservations", myReservations);
        return "redirect:/profile.jsp";
    }

    @RequestMapping(value = "/update", method = RequestMethod.POST)
    public String update(@RequestParam("file") MultipartFile file, HttpServletRequest request) {
        loggedUser.setName(request.getParameter("name"));
        loggedUser.setLastName(request.getParameter("lastName"));
        loggedUser.setPhone(request.getParameter("phone"));
        loggedUser.setPassword(request.getParameter("password"));

        try {
            // Get the file and save it
            String fileName = file.getOriginalFilename();
            if (!fileName.equals("")) {
                byte[] bytes = file.getBytes();
                Path path = Paths.get(IMAGE_FOLDER + fileName);
                Files.write(path, bytes);
                loggedUser.setImage("resources/imgs/" + fileName);
            }
        } catch (IOException e) {
            e.printStackTrace();
        }

        userRepository.save(loggedUser);
        return "redirect:/profile.jsp";
    }
}
