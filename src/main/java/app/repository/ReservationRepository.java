package app.repository;

import app.model.Reservation;
import app.model.Restaurant;
import org.springframework.data.jpa.repository.JpaRepository;

public interface ReservationRepository extends JpaRepository<Reservation, Integer> {
    void deleteAllByRestaurant(Restaurant restaurant);
}
