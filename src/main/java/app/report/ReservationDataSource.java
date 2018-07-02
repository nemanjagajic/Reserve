package app.report;

import app.model.Reservation;
import app.repository.ReservationRepository;
import net.sf.jasperreports.engine.JRDataSource;
import net.sf.jasperreports.engine.JRException;
import net.sf.jasperreports.engine.JasperReport;
import net.sf.jasperreports.engine.data.JRAbstractBeanDataSourceProvider;
import net.sf.jasperreports.engine.data.JRBeanCollectionDataSource;

import java.util.List;

public class ReservationDataSource extends JRAbstractBeanDataSourceProvider {

    private ReservationRepository reservationRepository;
    private List<Reservation> reservations;

    public ReservationDataSource(ReservationRepository restaurantRepository) {
        super(Reservation.class);
        this.reservationRepository = restaurantRepository;
    }

    @Override
    public JRDataSource create(JasperReport jasperReport) throws JRException {
        reservations = reservationRepository.findAll();
        return new JRBeanCollectionDataSource(reservations);
    }

    @Override
    public void dispose(JRDataSource jrDataSource) throws JRException {
        reservations = null;
    }
}
