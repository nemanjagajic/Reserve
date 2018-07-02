package app.report;

import app.model.Restaurant;
import app.repository.RestaurantRepository;
import net.sf.jasperreports.engine.JRDataSource;
import net.sf.jasperreports.engine.JRException;
import net.sf.jasperreports.engine.JasperReport;
import net.sf.jasperreports.engine.data.JRAbstractBeanDataSourceProvider;
import net.sf.jasperreports.engine.data.JRBeanCollectionDataSource;

import java.util.List;

public class RestaurantDataSource extends JRAbstractBeanDataSourceProvider {

    private RestaurantRepository restaurantRepository;
    private List<Restaurant> restaurants;

    public RestaurantDataSource(RestaurantRepository restaurantRepository) {
        super(Restaurant.class);
        this.restaurantRepository = restaurantRepository;
    }

    @Override
    public JRDataSource create(JasperReport jasperReport) throws JRException {
        restaurants = restaurantRepository.findAll();
        return new JRBeanCollectionDataSource(restaurants);
    }

    @Override
    public void dispose(JRDataSource jrDataSource) throws JRException {
        restaurants = null;
    }
}
