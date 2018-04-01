//
//  ViewController.swift
//  Loop0
//
//  Created by Jordan Hoehne on 3/31/18.
//  Copyright © 2018 Jordan Hoehne. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController, CLLocationManagerDelegate {
    
    var coreLocationManager = CLLocationManager()
    
    var locationManager:LocationManager!
 
    @IBOutlet weak var locationinfo: UILabel!
    @IBOutlet weak var mapview: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        coreLocationManager.delegate = self
        
        locationManager = LocationManager.sharedInstance
        
        //User Authorization
        
        let authorizationCode = CLLocationManager.authorizationStatus()
        
        if authorizationCode == CLAuthorizationStatus.notDetermined && coreLocationManager.respondstoSelector("requestAlwaysAuthorization") ||
            coreLocationManager.respondesToSelector("requestWhenInUseAuthorization"){
            if Bundle.mainBundle().objectForInfoDictionaryKey("NSLocationAlwaysUsageDescription") != nil{
                coreLocationManager.requestAlwaysAuthorization()
            }else{
                print("No description provided")
            }
        }else{
                getLocation()
        }
        
    }
    
    func getLocation(){
        LocationManager.startUpdatingLocationWithCompletionHandler{ (latitude, longitude, status, verboseMessage, error)} -> () in
            self.displayLocation(CLLocation(latitude: latitude, longitude: longitude))
    }
}

func displayLocation(location:CLLocation){
    
    mapview.setRegion(MKCoordinateRegion(center: CLLocationCoordinate2DMake(location.coordinate.latitude, location.coordinate.longitude ), span: MKCoordinateSpanMake(0.05,0.05)),
        animated: true)
    
    let locationPinCoord = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
    let annotation = MKPointAnnotation()
    annotation.coordinate = locationPinCoord
    
    mapview.addAnnotation(annotation)
    mapview.showAnnotations([annotation], animated: true)
    
    locationManager.reverseGeocodeLocationWithCoordinates(location, onReverseGeocodingCompletionHandler: { (reverseGecodeInfo, placemark, error) -> Void in
    
        let address = reverseGecodeInfo?.objectForKey("formattedAddress") as! String
        self.locationinfo.text = address
    })
    
    
}

func locationManager(manager: CLLocationManager!, didChangeAuthorizationStatus status: CLAuthorizationStatus){
    if status != CLAuthorizationStatus.notDetermined || status != CLAuthorizationStatus.denied || status != CLAuthorizationStatus.restricted
    getLocation()
    }
}


    @IBAction func update(_ sender: Any) {
        getLocation()
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

