package app.repository;

import app.model.Comment;
import app.model.Restaurant;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface CommentRepository extends JpaRepository<Comment, Integer> {
    void deleteAllByRestaurant(Restaurant restaurant);
}
