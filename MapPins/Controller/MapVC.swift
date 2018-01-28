//
//  MapVC.swift
//  MapPins
//
//  Created by Rex Kung on 1/13/18.
//  Copyright © 2018 Rex Kung. All rights reserved.
//
//  Map Icon by Delwar Hossain from the Noun Project

import UIKit
import MapKit
import SwiftyJSON
import CoreLocation
import Firebase

class MapVC: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {

    @IBOutlet weak var screenCoverButton: UIButton!
    @IBOutlet weak var menuView: UIView!
    @IBOutlet weak var menuCurve: UIImageView!
    
    @IBOutlet weak var profileImg: UIImageView!
    @IBOutlet weak var homeButton: UIButton!
    @IBOutlet weak var dispAnnoButton: UIButton!
    @IBOutlet weak var hideAnnoButton: UIButton!
    @IBOutlet weak var searchButton: UIButton!
    @IBOutlet weak var dirWalkButton: UIButton!
    @IBOutlet weak var dirCarButton: UIButton!
    @IBOutlet weak var hideMenuButton: UIButton!
    @IBOutlet weak var centerMapBtn: UIButton!
    
    @IBOutlet weak var mapView: MKMapView!
    let locationManager = CLLocationManager()
    var mapLocs = [MapLocation]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        mapView.delegate = self
        locationManager.delegate = self
        
        
        //menuCurve.image = #imageLiteral(resourceName: "MenuCurve")
    
        hideMenu()
        
        mapView.userTrackingMode = MKUserTrackingMode.follow
        addMapTrackingButton()
        
        loadingAnnotations()
        
    
    }
    
    override func viewDidAppear(_ animated: Bool) {
        enableBasicLocationServices()
    }
    
    func enableBasicLocationServices() {
        switch CLLocationManager.authorizationStatus() {
        case .notDetermined:
            // Request when-in-use authorization initially
            locationManager.requestWhenInUseAuthorization()
            break
            
        case .restricted, .denied:
            // Disable location features
            
            break
            
        case .authorizedWhenInUse, .authorizedAlways:
            // Enable location features
            mapView.showsUserLocation = true
            break
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        
        /*if status == CLAuthorizationStatus.authorizedWhenInUse {
            mapView.showsUserLocation = true
        }*/
        
        switch status {
        case .restricted, .denied:
            
            break
            
        case .authorizedWhenInUse:
            mapView.showsUserLocation = true
            break
            
        case .notDetermined, .authorizedAlways:
            break
        }
    }
    
    func centerMapOnLocation(location: CLLocation) {
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate, 2000, 2000)
        
        mapView.setRegion(coordinateRegion, animated: true)
        
    }
    
    func addMapTrackingButton(){
        centerMapBtn.backgroundColor = .clear
        centerMapBtn.addTarget(self, action: #selector(MapVC.centerMapOnUserButtonClicked), for:.touchUpInside)

    }
    
    @objc func centerMapOnUserButtonClicked() {
        mapView.setUserTrackingMode(MKUserTrackingMode.follow, animated: true)
    }
    
    func mapView(_ mapView: MKMapView, didUpdate userLocation: MKUserLocation) {
        
        //if let loc = userLocation.location {
                //centerMapOnLocation(location: loc)
        //}
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        // 2
        guard let annotation = annotation as? MapLocation else { return nil }
        // 3
        let identifier = "marker"
        var view: MKMarkerAnnotationView
        // 4
        if let dequeuedView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)
            as? MKMarkerAnnotationView {
            dequeuedView.annotation = annotation
            view = dequeuedView
        } else {
            // 5
            view = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            view.canShowCallout = true
            view.calloutOffset = CGPoint(x: -5, y: 5)
            view.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
        }
        return view
    }

    @IBAction func menuBtnPressed(_ sender: Any) {
        showMenu()
    }
    
    @IBAction func hideMenuBtnPressed(_ sender: Any) {
        hideMenu()
    }
    
    @IBAction func screenCoverTapped(_ sender: UIButton) {
        hideMenu()
    }
    
    @IBAction func searchBtnPressed(_ sender: UIButton) {
        let sb = UIStoryboard(name: "reuse_popup", bundle: nil)
        let popup = sb.instantiateInitialViewController()! as! ReusePopup
        popup.delegate = self
        self.present(popup, animated: true)
    }
    
    @IBAction func displayAnnotations(_ sender: UIButton) {
        for _annotations in mapView.annotations{
            self.mapView.view(for: _annotations)?.isHidden = false
        }
        //self.loadingAnnotations()
        hideMenu()
    }
    
    @IBAction func hideAnnotations(_ sender: UIButton) {
        //print(mapLocs.count)
        for _annotations in mapView.annotations{
            self.mapView.view(for: _annotations)?.isHidden = true
        }
        //mapView.removeAnnotations(mapView.annotations)
        hideMenu()
    }
    
    
}

extension MapVC {
    
    func showMenu() {
        menuView.isHidden = false
        
        UIView.animate(withDuration: 0.7, animations: {
            self.screenCoverButton.alpha = 1
        })
        
        UIView.animate(withDuration: 0.5, delay: 0.06, options: .curveEaseOut, animations: {
            self.menuCurve.transform = .identity
        })
        UIView.animate(withDuration: 0.4, delay: 0, options: [.curveEaseOut, .allowUserInteraction], animations: {
            self.hideAnnoButton.transform = .identity
            self.searchButton.transform = .identity
        })
        
        UIView.animate(withDuration: 0.4, delay: 0.06, options: [.curveEaseOut, .allowUserInteraction], animations: {
            self.dispAnnoButton.transform = .identity
            self.dirWalkButton.transform = .identity
        })
        
        UIView.animate(withDuration: 0.4, delay: 0.12, options: [.curveEaseOut, .allowUserInteraction], animations: {
            self.homeButton.transform = .identity
            self.dirCarButton.transform = .identity
        })
        
        UIView.animate(withDuration: 0.4, delay: 0.18, options: [.curveEaseOut, .allowUserInteraction], animations: {
            self.profileImg.transform = .identity
            self.hideMenuButton.transform = .identity
        })
        
    }
    
    func hideMenu() {
        UIView.animate(withDuration: 0.7, animations: {
            self.screenCoverButton.alpha = 0
        })
        
        UIView.animate(withDuration: 0.4, delay: 0, options: [.curveEaseOut, .allowUserInteraction], animations: {
            self.profileImg.transform = CGAffineTransform(translationX: -self.menuView.frame.width, y: 0)
            self.hideMenuButton.transform = CGAffineTransform(translationX: -self.menuView.frame.width, y: 0)
        })
        
        UIView.animate(withDuration: 0.4, delay: 0.08, options: [.curveEaseOut, .allowUserInteraction], animations: {
            self.homeButton.transform = CGAffineTransform(translationX: -self.menuView.frame.width, y: 0)
            self.dirCarButton.transform = CGAffineTransform(translationX: -self.menuView.frame.width, y: 0)
        })
        
        UIView.animate(withDuration: 0.4, delay: 0.16, options: [.curveEaseOut, .allowUserInteraction], animations: {
            self.dispAnnoButton.transform = CGAffineTransform(translationX: -self.menuView.frame.width, y: 0)
            self.dirWalkButton.transform = CGAffineTransform(translationX: -self.menuView.frame.width, y: 0)
        })
        
        UIView.animate(withDuration: 0.5, delay: 0.08, options: .curveEaseOut, animations: {
            self.menuCurve.transform = CGAffineTransform(translationX: -self.menuCurve.frame.width, y: 0)
        })
        
        UIView.animate(withDuration: 0.4, delay: 0.21, options: [.curveEaseOut, .allowUserInteraction], animations: {
            self.hideAnnoButton.transform = CGAffineTransform(translationX: -self.menuView.frame.width, y: 0)
            self.searchButton.transform = CGAffineTransform(translationX: -self.menuView.frame.width, y: 0)
        }) { success in
            self.menuView.isHidden = true
        }
    }
}

extension MapVC: LocationService {
    func InputLocation(locationInput: String, nameInput: String) -> CLLocationCoordinate2D {
        
        let geoCoder = CLGeocoder()
        geoCoder.geocodeAddressString(locationInput) { (placemarks, error) in
            guard let placemarks = placemarks, let locationCoord = placemarks.first?.location
                else {
                    return
            }
            self.centerMapOnLocation(location: locationCoord)
            
            print("This is locationCoord: \(locationCoord.coordinate.latitude), \(locationCoord.coordinate.longitude)")
            let tempLoc = MapLocation(title: nameInput,
             locationName: nameInput,
             locationType: "Food",
             coordinate: CLLocationCoordinate2D(latitude: locationCoord.coordinate.latitude, longitude: locationCoord.coordinate.longitude))
            
            DataService.ds.createFirebaseLocationData(title: tempLoc.title!, name: tempLoc.locationName, type: tempLoc.locationType, location: tempLoc.coordinate)
            self.mapLocs.append(tempLoc)
            
            self.mapView.addAnnotation(tempLoc)
            
        }
        
        if let addyResults = mapLocs.last?.coordinate {
            return addyResults
        } else {
            return CLLocationCoordinate2D()
        }
        
        
    }
    
    func loadingAnnotations() {
        mapView.removeAnnotations(mapView.annotations)
        DataService.ds.REF_USERLOC.observe(.value, with: { (snapshot) in
            self.mapLocs = []
            
            if let snapshot = snapshot.children.allObjects as? [DataSnapshot] {
                
                for snap in snapshot {
                    
                    if let postDict = snap.value as? Dictionary<String, Any> {
                        
                        let keyTemp = snap.key
                        print(keyTemp)
                        
                        if let latTemp = postDict["latitude"] as? CLLocationDegrees {
                            print("I hit lat")
                            if let longTemp = postDict["longitude"] as? CLLocationDegrees {
                                print("I hit long")
                                if let typeTemp = postDict["type"] as? String {
                                    print("I hit type")
                                    let tempLoc = CLLocationCoordinate2D(latitude: latTemp, longitude: longTemp)
                                    
                                    let tempMap = MapLocation(title: keyTemp, locationName: keyTemp, locationType: typeTemp, coordinate: tempLoc)
                                    
                                    print("This is the map: \(String(describing: tempMap.title)), \(tempMap.locationName), \(tempMap.locationType), \(tempMap.coordinate.latitude), \(tempMap.coordinate.longitude)")
                                    self.mapLocs.append(tempMap)
                                    self.mapView.addAnnotation(tempMap)
                                    
                                }
                            }
                        }
                    }
                }
            }
            
        })
        
    }
    
    
}



