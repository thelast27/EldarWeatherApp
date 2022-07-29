//
//  HistoryTableViewCell.swift
//  EldarWeatherApp
//
//  Created by Eldar Garbuzov on 29.07.22.
//

import UIKit

class HistoryTableViewCell: UITableViewCell {

    
    @IBOutlet weak var coordinateLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var tempLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        backgroundColor = .lightGray
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configuration(data: WeatherForRealm) {
        guard let long = data.coordinate?.lon, let lat = data.coordinate?.lat else { return }
        self.coordinateLabel.text = "Long: \(long) : Lat: \(lat)"
        self.dateLabel.text = data.time.updateDateFormat(dateFormat: .fullTime)
        self.tempLabel.text = "Weather was \(Int(data.temp)) °C"
    }
    
}
