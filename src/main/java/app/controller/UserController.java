package app.controller;

import app.model.User;
import app.repository.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;
import java.util.List;

@Controller
@RequestMapping(value = "/user")
public class UserController {

    @Autowired
    UserRepository userRepository;

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
                    user.getPassword()
            );
            if (userRepository.save(userToAdd) != null) {
                ra.addAttribute("successfullyRegistered", true);
            }
        }
        return "redirect:/index.jsp";
    }

    @RequestMapping(value = "/login", method = RequestMethod.POST)
    public String login(Model m, HttpServletRequest request, RedirectAttributes ra) {
        String username = request.getParameter("username");
        String password = request.getParameter("password");

        User user = userRepository.findByUsername(username);
        if (user == null) {
            ra.addAttribute("login", true);
            ra.addAttribute("loginFailed", 1); // 1 -> username not found
        } else if (!user.getPassword().equals(password)) {
            ra.addAttribute("login", true);
            ra.addAttribute("loginFailed", 2); // 2 -> incorrect password
        }

        System.out.println("Successfully logged in as " + username + ", pass: " + password);
        return "redirect:/index.jsp";
    }
}
