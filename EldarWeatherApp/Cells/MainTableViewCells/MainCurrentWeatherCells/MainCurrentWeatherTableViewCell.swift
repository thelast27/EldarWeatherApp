//
//  MainCurrentWeatherTableViewCell.swift
//  EldarWeatherApp
//
//  Created by Eldar Garbuzov on 26.07.22.
//

import UIKit

class MainCurrentWeatherTableViewCell: UITableViewCell {
    
    
    
    @IBOutlet weak var cityName: UILabel!
    @IBOutlet weak var currentTemp: UILabel!
    @IBOutlet weak var weatherDiscrip: UILabel!
    @IBOutlet weak var minTemp: UILabel!
    @IBOutlet weak var maxTemp: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.selectionStyle = .none
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func update(date: CurrentAndForecastWeather) {
        DispatchQueue.main.async {
            guard let temp = date.current?.temp,
                  let cityName = date.timeZone,
                  let description = date.current?.weather?.first?.description,
                  let todayMin = date.daily?.first?.temp?.min,
                  let todayMax = date.daily?.first?.temp?.max
            else { return }
            
            self.currentTemp.text = "\(Int(temp)) °"
            self.cityName.text = cityName
            self.weatherDiscrip.text = "Now \(description)"
            self.minTemp.text = "Min.:\(Int(todayMin))°,"
            self.maxTemp.text = "Max.:\(Int(todayMax))°"
        }
        
        
        
    }
}
