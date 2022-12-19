import Foundation
import CoreLocation

protocol LocationManagerProtocol {
    func getUserLocation(completion: @escaping ((CLLocation) -> Void))
}

class LocationManager: NSObject, CLLocationManagerDelegate, LocationManagerProtocol {
    let manager = CLLocationManager()
    var completion: ((CLLocation) -> Void)?
    
    func getUserLocation(completion: @escaping ((CLLocation) -> Void)) {
        self.completion = completion
        manager.delegate =  self
        manager.desiredAccuracy = 100
        if manager.authorizationStatus == .notDetermined {
            manager.requestWhenInUseAuthorization()
        } else {
            manager.requestLocation()
        }
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        manager.requestLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.first else {
            return
        }
        completion!(location)
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error.localizedDescription)
    }
}

