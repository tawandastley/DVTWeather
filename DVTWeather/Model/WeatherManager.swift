//
//  WeatherManager.swift
//  DVTWeather
//
//  Created by tawanda chandiwana on 2021/12/18.
//

import Foundation
import CoreLocation

protocol WeatherDataModelManager {
    //protocol to handle all the sorted data to the view controller
    
    func didUpdateWeather(_ weatherDataModel: WeatherDataModel)
    func didFailWithError(_ error: Error)
}
struct WeatherManager {
    var delegate: WeatherDataModelManager?
    let url = ""
    func fetchWeather(latitude: CLLocationDegrees, longitude: CLLocationDegrees) {
        let url = "https://api.openweathermap.org/data/2.5/forecast?&appid=c7ded68caa59b0cb72bea6ae2d5a7893&units=metric&lat=\(latitude)&lon=\(longitude)"
        performRequest(with: url)
    }
    func performRequest (with url:  String ) { // function to fetch data from the web server
        if let url = URL(string: url) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    self.delegate?.didFailWithError(error!)
                    return
                }
                if let weatherData = data {
                    if let weather = self.parseData(weatherData) {
                        self.delegate?.didUpdateWeather(weather)
                    }
                }
                
            }
            task.resume()
        }
    }
    func parseData(_ weatherData: Data) -> WeatherDataModel?{ //function to convert the downloaded data into an optional WeatherDataModel object
        let decoder = JSONDecoder ()
        do {
          let decodedData =  try decoder.decode(WeatherModel.self, from: weatherData)
            let id = decodedData.list[0].weather[0].id
            let day = decodedData.list[0].dt_txt
            let temperature = decodedData.list[0].main.temp
            let minTemp = decodedData.list[0].main.temp_min
            let maxTemp = decodedData.list[0].main.temp_max
            let description = decodedData.list[0].weather[0].description
            let weatherModel = WeatherDataModel(temp: temperature, minimumTemp: minTemp, maximumTemp: maxTemp, id: id, description: description, date: day)
            print(weatherModel.description)
            print(weatherModel.tempString)
            
            return weatherModel
            
        }
        catch {
            delegate?.didFailWithError(error)
            return nil
        }
    }
    
    
}
