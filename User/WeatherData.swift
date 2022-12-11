import Foundation

struct weatherData: Decodable {
    let info: Info
    let fact: Fact
}

struct Info: Decodable {
    let url: String
}

struct Fact: Decodable {
    let temp: Int
    let icon: String
    let condition: String
    let windSpeed: Double
    
    enum CodingKeys: String, CodingKey {
        case temp
        case icon
        case condition
        case windSpeed = "wind_speed"
    }
}
