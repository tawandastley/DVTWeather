//
//  WeatherDataFormatTests.swift
//  DVTWeatherTests
//
//  Created by tawanda chandiwana on 2021/12/22.
//

import XCTest
@testable import DVTWeather

class WeatherDataFormatTests: XCTestCase {
    
    var weatherDatModel = WeatherDataModel(city: "Johannesburg", temp: 24.00, minimumTemp: 21.00, maximumTemp: 24.00, id: 500, description: "Scattered Clouds", dayOneTemp: 24.00, dayOneID: 500, dayOneDate: "2021-12-23 12:00:00", dayTwoTemp: 20.00, dayTwoID: 500, dayTwoDate: "2021-12-24 12:00:00", dayThreeTemp: 20.00, dayThreeID: 300, dayThreeDate: "2021-12-23 12:00:00", dayFourTemp: 16.00, dayFourID: 300, dayFourDate: "2021-12-25 12:00:00", dayFiveTemp: 15.00, dayFiveID: 500, dayFiveDate: "2021-12-26 12:00:00")
    
    func testDayFormat () {
       
        
        XCTAssertEqual(weatherDatModel.dayOneTempString, "24°")
        XCTAssertEqual(weatherDatModel.dayFiveTempString, "15°")
        XCTAssertEqual(weatherDatModel.getDay(of: "2021-12-25 12:00:00"), "Saturday")
        XCTAssertEqual(weatherDatModel.getDay(of: "2021-12-26 12:00:00"), "Sunday")
        
       
    }
    func testConditionStatus(){
        XCTAssertEqual(weatherDatModel.getCondition(of: 800), "clear")
        XCTAssertEqual(weatherDatModel.getCondition(of: 222), "partlysunny")
        XCTAssertEqual(weatherDatModel.getCondition(of: 512), "rain")
        XCTAssertEqual(weatherDatModel.getCondition(of: 610), "partlysunny")
        XCTAssertEqual(weatherDatModel.getCondition(of: 750), "clear")
        XCTAssertEqual(weatherDatModel.getCondition(of: 800), "clear")
        XCTAssertEqual(weatherDatModel.getCondition(of: 804), "rain")
        

        
    }
    func testBackGroundImage(){
        XCTAssertEqual(weatherDatModel.getBackgroundImage(of: 520), "sea_rainy")
        XCTAssertEqual(weatherDatModel.getBackgroundImage(of: 720), "sea_sunnypng")
        XCTAssertEqual(weatherDatModel.getBackgroundImage(of: 608), "sea_cloudy")
        XCTAssertEqual(weatherDatModel.getBackgroundImage(of: 220), "sea_cloudy")
        XCTAssertEqual(weatherDatModel.getBackgroundImage(of: 801), "sea_cloudy")
        XCTAssertEqual(weatherDatModel.getBackgroundImage(of: 800), "sea_sunnypng")
        XCTAssertEqual(weatherDatModel.getBackgroundImage(of: 300), "sea_cloudy")
        
    }
}
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


