import Foundation
import UIKit

final class UserAssembly {
    
    private var weatherService: WeatherService
    private var locationManager: LocationManager
    
    init(weatherService: WeatherService, locationManager: LocationManager) {
        self.weatherService = weatherService
        self.locationManager = locationManager
    }
    
    func assemble() -> UIViewController {
        
        let presenter = UserPresenter(weatherService: weatherService, locationManager: locationManager, dispatchQueue: DispatchQueue.main)
        let vc = UserViewController(presenter: presenter)
        let navigationVC = UINavigationController(rootViewController: vc)
        navigationVC.navigationBar.prefersLargeTitles = true
        presenter.view = vc
        return navigationVC
    }
}
