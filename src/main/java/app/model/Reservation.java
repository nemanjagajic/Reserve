package app.model;

import javax.persistence.*;
import java.util.Objects;

@Entity
public class Reservation {
    private Integer id;
    private String time;
    private Integer numberOfPersons;
    private Byte accepted;
    private User user;
    private Restaurant restaurant;

    public Reservation() {

    }

    public Reservation(String time, Integer numberOfPersons, Byte accepted, User user, Restaurant restaurant) {
        this.time = time;
        this.numberOfPersons = numberOfPersons;
        this.accepted = accepted;
        this.user = user;
        this.restaurant = restaurant;
    }

    @Id
    @Column(name = "id")
    @GeneratedValue(strategy= GenerationType.IDENTITY)
    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    @Basic
    @Column(name = "time")
    public String getTime() {
        return time;
    }

    public void setTime(String time) {
        this.time = time;
    }

    @Basic
    @Column(name = "number_of_persons")
    public Integer getNumberOfPersons() {
        return numberOfPersons;
    }

    public void setNumberOfPersons(Integer numberOfPersons) {
        this.numberOfPersons = numberOfPersons;
    }

    @Basic
    @Column(name = "accepted")
    public Byte getAccepted() {
        return accepted;
    }

    public void setAccepted(Byte accepted) {
        this.accepted = accepted;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        Reservation that = (Reservation) o;
        return Objects.equals(id, that.id) &&
                Objects.equals(time, that.time) &&
                Objects.equals(numberOfPersons, that.numberOfPersons) &&
                Objects.equals(accepted, that.accepted);
    }

    @Override
    public int hashCode() {

        return Objects.hash(id, time, numberOfPersons, accepted);
    }

    @ManyToOne
    @JoinColumn(name = "user_id", referencedColumnName = "id", nullable = false)
    public User getUser() {
        return user;
    }

    public void setUser(User userByUserId) {
        this.user = userByUserId;
    }

    @ManyToOne
    @JoinColumn(name = "restaurant_id", referencedColumnName = "id", nullable = false)
    public Restaurant getRestaurant() {
        return restaurant;
    }

    public void setRestaurant(Restaurant restaurantByRestaurantId) {
        this.restaurant = restaurantByRestaurantId;
    }
}
