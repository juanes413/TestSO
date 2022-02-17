//
//  OpenMapCountry.swift
//  TestSO
//
//  Created by Juan Esteban Pelaez on 16/02/22.
//
import CoreLocation
import MapKit
import UIKit

class OpenMapCountry {
    
    // If you are calling the coordinate from a Model, don't forgot to pass it in the function parenthesis.
    static func present(in viewController: UIViewController, lat: Double, lng: Double) {
        let actionSheet = UIAlertController(title: "Open Location", message: "Choose an app to open latlng", preferredStyle: .actionSheet)
        actionSheet.addAction(UIAlertAction(title: "Google Maps", style: .default, handler: { _ in
            // Pass the coordinate inside this URL
            if let url = URL(string: "comgooglemaps://?daddr=\(lat),\(lng)&directionsmode=driving&zoom=14&views=traffic") {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }
        }))
        actionSheet.addAction(UIAlertAction(title: "Apple Maps", style: .default, handler: { _ in
            // Pass the coordinate inside this URL
            if let url = URL(string: "maps://?ll=\(lat),\(lng)&z=6") {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }
        }))
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        viewController.present(actionSheet, animated: true, completion: nil)
    }
}

