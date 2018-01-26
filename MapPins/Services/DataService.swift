//
//  DataService.swift
//  MapPins
//
//  Created by Rex Kung on 1/15/18.
//  Copyright © 2018 Rex Kung. All rights reserved.
//

import Foundation
import Firebase
import MapKit

let DB_BASE = Database.database().reference()


class DataService {
    
    static let ds = DataService()
    
    // DB references
    private var _REF_BASE = DB_BASE
    private var _REF_LOCATIONS = DB_BASE.child("location")
    private var _REF_USERS = DB_BASE.child("users")
    private var _REF_USERLOC: DatabaseReference?
    
    var REF_BASE: DatabaseReference {
        return _REF_BASE
    }
    
    var REF_LOCATIONS: DatabaseReference {
        return _REF_LOCATIONS
    }
    
    var REF_USERS: DatabaseReference {
        return _REF_USERS
    }
    
    var REF_USERLOC: DatabaseReference {
        get {
            _REF_USERLOC = _REF_LOCATIONS.child(Auth.auth().currentUser!.uid)
            return _REF_USERLOC!
        }
    }
    
    func createFirebaseDBUser(uid: String, userData: Dictionary<String, String>) {
        REF_USERS.child(uid).updateChildValues(userData)
    }
    
    func createFirebaseLocationData(title: String, name: String, type: String, location: CLLocationCoordinate2D){
        let UID = Auth.auth().currentUser!.uid
        REF_LOCATIONS.child(UID).child(title).updateChildValues(["type": type])
        REF_LOCATIONS.child(UID).child(title).updateChildValues(["location": name])
        REF_LOCATIONS.child(UID).child(title).updateChildValues(["latitude": location.latitude])
        REF_LOCATIONS.child(UID).child(title).updateChildValues(["longitude": location.longitude])
    }
    
    
}

