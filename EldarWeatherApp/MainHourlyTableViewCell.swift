//
//  MainHourlyTableViewCell.swift
//  EldarWeatherApp
//
//  Created by Eldar Garbuzov on 22.07.22.
//

import UIKit

class MainHourlyTableViewCell: UITableViewCell {
    @IBOutlet weak var collectionView: UICollectionView!
    var hourlyWeather: [HourlyWeatherData]?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UINib(nibName: HourlyCollectionViewCell.key, bundle: nil), forCellWithReuseIdentifier: HourlyCollectionViewCell.key)
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func update(with date: [HourlyWeatherData]) {
        self.hourlyWeather = date
        self.collectionView.reloadData()
    }
    
}

extension MainHourlyTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (hourlyWeather?.count ?? 0) - 23
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HourlyCollectionViewCell.key, for: indexPath) as? HourlyCollectionViewCell else { return
            UICollectionViewCell() }
        
        if let hourly = hourlyWeather {
            cell.update(date: hourly[indexPath.row])
            return cell
        }
        return UICollectionViewCell()
    }
}
