//
//  MapAnnotation.swift
//  MapApplication
//
//  Created by macbook on 4/15/21.
//

import MapKit

class MapAnnotation: NSObject, MKAnnotation {

    static let identifier = "MapAnnotation"

    var title: String?
    var subtitle: String?
    var coordinate: CLLocationCoordinate2D

    init(title: String, subtitle: String, coordinate: CLLocationCoordinate2D) {
        self.title = title
        self.subtitle = subtitle
        self.coordinate = coordinate

    }

}
