//
//  BusinessViewModel.swift
//  hello-maps
//
//  Created by Cavit on 4.01.2019.
//  Copyright © 2019 Mohammad Azam. All rights reserved.
//

import Foundation
import MapKit

class BusinessViewModel :NSObject, MKAnnotation {
    
    var coordinate: CLLocationCoordinate2D
    var title: String?
    var rating: Double
    
    init(coordinate: CLLocationCoordinate2D, title: String, rating: Double){
        self.coordinate = coordinate
        self.title = title
        self.rating = rating
    }
}
