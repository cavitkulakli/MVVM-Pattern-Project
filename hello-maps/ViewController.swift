//
//  ViewController.swift
//  hello-maps
//
//  Created by Cavit KULAKLI on 03.01.2019.
//  Copyright © 2018 Cavit KULAKLI. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate {
    
    @IBOutlet weak var mapView :MKMapView!
    private let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.mapView.delegate = self
        
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.distanceFilter = kCLDistanceFilterNone
        locationManager.startUpdatingLocation()
        
        self.mapView.showsUserLocation = true
    }
    
    @IBAction func showAddAddressView() {
        
        let alertVC = UIAlertController(title: "Enter Point of Interest", message: nil, preferredStyle: .alert)
        
        alertVC.addTextField { textField in
            
        }
        
        let okAction = UIAlertAction(title: "Ok", style: .default) { action in
            
            if let textField = alertVC.textFields?.first,
                let search = textField.text {
                
                self.findNearbyPOI(by :search)
                
            }
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { action in
            
        }
        
        alertVC.addAction(okAction)
        alertVC.addAction(cancelAction)
        
        self.present(alertVC, animated: true, completion: nil)
    }
    
    private func findNearbyPOI(by searchTerm :String) {
        
        let annotations = self.mapView.annotations
        self.mapView.removeAnnotations(annotations)
        
        let request = MKLocalSearch.Request() 
        request.naturalLanguageQuery = searchTerm
        request.region = self.mapView.region
        
        let search = MKLocalSearch(request: request)
        search.start { (response, error) in
            
            guard let response = response, error == nil else {
                return
            }
            
            for mapItem in response.mapItems {
                
                print(mapItem.name!)
                self.addPlacemarkToMap(placemark :mapItem.placemark)
            }
        }
    }
    
    // this function is used to add the placemark on the map
    private func addPlacemarkToMap(placemark :CLPlacemark) {
       
        
       
    }
    
    func mapView(_ mapView: MKMapView, didUpdate userLocation: MKUserLocation) {
        
        let region = MKCoordinateRegion(center: mapView.userLocation.coordinate, span: MKCoordinateSpan(latitudeDelta: 0.008, longitudeDelta: 0.008))
        
        mapView.setRegion(region, animated: true)
    }
    

}

