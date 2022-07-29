//
//  MapViewController.swift
//  EldarWeatherApp
//
//  Created by Eldar Garbuzov on 29.07.22.
//

import UIKit
import GoogleMaps

class MapViewController: UIViewController {

    @IBOutlet weak var backgroundPic: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        backgroundPic.image = UIImage(named: "backgroundPic")
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
