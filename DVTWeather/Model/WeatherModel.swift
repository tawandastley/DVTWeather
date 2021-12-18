//
//  WeatherModel.swift
//  DVTWeather
//
//  Created by tawanda chandiwana on 2021/12/17.
//

import Foundation
struct WeatherModel: Decodable {
    var isFavourite:Bool?
    var list : [List]
}

struct List: Decodable{
   
    let main: Main
    let dt_txt: String
    let weather: [Weather]
}
struct Weather:Decodable {
    let id: Int
    let description: String
}
struct Main: Decodable {
    let temp: Double
    let temp_min: Double
    let temp_max: Double
}
