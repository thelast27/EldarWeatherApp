//
//  ViewController.swift
//  EldarWeatherApp
//
//  Created by Eldar Garbuzov on 22.07.22.
//

import UIKit

class ViewController: UIViewController {
    
    let notificationCenter = UNUserNotificationCenter.current()
    
    @IBOutlet weak var mainTableView: UITableView!
    @IBOutlet weak var backgroundPic: UIImageView!
    
    var weatherManager: RestAPIProviderProtocol = WeatherManager()
    var currentAndForecustedWeather: CurrentAndForecastWeather?
    var hourlyWeather: [HourlyWeatherData]?
    var dailyWeather: [DailyWeatherData]?
    var realmManager: RealmDataBaseProtocol = RealmManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        backgroundPic.image = UIImage(named: "backgroundPic")
        
        weatherManager.getCoordinatesByName(forCity: "Dublin") { [weak self] weatherData in
            guard let self = self else { return }
            self.currentAndForecustedWeather = weatherData
            self.dailyWeather = weatherData.daily
            self.hourlyWeather = weatherData.hourly
            self.realmManager.receiveData(data: weatherData)
            guard let weather = self.hourlyWeather else { return }
            self.weatherForecast(hourlyWeather: weather)
            self.removeAllNotification()
            DispatchQueue.main.async {
                self.mainTableView.reloadData()
            }
        }
        
        mainTableView.register(UINib(nibName: "MainCurrentWeatherTableViewCell", bundle: nil), forCellReuseIdentifier: "MainCurrentWeatherTableViewCell")
        mainTableView.register(UINib(nibName: "MainHourlyTableViewCell", bundle: nil), forCellReuseIdentifier: "MainHourlyTableViewCell")
        mainTableView.register(UINib(nibName: "MainDailyTableViewCell", bundle: nil), forCellReuseIdentifier: "MainDailyTableViewCell")
        
    }
    
    func setLocalNotification(body: String, title: String, dateComponents: DateComponents) {
        notificationCenter.requestAuthorization(options: [.alert, .badge, .sound]) { [weak self] isAutorized, error in
            guard let self = self else { return }
            if isAutorized {
                let content = UNMutableNotificationContent()
                content.body = body
                content.title = title
                
                let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)
                let identifier = "identifier"
                let request = UNNotificationRequest(identifier: identifier, content: content, trigger: trigger)
                
                self.notificationCenter.add(request) { error in
                    if let error = error {
                        print(error)
                    }
                }
            } else if let error = error {
                print(error)
            }
        }
    }
    
    func getDateComponentsFrom(date: Int) -> DateComponents {
        let calendar = Calendar.current
        let newDate = Date(timeIntervalSince1970: TimeInterval(date))
        var newDateComponents = calendar.dateComponents([.year, .month, .day, .hour, .minute, .second], from: newDate)
        guard let minutes = newDateComponents.minute else { fatalError() }
        newDateComponents.minute = minutes - 30
        return newDateComponents
    }
    
    func weatherForecast(hourlyWeather: [HourlyWeatherData]) {
        for hour in hourlyWeather {
            guard let id = hour.weather?.first?.id, let time = hour.dt else { return }
            if id != 800 {
                switch id {
                case 200...232:
                    setLocalNotification(body: "Thunderstorm is coming", title: "Attantion", dateComponents: getDateComponentsFrom(date: time))
                case 500...531:
                    setLocalNotification(body: "Rain is coming", title: "Attantion", dateComponents: getDateComponentsFrom(date: time))
                case 600...622:
                    setLocalNotification(body: "Snow is coming", title: "Attantion", dateComponents: getDateComponentsFrom(date: time))
                default: break
                }
            }
        }
    }
    
    func removeAllNotification() {
        notificationCenter.removeAllPendingNotificationRequests()
    }
    
    
}

