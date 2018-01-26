//
//  MapLocation.swift
//  MapPins
//
//  Created by Rex Kung on 1/16/18.
//  Copyright © 2018 Rex Kung. All rights reserved.
//  Todo: Add in get/set for maplocation object so it can change after initial init func.

import Foundation
import MapKit

protocol LocationService {
    func InputLocation(locationInput: String, nameInput: String) -> CLLocationCoordinate2D
    func hideMenu()
    func showMenu()
}

class MapLocation: NSObject, MKAnnotation {
    
    let title: String?
    let locationName: String
    let locationType: String
    let coordinate: CLLocationCoordinate2D
    
    init(title: String, locationName: String, locationType: String, coordinate: CLLocationCoordinate2D) {
        self.title = title
        self.locationName = locationName
        self.locationType = locationType
        self.coordinate = coordinate
        
        super.init()
    }
    
    var subtitle: String? {
        return locationName
    }
}
