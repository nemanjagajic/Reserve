package app.controller;

import app.model.Comment;
import app.model.Restaurant;
import app.model.User;
import app.repository.CommentRepository;
import app.repository.RestaurantRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import javax.servlet.http.HttpServletRequest;
import java.util.Collections;
import java.util.List;

@Controller
@RequestMapping(value = "/comment")
public class CommentController {

    @Autowired
    private CommentRepository commentRepository;

    @Autowired
    private RestaurantRepository restaurantRepository;

    @RequestMapping(value = "/add", method = RequestMethod.POST)
    public String addComment(HttpServletRequest request) {
        User user = UserController.loggedUser;
        Restaurant restaurant = restaurantRepository.getByName(request.getParameter("restaurantName"));
        String comment = request.getParameter("comment");

        commentRepository.save(new Comment(comment, user, restaurant));
        List<Comment> comments = commentRepository.findAll();
        Collections.reverse(comments);
        request.getSession().setAttribute("comments", comments);
        return "redirect:/restaurants.jsp";
    }
}
