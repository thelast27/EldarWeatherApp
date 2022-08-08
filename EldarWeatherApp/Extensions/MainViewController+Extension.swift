//
//  MainViewController+Extension.swift
//  EldarWeatherApp
//
//  Created by Eldar Garbuzov on 22.07.22.
//

import UIKit
import Foundation
import SnapKit

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 2 {
            return dailyWeather?.count ?? 0
        } else {
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "MainCurrentWeatherTableViewCell", for: indexPath) as? MainCurrentWeatherTableViewCell else { return UITableViewCell() }
            if let current = currentAndForecustedWeather {
                cell.update(date: current)
            }
            return cell
        } else if indexPath.section == 1 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "MainHourlyTableViewCell", for: indexPath) as? MainHourlyTableViewCell else { return UITableViewCell() }
            if let hourly = hourlyWeather {
                cell.update(with: hourly)
            }
            return cell
        } else if indexPath.section == 2 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "MainDailyTableViewCell", for: indexPath) as? MainDailyTableViewCell else { return UITableViewCell() }
            if let daily = dailyWeather {
                cell.update(date: daily[indexPath.row])
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
            return 80
        }
        return 150
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 0 {
            let headerView = UIView()
            headerView.snp.makeConstraints { make in
                make.width.equalTo(100)
                make.height.equalTo(0)
            }
            return headerView
        }
        let headerView = UIView()
        let label = UILabel()
        headerView.addSubview(label)
        label.snp.makeConstraints { make in
            make.top.equalTo(headerView.snp.top).inset(6)
            make.bottom.equalTo(headerView.snp.bottom).inset(6)
            make.leading.equalTo(headerView.snp.leading).inset(0)
            make.trailing.equalTo(headerView.snp.trailing).inset(0)
            make.width.equalTo(headerView.snp.width).inset(0)
  
        }
        label.font = .boldSystemFont(ofSize: 16)
        label.textColor = .gray
        headerView.addSubview(label)
        
        if section == 1 {
            label.text = "Weather forecast for 24h"
            return headerView
        } else if section == 2 {
            label.text = "Weather forecast for 7 days"
            return headerView
        }
        return UIView()
    }
    
}
