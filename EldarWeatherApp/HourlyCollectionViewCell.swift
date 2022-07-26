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
    
    var summaryWeatherInfo = UILabel()
    var textWeatherDiscription = UILabel()
    

    override func awakeFromNib() {
        super.awakeFromNib()
        
        summaryWeatherInfo.text = ""
        summaryWeatherInfo.numberOfLines = 0
        contentView.addSubview(summaryWeatherInfo)
        textWeatherDiscription.text = ""
        textWeatherDiscription.numberOfLines = 0
        contentView.addSubview(textWeatherDiscription)
        contentView.addSubview(weatherIcon)
        
        summaryWeatherInfo.snp.makeConstraints { make in
            make.width.equalTo(50)
            make.height.equalTo(50)
            make.right.left.equalToSuperview().inset(16)
            make.top.equalToSuperview().inset(8)
        }
        
        weatherIcon.snp.makeConstraints { make in
            make.width.equalTo(50)
            make.height.equalTo(50)
            make.left.right.equalToSuperview().inset(16)
            make.top.equalTo(summaryWeatherInfo.snp.bottom).inset(16)
        }
        
        textWeatherDiscription.snp.makeConstraints { make in
            make.width.equalTo(50)
            make.height.equalTo(50)
            make.left.right.bottom.equalToSuperview().inset(16)
            make.top.equalTo(weatherIcon.snp.bottom).inset(16)
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
            self.summaryWeatherInfo.text = dt.updateDateFormat(dateFormat: .hours)
            self.textWeatherDiscription.text = "\(Int(temp))°C"
        }
    }
}
