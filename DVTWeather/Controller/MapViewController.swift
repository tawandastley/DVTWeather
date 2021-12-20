//
//  MapViewController.swift
//  DVTWeather
//
//  Created by tawanda chandiwana on 2021/12/19.
//

import UIKit
import MapKit

class MapViewController: UIViewController, UITableViewDelegate, MKMapViewDelegate {

    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        mapView.delegate = self
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func favTapped(_ sender: UIBarButtonItem) {
        sender.tintColor = .yellow
        print("fav pressed")
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
    }
}
extension MapViewController : CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            var lat = location.coordinate.latitude
            var long = location.coordinate.longitude
        }
    }
    
}
