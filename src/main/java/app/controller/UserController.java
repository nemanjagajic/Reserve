package app.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import javax.servlet.http.HttpServletRequest;

@Controller
@RequestMapping(value = "/user")
public class UserController {

    @RequestMapping(value = "/registerUser", method = RequestMethod.POST)
    public String registerUser(Model m, HttpServletRequest request) {
        System.out.println("HERE");
        return "redirect:/index.jsp";
    }
}
