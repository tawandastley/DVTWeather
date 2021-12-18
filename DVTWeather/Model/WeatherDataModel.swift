//
//  WeatherDataModel.swift
//  DVTWeather
//
//  Created by tawanda chandiwana on 2021/12/18.
//

import Foundation
struct WeatherDataModel {
    let temp: Double
    let minimumTemp: Double
    let maximumTemp: Double
    let id: Int
    let description: String

    var condition: String {
        switch id {
        case 200...232:
            return "cloud.bolt"
        case 300...321:
            return "cloud.drizzle"
        case 500...531:
            return "cloud.heavyrain"
        case 600...622:
            return "snowflake"
        case 700...781:
            return "sun.dust"
        case 800:
            return "sun.max"
        case 801...804:
            return "cloud.bolt"
        default:
            return "sun.max"
        }
    }
    
    var date: String
//    var dayOfTheWeek: Date {
//        let dateString = date
//        let dateFormatter = DateFormatter()
//        dateFormatter.dateFormat = "EEEE"
//        if  let dayOfTheWeekString = dateFormatter.date(from: dateString) {
//            
//        }
//        return dayOfTheWeekString
//        
//    }
    var tempString: String{
        let temperatureString = String(format: "%.0f", temp)
        return "\(temperatureString)°"
    }
    var minTempString: String{
        let minTemperatureString = String(format: "%.0f", minimumTemp)
        return "\(minTemperatureString)°"
    }
    var maxTempString: String{
        let maxTemperatureString = String(format: "%.0f", maximumTemp)
        return "\(maxTemperatureString)°"
    }
    
    
}
