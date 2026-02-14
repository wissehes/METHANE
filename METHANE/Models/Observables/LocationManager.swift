//
//  LocationManager.swift
//  METHANE
//
//  Created by Wisse Hes on 12/02/2026.
//

import Foundation
import MapKit

@Observable
final class LocationManager: NSObject, CLLocationManagerDelegate {
    var location: CLLocation? = nil
    private let locationManager = CLLocationManager()
    
    override init() {
        super.init()

        locationManager.delegate = self
    }
    
    func requestUserAuthorization() {
        locationManager.requestWhenInUseAuthorization()
    }
    
    func startLocationUpdates() {
        locationManager.startUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        self.location = location
    }
    
}
