package app.controller;

import app.report.ReservationDataSource;
import app.report.RestaurantDataSource;
import app.repository.ReservationRepository;
import app.repository.RestaurantRepository;
import net.sf.jasperreports.engine.JRDataSource;
import net.sf.jasperreports.engine.JRException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
public class ReportController {

    private JRDataSource jrDataSource;

    @Autowired
    private RestaurantRepository restaurantRepository;

    @Autowired
    private ReservationRepository reservationRepository;

    @RequestMapping(value = "getAllRestaurantsReport", method = RequestMethod.GET)
	public String getAllRestaurantsReport(Model m) {
		RestaurantDataSource restaurantDataSource = new RestaurantDataSource(restaurantRepository);
		try {
			jrDataSource = restaurantDataSource.create(null);
		} catch (JRException jre) {
			System.out.println(jre.getMessage());
		}

		m.addAttribute("datasource", jrDataSource);
		return "C:\\Users\\Lenovo\\Desktop\\IDEA workspace\\Reserve\\src\\main\\java\\app\\jasperreports\\rpt_restaurants.jasper";
	}

	@RequestMapping(value = "getAllReservationsReport", method = RequestMethod.GET)
	public String getAllReservations(Model m) {
		ReservationDataSource reservationDataSource = new ReservationDataSource(reservationRepository);
		try {
			jrDataSource = reservationDataSource.create(null);
		} catch (JRException jre) {
			System.out.println(jre.getMessage());
		}

		return "C:\\Users\\Lenovo\\Desktop\\IDEA workspace\\Reserve\\src\\main\\java\\app\\jasperreports\\rpt_reservations.jasper";
	}
	
}
