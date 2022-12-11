import Foundation

struct NetworkService {
    
    func fetchWeather(completion: @escaping (Weather) -> Void) {
        let urlString = "https://api.weather.yandex.ru/v2/forecast?lat=53.234523&lon=50.201535"
        
        guard let url = URL(string: urlString) else { return }
        
        var request = URLRequest(url: url)
        request.addValue("667cd4c5-2d66-445b-ac92-f956f9c7d6f7", forHTTPHeaderField: "X-Yandex-API-Key")
        request.httpMethod = "GET"
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
//            если получилось получить data
            guard let data = data else {
                print("error")
                return
            }
//            print(String(data: data, encoding: .utf8)!)
            if let weather = self.parseJson(withData: data) {
                print(weather)
                completion(weather)
            }
        }
        task.resume()
    }
    
    func parseJson(withData data: Data) -> Weather? {
        let decoder = JSONDecoder()
        do {
            let weatherData = try decoder.decode(weatherData.self, from: data)
            guard let weather = Weather(weatherData: weatherData) else {
                return nil
            }
            return weather
        } catch let error as NSError {
            print(error.localizedDescription)
        }
        return nil
    }
}
