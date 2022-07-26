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
        
        guard let weatherViewContoller = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MainViewController") as? ViewController else {return}

        
        viewControllers = [addViewController(viewController: UINavigationController(rootViewController: weatherViewContoller), title: "Weather", image: UIImage(systemName: "cloud.sun.bolt"))]
        
        
    }
    
    private func addViewController(viewController: UIViewController, title: String, image: UIImage?) -> UIViewController {
        viewController.tabBarItem.title = title
        viewController.tabBarItem.image = image
        return viewController
        
    }

    

}
