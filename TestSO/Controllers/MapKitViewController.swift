//
//  MapKitViewController.swift
//  TestSO
//
//  Created by Juan Esteban Pelaez on 16/02/22.
//

import UIKit
import MapKit

class MapKitViewController: UIViewController {
    
    var lat: Double = 0.0
    var lng: Double = 0.0
    
    var mapView: MKMapView!
    
    override func loadView() {
        mapView = MKMapView(frame: .zero)
        view = mapView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let coordinate = CLLocationCoordinate2D(latitude: lat, longitude: lng)
        if let distance = CLLocationDistance(exactly: 1000000) {
            let region = MKCoordinateRegion(center: coordinate, latitudinalMeters: distance, longitudinalMeters: distance)
            mapView.setRegion(region, animated: true)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}
