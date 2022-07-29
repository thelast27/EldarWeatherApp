//
//  MapViewController.swift
//  EldarWeatherApp
//
//  Created by Eldar Garbuzov on 29.07.22.
//

import UIKit
import GoogleMaps

class MapViewController: UIViewController {

    @IBOutlet weak var backgroundPic: UIImageView!
    @IBOutlet weak var viewForMap: UIView!
    @IBOutlet weak var nameOfPoint: UILabel!
    @IBOutlet weak var currentTemp: UILabel!
    
    var weatherManagerDelegte: RestAPIProviderProtocol = WeatherManager()
    var weatherParamsDelegate: CurrentAndForecastWeather?
    var realmManager: RealmDataBaseProtocol = RealmManager()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        backgroundPic.image = UIImage(named: "backgroundPic")
        let camera = GMSCameraPosition.camera(withLatitude: 54.029, longitude: 27.597, zoom: 5.0)
        let mapView = GMSMapView.map(withFrame: viewForMap.bounds, camera: camera)
        mapView.delegate = self
        viewForMap.addSubview(mapView)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
