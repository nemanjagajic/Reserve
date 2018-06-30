package app.repository;

import app.model.Reservation;
import app.model.Restaurant;
import app.model.User;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface ReservationRepository extends JpaRepository<Reservation, Integer> {
    void deleteAllByRestaurant(Restaurant restaurant);
    List<Reservation> findAllByUser(User u);
    List<Reservation> findAllByRestaurant(Restaurant r);
    Reservation findById(Integer id);
}
