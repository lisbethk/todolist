import Foundation
import UIKit

protocol DispatchQueueProtocol {
    func async(group: DispatchGroup?, qos: DispatchQoS, flags: DispatchWorkItemFlags, execute work: @escaping @convention(block) () -> Void)
}

extension DispatchQueueProtocol {
    func async(group: DispatchGroup? = nil, qos: DispatchQoS = .unspecified, flags: DispatchWorkItemFlags = [], execute work: @escaping @convention(block) () -> Void) {
        async(group: group, qos: qos, flags: flags, execute: work)
    }
}

protocol UserPresenterProtocol {
    func viewDidLoad()
}

final class UserPresenter: UserPresenterProtocol {
    private var locationManager: LocationManagerProtocol?
    var view: UserViewControllerProtocol?
//    private weak var output: UserPresenterOutput?
    private var weatherService: WeatherServiceProtocol?
    private var dispatchQueue: DispatchQueueProtocol

    init(weatherService: WeatherServiceProtocol, locationManager: LocationManagerProtocol, dispatchQueue: DispatchQueueProtocol) {
//        self.output = output
        self.dispatchQueue = dispatchQueue
        self.weatherService = weatherService
        self.locationManager = locationManager
    }
    
    func viewDidLoad() {
        view?.showLoader()
        
        locationManager?.getUserLocation(completion: { [weak self] location in
            self?.weatherService?.fetchWeather(lattitude: location.coordinate.latitude, longitude: location.coordinate.longitude ) { weather in
                let temperature = "Температура: \(weather.temperature) C"
                let windSpeed = "Скорость ветра: \(weather.windSpeed) м/c"
                let conditionString = weather.conditionString
                let condition = ConditionImage(condition: weather.condition)
                let image = UIImage(systemName: condition.imageName)
                let model = Model(image: image!, temperature: temperature, windSpeed: windSpeed, condition: "\(conditionString)", location: "Имя")
                
                self?.dispatchQueue.async {
                    self?.view?.hideLoader()
                    self?.view?.configure(with: model)
                }
            }

        })
        
    }
}

extension DispatchQueue: DispatchQueueProtocol {}
