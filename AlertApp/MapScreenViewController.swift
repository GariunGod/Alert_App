//
//  MapScreenViewController.swift
//  AlertApp
//
//  Created by HGPMAC84 on 7/9/19.
//  Copyright © 2019 HGPMAC84. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation


class MapScreenViewController: UIViewController {

    
    @IBOutlet weak var mapView: MKMapView!
    
    
    let locationManager = CLLocationManager()
    let regionInMeaters: Double = 10000
    
    
    
    override func viewDidLoad() {
      
        super.viewDidLoad()
        checkLocationServices()
        let span: MKCoordinateSpan = MKCoordinateSpan(latitudeDelta: 0.3, longitudeDelta: 0.3)
        let location: CLLocationCoordinate2D = CLLocationCoordinate2DMake(37.802840, -122.257888)
        
        let region: MKCoordinateRegion = MKCoordinateRegion(center: location, span: span)
        mapView.setRegion(region, animated: true)
        
        let annotation = MKPointAnnotation()
        
        annotation.coordinate = location
        annotation.title = "Random Area"
        
        mapView.addAnnotation(annotation)

        // Do any additional setup after loading the view.
    }
    
    
    func setupLocationManager() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
    }
    
    func centerViewOnUserLocation() {
        if let location = locationManager.location?.coordinate {
            let region = MKCoordinateRegion.init(center: location, latitudinalMeters: regionInMeaters, longitudinalMeters: regionInMeaters)
            mapView.setRegion(region, animated: true)
        }
    }
    
    func checkLocationServices() {
        if CLLocationManager.locationServicesEnabled() {
            setupLocationManager()
            checkLocationAuthorization()
            locationManager.startUpdatingLocation()
        }else{
            //Show Alert To Turn On Location
        }
    }
    func checkLocationAuthorization() {
        switch CLLocationManager.authorizationStatus() {
        case .authorizedWhenInUse:
            mapView.showsUserLocation = true
            centerViewOnUserLocation()
            break
        case .denied:
            //Show Alert Instructing Them On How To Turn On Permissions
            break
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
            break
        case .restricted:
            //Show Alert letting Them Know Whats Up
            break
        case .authorizedAlways:
            break
        }
    }
}

extension MapScreenViewController: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        let center = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
        let region = MKCoordinateRegion.init(center: center, latitudinalMeters: regionInMeaters, longitudinalMeters: regionInMeaters)
        mapView.setRegion(region, animated: true)
    }
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        checkLocationAuthorization()
    }
    
    
    
    
}
