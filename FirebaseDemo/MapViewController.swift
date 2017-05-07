//
//  MapViewController.swift
//  FirebaseDemo
//
//  Created by ibrahim zakarya on 4/29/17.
//  Copyright © 2017 chacha. All rights reserved.
//

import UIKit
import MapKit


class MapViewController: UIViewController, MKMapViewDelegate {

    var doctor: Doctor!
    
    @IBOutlet weak var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        mapView.delegate = self
        
        print(doctor.latitude)
        print(doctor.longitude)
        
        let latitude: CLLocationDegrees = doctor.latitude
        
        let longtiude: CLLocationDegrees = doctor.longitude
        
        let longDelta: CLLocationDegrees = 0.05
        
        let latDelta: CLLocationDegrees = 0.05
        
        let span = MKCoordinateSpan(latitudeDelta: latDelta, longitudeDelta: longDelta)
        
        let coordinates = CLLocationCoordinate2D(latitude: latitude, longitude: longtiude)
        
        let region = MKCoordinateRegion(center: coordinates, span: span)
        
        mapView.setRegion(region, animated: true)

        let annotation = MKPointAnnotation()
        
        annotation.title = "\(doctor.address)"
        
        annotation.coordinate = coordinates
        
        mapView.addAnnotation(annotation)
    
    
    
    }


    
    
    
    
    
}
