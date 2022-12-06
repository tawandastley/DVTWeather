//
//  FavouritePlaces.swift
//  DVTWeather
//
//  Created by tawanda chandiwana on 2021/12/20.
//

import UIKit
import MapKit

class FavouritePlaces: NSObject, MKAnnotation {
    
    var coordinate: CLLocationCoordinate2D
    var title: String?
    
    init(coordinate: CLLocationCoordinate2D, title: String){
        self.coordinate = coordinate
        self.title = title
    }
    

}
