import Foundation
import GoogleMaps

extension MapViewController: GMSMapViewDelegate {
    func mapView(_ mapView: GMSMapView, didTapAt coordinate: CLLocationCoordinate2D) {
        weatherManagerDelegte.getWeatherForCityCoordinates(long: coordinate.longitude, lat: coordinate.latitude, withLang: .english, withUnitsOfmeasurement: .celsius) { weatherData in
            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }
                guard let temp = weatherData.current?.temp,
                      let cityName = weatherData.timeZone
                else { return }
                self.nameOfPoint.isHidden = false
                self.currentTemp.isHidden = false
                self.currentTemp.text = "\(Int(temp))°"
                self.nameOfPoint.text = cityName
                self.realmManager.receiveData(data: weatherData)
            }
        }
    }
}
