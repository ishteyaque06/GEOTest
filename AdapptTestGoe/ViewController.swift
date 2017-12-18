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
    @IBOutlet weak var mapView: MKMapView!
    override func viewDidLoad() {
        super.viewDidLoad()
        DB.sharedInstance.delegate=self
    }
}
extension ViewController:DatabaseUpdateDelegate{
    func databaseUpdate() {
        let annotations=DB.sharedInstance.getMapAnnotation()
        self.mapView.removeAnnotations(annotations)
        self.mapView.showAnnotations(annotations, animated: true)
    }
}


