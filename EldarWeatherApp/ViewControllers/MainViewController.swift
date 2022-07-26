//
//  ViewController.swift
//  EldarWeatherApp
//
//  Created by Eldar Garbuzov on 22.07.22.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var mainTableView: UITableView!
    @IBOutlet weak var backgroundPic: UIImageView!
    
    var weatherManager: RestAPIProviderProtocol = WeatherManager()
    var currentAndForecustedWeather: CurrentAndForecastWeather?
    var hourlyWeather: [HourlyWeatherData]?
    var dailyWeather: [DailyWeatherData]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        backgroundPic.image = UIImage(named: "backgroundPic")
        
        weatherManager.getCoordinatesByName(forCity: "Dublin") { [weak self] weatherData in
            guard let self = self else { return }
            self.currentAndForecustedWeather = weatherData
            self.dailyWeather = weatherData.daily
            self.hourlyWeather = weatherData.hourly
            DispatchQueue.main.async {
                self.mainTableView.reloadData()
            }
        }
        
        mainTableView.register(UINib(nibName: "MainCurrentWeatherTableViewCell", bundle: nil), forCellReuseIdentifier: "MainCurrentWeatherTableViewCell")
        mainTableView.register(UINib(nibName: "MainHourlyTableViewCell", bundle: nil), forCellReuseIdentifier: "MainHourlyTableViewCell")
        mainTableView.register(UINib(nibName: "MainDailyTableViewCell", bundle: nil), forCellReuseIdentifier: "MainDailyTableViewCell")
        
    }
    
    
}

