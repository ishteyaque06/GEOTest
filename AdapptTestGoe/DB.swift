//
//  DB.swift
//  AdapptTestGoe
//
//  Created by Ahmed on 14/12/17.
//  Copyright © 2017 Ahmed. All rights reserved.
//

import Foundation
import SQLite
import MapKit
let path = NSSearchPathForDirectoriesInDomains(
    .documentDirectory, .userDomainMask, true
    ).first!
extension Notification.Name{
     public static let LocationUpdated: NSNotification.Name = NSNotification.Name(rawValue: "LocationUpdated")
}

class DB:NSObject{
    var db : Connection? = nil
    static let sharedInstance=DB()
    let location = Table("Location")
    let lat = Expression<Double>("Latitude")
    let lngt = Expression<Double>("Longitute")
    func getInstance() -> DB {
        if db == nil{
        do {
            DB.sharedInstance.db = try Connection("\(path)/db.sqlite3")
        } catch  {
            print("Unable to make connection")
        }
        }
        return DB.sharedInstance
    }
    private override init() {}
    
    
    func createLocationTable(){
        do {
            try getInstance().db?.run(location.create(ifNotExists: true) { t in
                t.column(lat)
                t.column(lngt)
            })
        } catch  {
            print(error.localizedDescription)
        }
    }
    func insertLocationCoordination(latitude:Double,longitute:Double){
        do {
            try getInstance().db?.run(location.insert(lat <- latitude, lngt <- longitute))
            NotificationCenter.default.post(name: NSNotification.Name.LocationUpdated, object: nil)
            
        } catch  {
            print(error.localizedDescription)
        }
        
    }
    func getMapAnnotation()->[Annotation]{
        var locationAnnotation=[Annotation]()
        do {
            for item in try getInstance().db!.prepare(location) {
                    let annotation = Annotation(coordinate: CLLocationCoordinate2D(latitude: item[lat], longitude: item[lngt]))
                locationAnnotation.append(annotation)
                
            }
            
        } catch  {
            print(error.localizedDescription)
        }
        return locationAnnotation
    }
}

class Annotation: NSObject, MKAnnotation {
    let coordinate: CLLocationCoordinate2D
    init(coordinate: CLLocationCoordinate2D) {
        self.coordinate = coordinate
        super.init()
    }
}
