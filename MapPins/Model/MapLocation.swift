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

    private var _title: String?
    private var _locationType: String
    private var _locationName: String
    private var _coordinate: CLLocationCoordinate2D
    
    
    
    init(title: String, locationName: String, locationType: String, coordinate: CLLocationCoordinate2D) {
        self._title = title
        self._locationName = locationName
        self._locationType = locationType
        self._coordinate = coordinate
        
        super.init()
    }
    
    var subtitle: String? {
        return _locationName
    }
    
    var title: String? {
        get {
            return _title
        }
        set {
            _title = newValue
        }
    }
    
    var locationType: String {
        get {
            return _locationType
        }
        set {
            _locationType = newValue
        }
    }
    
    var locationName: String {
        get {
            return _locationName
        }
        set {
            _locationName = newValue
        }
    }
    
    var coordinate: CLLocationCoordinate2D {
        get {
            return _coordinate
        }
        set {
            _coordinate = newValue
        }
    }
    
    
}
