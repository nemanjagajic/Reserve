package app.repository;

import app.model.Reservation;
import app.model.Restaurant;
import app.model.User;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface ReservationRepository extends JpaRepository<Reservation, Integer> {
    void deleteAllByRestaurant(Restaurant restaurant);
    List<Reservation> findAllByUser(User u);
}
