package app.repository;

import app.model.Restaurant;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface RestaurantRepository extends JpaRepository<Restaurant, Integer> {
    Restaurant getByName(String name);
    Restaurant getById(Integer id);
}
