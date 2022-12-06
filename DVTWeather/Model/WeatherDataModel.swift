//
//  WeatherDataModel.swift
//  DVTWeather
//
//  Created by tawanda chandiwana on 2021/12/18.
//

import Foundation
import UIKit

struct WeatherDataModel {
    
    func getCondition(of temperature: Int) -> String {
        switch temperature {
        case 200...321:
            return "partlysunny"
        case 500...531:
            return "rain"
        case 600...622:
            return "partlysunny"
        case 700...781:
            return "clear"
        case 800:
            return "clear"
        case 801...804:
            return "rain"
        default:
            return "partlysunny"
        }
    }
    
    func getString(of temperature: Double)-> String {
        let tempToString = String(format: "%.0f", temperature)
        return "\(tempToString)°"
    }
    
    func getBackgroundImage(of temperatureValue: Int) -> String {
        switch temperatureValue {
        case 200...321:
            return "sea_cloudy"
            
        case 500...531:
            
            return "sea_rainy"
        case 600...622:
            return "sea_cloudy"
        case 700...781:
            return "sea_sunnypng"
        case 800:
            return "sea_sunnypng"
        case 801...804:
            return "sea_cloudy"
        default:
            return "sea_rainy"
        }
    }
    
    func getHexValue(of temperatureValue: Int) -> String {
        switch temperatureValue {
        case 200...321:
            return "54717A"
            
        case 500...531:
            return "57575D"
            
        case 600...622:
            return "54717A"
        case 700...781:
            return "47AB2F"
        case 800:
            return "47AB2F"
        case 801...804:
            return "54717A"
        default:
            return "57575D"
        }
    }
    func hexStringToUIColor (hex:String) -> UIColor {
        var characterString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        if (characterString.hasPrefix("#")) {
            characterString.remove(at: characterString.startIndex)
        }
        
        if ((characterString.count) != 6) {
            return UIColor.gray
        }
        
        var rgbValue:UInt64 = 0
        Scanner(string: characterString).scanHexInt64(&rgbValue)
        
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
    
    func getDay(of dateString: String) -> String{
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale.current
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        
        let stringToDate = dateFormatter.date(from: dateString)!
        dateFormatter.dateFormat = "EEEE"
        let day = (dateFormatter.string(from: stringToDate))
        return day
    }
    
    
    //Current View Conditions
    let city: String
    let temp: Double
    let minimumTemp: Double
    let maximumTemp: Double
    let id: Int
    let description: String
    
    var condition: String {
        return getCondition(of: id)
    }
    var tempString: String{
        return getString(of: temp)
    }
    var minTempString: String{
        return getString(of: minimumTemp)
    }
    var maxTempString: String{
        return getString(of: maximumTemp)
    }
    
    var backgroundImage: String {
        getBackgroundImage(of: id)
        
    }
    var backgroundColor: String {
        getHexValue(of: id)
    }
    //
    
    //    //DAY ONE CONDITIONS//
    let dayOneTemp: Double
    let dayOneID: Int
    let dayOneDate: String
    
    var firstDay : String {
        return getDay(of: dayOneDate)
    }
    var dayOneTempString: String{
        return getString(of: dayOneTemp)
    }
    var dayOneSFSymbol: String {
        return getCondition(of: dayOneID)
    }
    
    
    //DAY TWO CONDITIONS
    let dayTwoTemp: Double
    let dayTwoID: Int
    let dayTwoDate: String
    
    var secondDay : String {
        return getDay(of: dayTwoDate)
    }
    var dayTwoTempString: String{
        return getString(of: dayTwoTemp)
    }
    var dayTwoSFSymbol: String {
        return getCondition(of: dayTwoID)
    }
    
    //DAY THREE CONDITIONS
    let dayThreeTemp: Double
    let dayThreeID: Int
    let dayThreeDate: String
    
    var thirdDay : String {
        return getDay(of: dayThreeDate)
    }
    var dayThreeTempString: String{
        return getString(of: dayThreeTemp)
    }
    var dayThreeSFSymbol: String {
        return getCondition(of: dayThreeID)
    }
    
    //DAY FOUR CONDITIONS
    let dayFourTemp: Double
    let dayFourID: Int
    let dayFourDate: String
    
    var fourthDate : String {
        return getDay(of: dayFourDate)
    }
    var dayFourTempString: String{
        return getString(of: dayFourTemp)
    }
    var dayFourSFSymbol: String {
        return getCondition(of: dayFourID)
    }
    
    //DAY FIVE CONDITIONS
    let dayFiveTemp: Double
    let dayFiveID: Int
    let dayFiveDate: String
    
    var fifthDay : String {
        return getDay(of: dayFiveDate)
    }
    var dayFiveTempString: String{
        return getString(of: dayFiveTemp)
    }
    var dayFiveSFSymbol: String {
        return getCondition(of: dayFiveID)
    }
    
    
}
