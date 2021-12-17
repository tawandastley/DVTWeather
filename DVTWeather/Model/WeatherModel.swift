//
//  WeatherModel.swift
//  DVTWeather
//
//  Created by tawanda chandiwana on 2021/12/17.
//

import Foundation
struct WeatherModel: Decodable {
    var isFavourite = false
    var list : [List]
}

struct List: Decodable{
   
    var main: Main
    var dt_txt: String
    var weather: [Weather]
}
struct Weather:Decodable {
    var main: String
}
struct Main: Decodable {
    var temp: Double
    var temp_min: Double
    var temp_max: Double
}
