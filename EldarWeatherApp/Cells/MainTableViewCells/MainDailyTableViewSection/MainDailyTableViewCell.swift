//
//  MainDailyTableViewCell.swift
//  EldarWeatherApp
//
//  Created by Eldar Garbuzov on 26.07.22.
//

import UIKit

class MainDailyTableViewCell: UITableViewCell {
    
    @IBOutlet weak var tableView: UITableView!
    var dailyWeather: [DailyWeatherData]?

    override func awakeFromNib() {
        super.awakeFromNib()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: DailyTableViewCell.key, bundle: nil), forCellReuseIdentifier: DailyTableViewCell.key)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func update(with date: [DailyWeatherData]) {
        self.dailyWeather = date
        self.tableView.reloadData()
    }

    
}

extension MainDailyTableViewCell: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dailyWeather?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: DailyTableViewCell.key, for: indexPath) as? DailyTableViewCell else { return UITableViewCell() }
        if let daily = dailyWeather {
            cell.update(date: daily[indexPath.row])
            return cell
        }
        return UITableViewCell()
    }
    
    
}
