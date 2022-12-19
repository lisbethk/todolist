import Foundation
import CoreLocation
@testable import todolist

class LocationManagerMock: LocationManagerProtocol {
    var gotUserLocation = false
    func getUserLocation(completion: @escaping ((CLLocation) -> Void)) {
        gotUserLocation = true
        completion(CLLocation())
    } 
}
