//
//  MainDailyTableViewCell.swift
//  EldarWeatherApp
//
//  Created by Eldar Garbuzov on 26.07.22.
//

import UIKit

class MainDailyTableViewCell: UITableViewCell {
    
    var dailyWeather: [DailyWeatherData]?
    
    @IBOutlet weak var dayLable: UILabel!
    
    @IBOutlet weak var weatherConditionImage: UIImageView!
    
    @IBOutlet weak var tempLable: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    
    func update(date: DailyWeatherData) {
        guard let dt = date.dt, let temp = date.temp?.day, let icon = date.weather?.first?.icon else { return }
        let endpoint = Endpoint.getIcon(icon: "\(icon)")
        DispatchQueue.global(qos: .utility).async {
            guard let iconData = try? Data(contentsOf: endpoint.url) else { return }
            DispatchQueue.main.async {
                self.weatherConditionImage.image = UIImage(data: iconData)
            }
        }
        dayLable.text = dt.updateDateFormat(dateFormat: .days)
        tempLable.text = "\(Int(temp)) °C"
        
    }
    
}
