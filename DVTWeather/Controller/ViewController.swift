//
//  ViewController.swift
//  DVTWeather
//
//  Created by tawanda chandiwana on 2021/12/16.
//

import UIKit
import CoreLocation

class ViewController: UIViewController,CLLocationManagerDelegate, WeatherDataModelManager{
    
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
    
    @IBOutlet weak var weeklyView: UIView!
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

    var location  = [CLLocationDegrees]()
    
    override func viewDidLoad() {
        setUpServices()
        super.viewDidLoad()
        
    }
    
    func setUpServices() {
        weatherManager.delegate = self
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        guard let location = locationManager.location else { return }
        self.weatherManager.fetchWeather(
                    latitude: location.coordinate.latitude,
                    longitude: location.coordinate.longitude)
    }
    
    //MARK: Location Manager Delegates methods
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            self.weatherManager.fetchWeather(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        let alert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .actionSheet)
        let action = UIAlertAction(title: "", style: .default, handler: nil)
        alert.addAction(action)
    }
    
    func didFailWithError(_ error: Error) {
        let alert = UIAlertController(title: "error: \(error)!", message: "Error", preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .cancel) { (_) in
            self.navigationController?.popViewController(animated: true)
        }
        alert.addAction(action)
    }
    
    func didUpdateWeather(_ weatherDataModel: WeatherDataModel) {
        DispatchQueue.main.async {
            self.temperatureLabel.text = weatherDataModel.tempString
            self.currentTempLabel.text = weatherDataModel.maxTempString
            self.minTempLabel.text = weatherDataModel.minTempString
            self.maxTempLabel.text = weatherDataModel.maxTempString
            self.conditionLabel.text = weatherDataModel.description.uppercased()
            self.cityLabel.text = weatherDataModel.city
            
            self.dayOneTemp.text = weatherDataModel.dayOneTempString
            self.dayOneCondition.image = UIImage(named: weatherDataModel.dayOneSFSymbol)
            self.dayOneDate.text = "Today"
            
            self.dayTwoTemp.text = weatherDataModel.dayTwoTempString
            self.daytwoCondition.image = UIImage(named: weatherDataModel.dayTwoSFSymbol)
            self.dayTwoDate.text = "Tomorow"//weatherDataModel.firstDay
            
            self.dayThreeTemp.text = weatherDataModel.dayTwoTempString
            self.dayThreeCondition.image = UIImage(named: weatherDataModel.dayThreeSFSymbol)
            self.dayThreeDate.text = weatherDataModel.thirdDay
            
            self.dayFourTemp.text = weatherDataModel.dayFourTempString
            self.dayFourCondition.image = UIImage(named: weatherDataModel.dayFourSFSymbol)
            self.dayFourDate.text = weatherDataModel.fourthDate
            
            self.dayFiveTemp.text = weatherDataModel.dayFiveTempString
            self.dayFiveCondition.image = UIImage(named: weatherDataModel.dayFiveSFSymbol)
            self.dayFiveDate.text = weatherDataModel.fifthDay
            
            self.imageView.image = UIImage(named: weatherDataModel.backgroundImage)
            self.weeklyView.backgroundColor = weatherDataModel.hexStringToUIColor(hex: weatherDataModel.backgroundColor)
        }
    }
}
