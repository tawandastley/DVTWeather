//
//  WeatherManager.swift
//  DVTWeather
//
//  Created by tawanda chandiwana on 2021/12/18.
//

import Foundation
import CoreLocation

protocol WeatherDataModelManager {
    //protocol to handle all the sorted data and errors to the view controller
    
    func didUpdateWeather(_ weatherDataModel: WeatherDataModel)
    func didFailWithError(_ error: Error)
}
struct WeatherManager {
    var delegate: WeatherDataModelManager?
    
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
            
            
            // the Json file returns 8 weather objects for each a 24 hour day, so a day is represented by 7 (ie 8-1) index paths in the json object
             
            //CurrentDayValues
            let city = decodedData.city.name
            let id = decodedData.list[0].weather[0].id
            let minTemp = decodedData.list[0].main.temp_min
            let maxTemp = decodedData.list[0].main.temp_max
            let temp = decodedData.list[0].main.temp
            let description = decodedData.list[0].weather[0].description
           
            //DayOneValues
            let dayOneTemp = decodedData.list[0].main.temp_max
            let dayOneID = decodedData.list[0].weather[0].id
            let firstDay = decodedData.list[8].dt_txt
            print(firstDay)
            
            //Day Two Values
            let dayTwoTemp = decodedData.list[9].main.temp
            let dayTwoID = decodedData.list[9].weather[0].id
            let secondDay = decodedData.list[9].dt_txt
            
            //Day Three Values
            let dayThreeTemp = decodedData.list[18].main.temp
            let dayThreeID = decodedData.list[18].weather[0].id
            let thirdDay = decodedData.list[18].dt_txt
            
            //Day Four Values
            let dayFourTemp = decodedData.list[27].main.temp
            let dayFourID = decodedData.list[27].weather[0].id
            let fourthDay = decodedData.list[27].dt_txt
            
            //Day Two Values
            let dayFiveTemp = decodedData.list[35].main.temp
            let dayFiveID = decodedData.list[35].weather[0].id
            let fifthDay = decodedData.list[35].dt_txt
            
            
//
            let weatherModel = WeatherDataModel(city: city, temp: temp, minimumTemp: minTemp, maximumTemp: maxTemp, id: id, description: description, dayOneTemp: dayOneTemp, dayOneID: dayOneID, dayOneDate: firstDay, dayTwoTemp: dayTwoTemp, dayTwoID: dayTwoID, dayTwoDate: secondDay, dayThreeTemp: dayThreeTemp, dayThreeID: dayThreeID, dayThreeDate: thirdDay, dayFourTemp: dayFourTemp, dayFourID: dayFourID, dayFourDate: fourthDay, dayFiveTemp: dayFiveTemp, dayFiveID: dayFiveID, dayFiveDate: fifthDay)
            return weatherModel
            
        }
        catch {
            delegate?.didFailWithError(error)
            return nil
        }
    }
    
    
}
