//
//  LocationManager.swift
//  MapApplication
//
//  Created by macbook on 4/15/21.
//

import Foundation
import CoreLocation

class LocationManager: NSObject {

    typealias ListenerHandler = (CLLocation) -> Void

    static let sh = LocationManager()

    private lazy var locationManager: CLLocationManager = {
        let manager = CLLocationManager()
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyHundredMeters

        return manager
    }()

    var lastUserLocation: CLLocation? {
        didSet {
            self.sendLocationToListeners()
        }
    }

    private var locationListeneres: [ListenerHandler] = []

    private override init() {
        super.init()

        self.locationManager.requestWhenInUseAuthorization()
    }

    func getUserLocation(locationHandler: @escaping ListenerHandler) {

        switch self.locationManager.authorizationStatus {
        case .notDetermined:
            self.locationListeneres.append(locationHandler)
        case .authorizedWhenInUse, .authorizedAlways:
            self.locationManager.requestLocation()
            self.locationListeneres.append(locationHandler)
        default:
            locationHandler(CLLocation())
        }
    }

    private func sendLocationToListeners() {
        for location in self.locationListeneres {
            location(self.lastUserLocation ?? CLLocation())
        }
        self.locationListeneres = []
    }
}

extension LocationManager: CLLocationManagerDelegate {

    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        Swift.debugPrint(manager.authorizationStatus)

        let status = manager.authorizationStatus
        if  (status == .authorizedAlways || status == .authorizedWhenInUse),
            !self.locationListeneres.isEmpty {
            self.locationManager.requestLocation()
        } else if status == .denied {
            self.sendLocationToListeners()
        }
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            self.lastUserLocation = location
        }
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        Swift.debugPrint(error.localizedDescription)

        self.sendLocationToListeners()
    }
}
