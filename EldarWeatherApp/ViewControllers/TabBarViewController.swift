//
//  TabBarViewController.swift
//  EldarWeatherApp
//
//  Created by Eldar Garbuzov on 26.07.22.
//

import UIKit

class TabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let weatherViewContoller = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MainViewController") as? ViewController, let mapVC = UIStoryboard(name: "MapViewController", bundle: nil).instantiateViewController(withIdentifier: "MapViewController") as? MapViewController, let historyVC = UIStoryboard(name: "HistoryViewController", bundle: nil).instantiateViewController(withIdentifier: "HistoryViewController") as? HistoryViewController else {return}

        
        viewControllers = [addViewController(viewController: UINavigationController(rootViewController: weatherViewContoller), title: "Weather", image: UIImage(systemName: "cloud.sun.bolt")), addViewController(viewController: UINavigationController(rootViewController: mapVC), title: "Map", image: UIImage(systemName: "map")), addViewController(viewController: UINavigationController(rootViewController: historyVC), title: "History", image: UIImage(systemName: "book"))]
        
        
    }
    
    private func addViewController(viewController: UIViewController, title: String, image: UIImage?) -> UIViewController {
        viewController.tabBarItem.title = title
        viewController.tabBarItem.image = image
        return viewController
        
    }

    

}
