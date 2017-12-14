//
//  Locationservices.swift
//  AdapptTestGoe
//
//  Created by Ahmed on 14/12/17.
//  Copyright © 2017 Ahmed. All rights reserved.
//

import Foundation
import CoreLocation

class LocationServices:NSObject{
    public static var sharedInstance:LocationServices?
    let locationManager: CLLocationManager!
    class func getInstances()->LocationServices{
        if sharedInstance==nil{
            sharedInstance=LocationServices()
        }
        return sharedInstance!
    }
    private override init() {
        locationManager = CLLocationManager()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
        locationManager.allowsBackgroundLocationUpdates=true
        super.init()
        locationManager.delegate = self
        DB.sharedInstance.createLocationTable()
    }
    func startUpdatingLocation(){
        locationManager.startMonitoringSignificantLocationChanges()
       //locationManager.startUpdatingLocation()
    }
    func stopUpdatingLocation(){
        locationManager.stopMonitoringSignificantLocationChanges()
        //locationManager.stopUpdatingLocation()
    }
}

extension LocationServices:CLLocationManagerDelegate{
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else {
            return
        }
        DB.sharedInstance.insertLocationCoordination(latitude: location.coordinate.latitude, longitute: location.coordinate.longitude)
    }
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        if let error = error as? CLError, error.code == .denied {
            manager.stopMonitoringSignificantLocationChanges()
           //manager.stopUpdatingLocation()
            return
        }
    }
}
