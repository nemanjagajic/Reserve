package app.model;

import javax.persistence.*;
import java.util.Objects;

@Entity
public class Comment {
    private Integer id;
    private String comment;
    private User user;
    private Restaurant restaurant;

    public Comment() {
        // Empty constructor
    }

    public Comment(String comment, User user, Restaurant restaurant) {
        this.comment = comment;
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
    @Column(name = "comment")
    public String getComment() {
        return comment;
    }

    public void setComment(String comment) {
        this.comment = comment;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        Comment comment1 = (Comment) o;
        return Objects.equals(id, comment1.id) &&
                Objects.equals(comment, comment1.comment);
    }

    @Override
    public int hashCode() {

        return Objects.hash(id, comment);
    }

    @ManyToOne
    @JoinColumn(name = "user_id", referencedColumnName = "id")
    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }

    @ManyToOne
    @JoinColumn(name = "restaurant_id", referencedColumnName = "id")
    public Restaurant getRestaurant() {
        return restaurant;
    }

    public void setRestaurant(Restaurant restaurant) {
        this.restaurant = restaurant;
    }
}
