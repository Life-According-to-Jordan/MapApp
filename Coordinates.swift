//this version of the swift code allows you to center the starting point of your app

//
//  ViewController.swift
//  Loop1
//
//  Created by Jordan Hoehne on 3/31/18.
//  Copyright © 2018 Jordan Hoehne. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation


class ViewController: UIViewController, CLLocationManagerDelegate {

    @IBOutlet weak var mapView: MKMapView!
    
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        
        let initialLocation = CLLocation(
            latitude: ENTER YOU STARTING VALUE HERE,
            longitude: ENTER YOU STARTING VALUE HERE)
        centerMapOnLocation(location: initialLocation)

    }

    let regionRadius: CLLocationDistance = 250
    func centerMapOnLocation(location: CLLocation) {
        
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate, regionRadius, regionRadius)
        
        mapView.setRegion(coordinateRegion, animated: true)
        
    }
}
