//
//  MainViewController+Extension.swift
//  EldarWeatherApp
//
//  Created by Eldar Garbuzov on 22.07.22.
//

import UIKit
import Foundation

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       if indexPath.section == 1 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "MainHourlyTableViewCell", for: indexPath) as? MainHourlyTableViewCell else { return UITableViewCell() }
            if let hourly = hourlyWeather {
                cell.update(with: hourly)
            }
            return cell
        }
        return UITableViewCell()
    }

func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    tableView.deselectRow(at: indexPath, animated: true)
}

func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    if indexPath.section == 0 {
        return 250
    } else if indexPath.section == 1 {
        return 150
    } else if indexPath.section == 2 {
        return 450
    }
    return 150
}
func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
    if section == 0 {
        return "Current weather"
    } else if section == 1 {
        return "Weather forecast for 24h"
    }
    return "Weather forecast for 7 days"
}
}
