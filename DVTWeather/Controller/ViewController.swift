//
//  ViewController.swift
//  DVTWeather
//
//  Created by tawanda chandiwana on 2021/12/16.
//

import UIKit
import CoreLocation

class ViewController: UIViewController,CLLocationManagerDelegate, WeatherDataModelManager{
    func didFailWithError(_ error: Error) {
        print(error)
    }
    
    
   

    let locationManager = CLLocationManager()
    var weatherManager = WeatherManager()
    
    //info view outlets
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var conditionLabel: UILabel!
    
    //current view outlets
    
    @IBOutlet weak var minTempLabel: UILabel!
    @IBOutlet weak var maxTempLabel: UILabel!
    @IBOutlet weak var currentTempLabel: UILabel!
    
    //Weekly View Outlets
    
    
    @IBOutlet weak var dayOneDate: UILabel!
    @IBOutlet weak var dayOneTemp: UILabel!
    @IBOutlet weak var dayOneCondition: UIImageView!
    

    
    @IBOutlet weak var dayTwoDate: UILabel!
    @IBOutlet weak var daytwoCondition: UIImageView!
    @IBOutlet weak var dayTwoTemp: UILabel!
    @IBOutlet weak var dayThreeDate: UILabel!
    @IBOutlet weak var dayThreeCondition: UIImageView!
    @IBOutlet weak var dayThreeTemp: UILabel!
    @IBOutlet weak var dayFourCondition: UIImageView!
    @IBOutlet weak var dayFourDate: UILabel!
    @IBOutlet weak var dayFourTemp: UILabel!
    @IBOutlet weak var dayFiveDate: UILabel!
    @IBOutlet weak var dayFiveCondition: UIImageView!
    @IBOutlet weak var dayFiveTemp: UILabel!
    
    
    override func viewDidLoad() {
        weatherManager.delegate = self
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
      
        locationManager.startUpdatingLocation()
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            let lat = location.coordinate.latitude
            let long = location.coordinate.longitude
            
            self.weatherManager.fetchWeather(latitude: lat, longitude: long)
            
        }
    }
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
    
    func didUpdateWeather(_ weatherDataModel: WeatherDataModel) {
        DispatchQueue.main.async {
            self.temperatureLabel.text = weatherDataModel.tempString
            self.currentTempLabel.text = weatherDataModel.maxTempString
            self.minTempLabel.text = weatherDataModel.minTempString
            self.maxTempLabel.text = weatherDataModel.maxTempString
            self.conditionLabel.text = weatherDataModel.description.capitalized
            self.imageView.image = UIImage(named: "sea_cloudy")
        }
        
    }
    

}

