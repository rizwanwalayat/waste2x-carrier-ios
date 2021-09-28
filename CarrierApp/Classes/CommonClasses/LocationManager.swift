//
//  LocationManager.swift
//  CarrierApp
//
//  Created by Phaedra Solutions  on 20/08/2021.
//  Copyright © 2021 codesrbit. All rights reserved.
//


import Foundation
import UIKit
import GoogleMaps

protocol LocationManagerDelegate {
    func headerUpdated(_ heading: CLHeading)
}

class LocationManager: NSObject, CLLocationManagerDelegate {
    
    
    /**************************************************/
    //MARK: Declarations.
    /**************************************************/
    
    // Swifty way of creating a singleton
    static let shared = LocationManager()
    
    // set the manager object right when it gets initialized
    let manager: CLLocationManager = {
        
        $0.desiredAccuracy = kCLLocationAccuracyBest
        $0.requestWhenInUseAuthorization()
        $0.distanceFilter  = 50
        $0.startUpdatingLocation()
        $0.pausesLocationUpdatesAutomatically = false
        
        return $0
    }(CLLocationManager())
    
    private(set) var currentLocation: CLLocationCoordinate2D!
    private(set) var currentHeading: CLHeading?
    var delegate : LocationManagerDelegate?

    var authorizationChangeHandler : ((CLAuthorizationStatus)->Void)?
    
    private override init() {
        super.init()
        // delegate MUST be set while initialization
        manager.delegate = self
    }
    
    func requestUserPermissionsAndStartUpdatingLocation()
    {
        self.manager.requestWhenInUseAuthorization()
        manager.startUpdatingLocation()
        manager.startUpdatingHeading()
    }
    /**************************************************/
    // MARK: Control Mechanisms
    /**************************************************/
    
    func startUpdatingLocation() {
        manager.startUpdatingLocation()
        manager.allowsBackgroundLocationUpdates = true
    }
    
    /**************************************************/
    
    func stopUpdatingLocation() {
        manager.stopUpdatingLocation()
        manager.allowsBackgroundLocationUpdates = false
    }
    
    /**************************************************/
    
    func startUpdatingHeading() {
        manager.startUpdatingHeading()
    }
    
    /**************************************************/
    
    func stopUpdatingHeading() {
        manager.stopUpdatingHeading()
    }
    
    /**************************************************/
    // MARK: Location Updates
    /**************************************************/
    
    func locationManager(_ manager: CLLocationManager,
                         didUpdateLocations locations: [CLLocation])
    {
        // If location data can be determined
        if let location = locations.last
        {
            currentLocation = location.coordinate
        }
    }
    
    /**************************************************/
    
    func locationManager(_ manager: CLLocationManager,
                         didFailWithError error: Error)
    {
        print("Location Manager Error: \(error)")
    }
    
    /**************************************************/
   
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        self.authorizationChangeHandler?(status)
    }
    
    /**************************************************/
    // MARK: Heading Updates
    /**************************************************/
    
    func locationManager(_ manager: CLLocationManager,
                         didUpdateHeading newHeading: CLHeading)
    {
        currentHeading = newHeading
        delegate?.headerUpdated(newHeading)
    }
    
    /**************************************************/
    
    func locationManagerShouldDisplayHeadingCalibration(_ manager: CLLocationManager) -> Bool {
        return true
    }
}
