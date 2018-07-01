package app.model;

import javax.persistence.*;
import java.util.Collection;
import java.util.Objects;

@Entity
public class Restaurant {
    private Integer id;
    private String name;
    private String location;
    private String workingHours;
    private String number;
    private Integer stars;
    private String about;
    private Byte promoCode;
    private String additionalLabel;
    private String image;
    private Collection<Reservation> reservations;
    private User manager;
    private Collection<Comment> comments;

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
    @Column(name = "name")
    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    @Basic
    @Column(name = "location")
    public String getLocation() {
        return location;
    }

    public void setLocation(String location) {
        this.location = location;
    }

    @Basic
    @Column(name = "working_hours")
    public String getWorkingHours() {
        return workingHours;
    }

    public void setWorkingHours(String workingHours) {
        this.workingHours = workingHours;
    }

    @Basic
    @Column(name = "number")
    public String getNumber() {
        return number;
    }

    public void setNumber(String number) {
        this.number = number;
    }

    @Basic
    @Column(name = "stars")
    public Integer getStars() {
        return stars;
    }

    public void setStars(Integer stars) {
        this.stars = stars;
    }

    @Basic
    @Column(name = "about")
    public String getAbout() {
        return about;
    }

    public void setAbout(String about) {
        this.about = about;
    }

    @Basic
    @Column(name = "promo_code")
    public Byte getPromoCode() {
        return promoCode;
    }

    public void setPromoCode(Byte promoCode) {
        this.promoCode = promoCode;
    }

    @Basic
    @Column(name = "additional_label")
    public String getAdditionalLabel() {
        return additionalLabel;
    }

    public void setAdditionalLabel(String additionalLabel) {
        this.additionalLabel = additionalLabel;
    }

    @Basic
    @Column(name = "image")
    public String getImage() {
        return image;
    }

    public void setImage(String image) {
        this.image = image;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        Restaurant that = (Restaurant) o;
        return Objects.equals(id, that.id) &&
                Objects.equals(name, that.name) &&
                Objects.equals(location, that.location) &&
                Objects.equals(workingHours, that.workingHours) &&
                Objects.equals(number, that.number) &&
                Objects.equals(stars, that.stars) &&
                Objects.equals(about, that.about) &&
                Objects.equals(promoCode, that.promoCode) &&
                Objects.equals(additionalLabel, that.additionalLabel) &&
                Objects.equals(image, that.image);
    }

    @Override
    public int hashCode() {

        return Objects.hash(id, name, location, workingHours, number, stars, about, promoCode, additionalLabel, image);
    }

    @Override
    public String toString() {
        return "Restaurant{" +
                "id=" + id +
                ", name='" + name + '\'' +
                ", location='" + location + '\'' +
                ", workingHours='" + workingHours + '\'' +
                ", number='" + number + '\'' +
                ", stars=" + stars +
                ", about='" + about + '\'' +
                ", promoCode=" + promoCode +
                ", additionalLabel='" + additionalLabel + '\'' +
                ", image='" + image + '\'' +
                '}';
    }

    @OneToMany(mappedBy = "restaurant")
    public Collection<Reservation> getReservations() {
        return reservations;
    }

    public void setReservations(Collection<Reservation> reservationsById) {
        this.reservations = reservationsById;
    }

    @ManyToOne
    @JoinColumn(name = "manager_id", referencedColumnName = "id")
    public User getManager() {
        return manager;
    }

    public void setManager(User manager) {
        this.manager = manager;
    }

    @OneToMany(mappedBy = "restaurant")
    public Collection<Comment> getComments() {
        return comments;
    }

    public void setComments(Collection<Comment> comments) {
        this.comments = comments;
    }
}
