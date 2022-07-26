//
//  DailyTableViewCell.swift
//  EldarWeatherApp
//
//  Created by Eldar Garbuzov on 26.07.22.
//

import UIKit

class DailyTableViewCell: UITableViewCell {
    
    let weatherIcon = UIImageView()
    
    var key = "DailyTableViewCell"
    var dayLabel = UILabel()
    var tempLabel = UILabel()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        dayLabel.text = ""
        tempLabel.text = ""
        contentView.addSubview(dayLabel)
        contentView.addSubview(tempLabel)
        contentView.addSubview(weatherIcon)
        
        dayLabel.snp.makeConstraints { make in
            make.height.equalTo(60)
            make.width.equalTo(120)
            make.left.equalToSuperview().inset(16)
            make.top.bottom.equalToSuperview().inset(2)
            
        }
        
        weatherIcon.snp.makeConstraints { make in
            make.height.equalTo(60)
            make.width.equalTo(60)
            make.left.equalTo(dayLabel.snp.right).inset(8)
            make.top.bottom.equalToSuperview().inset(2)
        }
        
        tempLabel.snp.makeConstraints { make in
            make.height.equalTo(60)
            make.width.equalTo(60)
            make.left.equalTo(weatherIcon.snp.right).inset(2)
            make.top.bottom.equalToSuperview().inset(2)
            
        }
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func update(date: DailyWeatherData) {
        guard let dt = date.dt, let temp = date.temp?.day, let icon = date.weather?.first?.icon else { return }
        let endpoint = Endpoint.getIcon(icon: "\(icon)")
        DispatchQueue.global(qos: .utility).async {
            guard let iconData = try? Data(contentsOf: endpoint.url) else { return }
            DispatchQueue.main.async {
                self.weatherIcon.image = UIImage(data: iconData)
            }
        }
        dayLabel.text = dt.updateDateFormat(dateFormat: .days)
            tempLabel.text = "\(Int(temp)) °C"
    }
    
}
