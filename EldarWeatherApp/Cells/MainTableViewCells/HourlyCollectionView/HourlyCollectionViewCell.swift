//
//  HourlyCollectionViewCell.swift
//  EldarWeatherApp
//
//  Created by Eldar Garbuzov on 22.07.22.
//

import UIKit
import SnapKit

class HourlyCollectionViewCell: UICollectionViewCell {
    
    let weatherIcon = UIImageView()
    static let key = "HourlyCollectionViewCell"
    
    var dateLabel = UILabel()
    var tempLabel = UILabel()
    

    override func awakeFromNib() {
        super.awakeFromNib()
        
        dateLabel.text = ""
        dateLabel.numberOfLines = 0
        contentView.addSubview(dateLabel)
        tempLabel.text = ""
        tempLabel.numberOfLines = 0
        contentView.addSubview(tempLabel)
        contentView.addSubview(weatherIcon)
        
        dateLabel.snp.makeConstraints { make in
            make.right.left.equalToSuperview().inset(16)
            make.top.equalToSuperview().inset(5)
        }
        
        weatherIcon.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(16)
            make.top.equalTo(dateLabel.snp.bottom).inset(5)
        }
        
        tempLabel.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(16)
            make.bottom.equalToSuperview().inset(5)
            make.top.equalTo(weatherIcon.snp.bottom).inset(5)
        }
         
    } 
    
    func update(date: HourlyWeatherData) {
        if let dt = date.dt, let temp = date.temp, let icon = date.weather?.first?.icon {
            let endpoint = Endpoint.getIcon(icon: "\(icon)")
            DispatchQueue.global(qos: .utility).async {
                guard let iconData = try? Data(contentsOf: endpoint.url) else { return }
                DispatchQueue.main.async {
                    self.weatherIcon.image = UIImage(data: iconData)
                }
            }
            self.dateLabel.text = dt.updateDateFormat(dateFormat: .hours)
            self.tempLabel.text = "\(Int(temp))°C"
        }
    }
}
