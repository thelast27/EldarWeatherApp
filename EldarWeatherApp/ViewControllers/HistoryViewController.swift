//
//  HistoryViewController.swift
//  EldarWeatherApp
//
//  Created by Eldar Garbuzov on 29.07.22.
//

import UIKit
import RealmSwift

class HistoryViewController: UIViewController {

    @IBOutlet weak var historyTableView: UITableView!
    @IBOutlet weak var backgroundPic: UIImageView!
    
    var resultsRealmData: Results<WeatherForRealm>!
    private var realmManager: RealmDataBaseProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        backgroundPic.image = UIImage(named: "backgroundPic")
        historyTableView.register(UINib(nibName: "HistoryTableViewCell", bundle: nil), forCellReuseIdentifier: "HistoryTableViewCell")
        
        realmManager = RealmManager()
        
        resultsRealmData = realmManager.getData().sorted(byKeyPath: "time", ascending: false)

        notificationToken = resultsRealmData.observe { [weak self] (changes: RealmCollectionChange) in
            guard let tableView = self?.historyTableView else { return }
            switch changes {
            case .initial:
                tableView.reloadData()
            case .update(_, let deletions, let insertions, let modifications):
                tableView.performBatchUpdates({
                    tableView.deleteRows(at: deletions.map({ IndexPath(row: $0, section: 0) }),
                                         with: .automatic)
                    tableView.insertRows(at: insertions.map({ IndexPath(row: $0, section: 0) }),
                                         with: .automatic)
                    tableView.reloadRows(at: modifications.map({ IndexPath(row: $0, section: 0) }),
                                         with: .automatic)
                })
            case .error(let error):
                fatalError("\(error)")
            }
        }
        historyTableView.reloadData()
        
    }
    
    deinit {
        notificationToken?.invalidate()
        
    }

}
