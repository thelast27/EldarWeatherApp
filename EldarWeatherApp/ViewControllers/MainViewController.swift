//
//  ViewController.swift
//  EldarWeatherApp
//
//  Created by Eldar Garbuzov on 22.07.22.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var mainTableView: UITableView!
    
    var weatherManager: RestAPIProviderProtocol = WeatherManager()
    var currentAndForecustedWeather: CurrentAndForecastWeather?
    var hourlyWeather: [HourlyWeatherData]?
    var dailyWeather: [DailyWeatherData]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        weatherManager.getCoordinatesByName(forCity: "Dublin") { [weak self] weatherData in
            guard let self = self else { return }
            self.currentAndForecustedWeather = weatherData
            self.dailyWeather = weatherData.daily
            self.hourlyWeather = weatherData.hourly

            
            

            DispatchQueue.main.async {
                self.mainTableView.reloadData()
            }
          
        }
        

        mainTableView.register(UINib(nibName: "MainHourlyTableViewCell", bundle: nil), forCellReuseIdentifier: "MainHourlyTableViewCell")
        mainTableView.register(UINib(nibName: "MainDailyTableViewCell", bundle: nil), forCellReuseIdentifier: "MainDailyTableViewCell")
        
    }
    
    
}

