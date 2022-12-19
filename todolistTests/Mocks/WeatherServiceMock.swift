import Foundation
import CoreLocation
@testable import todolist


class WeatherServiceMock: WeatherServiceProtocol {
    var fetchWeatherWasCalled = false
    
    func fetchWeather(lattitude: CLLocationDegrees, longitude: CLLocationDegrees, completion: @escaping (todolist.Weather) -> Void) {
        fetchWeatherWasCalled = true
        completion(Weather(weatherData: weatherData(info: Info(url: "string"), fact: Fact(temp: 3, icon: "icon", condition: "condition", windSpeed: 3.5))))
    }
}
