//
//  ViewController.swift
//  AdapptTestGoe
//
//  Created by Ahmed on 13/12/17.
//  Copyright © 2017 Ahmed. All rights reserved.
//

import UIKit
import MapKit
class ViewController: UIViewController {
   var annotation=[MKPointAnnotation]()
    @IBOutlet weak var mapView: MKMapView!
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(ViewController.newLocationFound(_:)), name: NSNotification.Name.LocationUpdated, object: nil)
    }
    
   @objc func newLocationFound(_ sender:Notification){
    let annotations=DB.sharedInstance.getMapAnnotation()
    self.mapView.removeAnnotations(annotations)
    self.mapView.showAnnotations(annotations, animated: true)
    }
        

}


