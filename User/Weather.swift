import Foundation

struct ConditionImage {
    var condition: String
    var imageName: String {
        switch condition {
        case "clear" :
            return "sun.max.fill"
        case "partly-cloudy" :
            return "cloud.fill"
        case "cloudy" :
            return "cloud.fill"
        case "overcast" :
            return "cloud.fill"
        case "drizzle" :
            return "cloud.drizzle.fill"
        case "light-rain" :
            return "cloud.drizzle.fill"
        case "rain" :
            return "cloud.drizzle.fill"
        case "moderate-rain" :
            return "cloud.drizzle.fill"
        case "heavy-rain" :
            return "cloud.drizzle.fill"
        case "continuous-heavy-rain" :
            return "cloud.drizzle.fill"
        case "showers" :
            return "cloud.drizzle.fill"
        case "wet-snow" :
            return "cloud.snow"
        case "light-snow" :
            return "cloud.snow"
        case "snow" :
            return "cloud.snow"
        case "snow-showers" :
            return "cloud.snow"
        case "hail" :
            return "cloud.snow"
        case "thunderstorm" :
            return "cloud.snow"
        case "thunderstorm-with-rain" :
            return "cloud.snow"
        case "thunderstorm-with-hail" :
            return "cloud.snow"
        default :
            return "sun.max.fill"
        }
    }
}

struct Weather {
    var name: String = "Название"
    var temperature: Int
    var conditionCode: String
    var url: String
    var condition: String
    var windSpeed: Double
    var conditionString: String {
        switch condition {
        case "clear" :
            return "Ясно"
        case "partly-cloudy" :
            return "Малооблачно"
        case "cloudy" :
            return "Облочно с прояснениями"
        case "overcast" :
            return "Пасмурно"
        case "drizzle" :
            return "Морось"
        case "light-rain" :
            return "Небольшой дождь"
        case "rain" :
            return "Дождь"
        case "moderate-rain" :
            return "Умеренно-сильный дождь"
        case "heavy-rain" :
            return "Сильный дождь"
        case "continuous-heavy-rain" :
            return "Длительный сильный дождь"
        case "showers" :
            return "Ливень"
        case "wet-snow" :
            return "Дождь со снегом"
        case "light-snow" :
            return "Небольшой снег"
        case "snow" :
            return "Снег"
        case "snow-showers" :
            return "Снегопад"
        case "hail" :
            return "Град"
        case "thunderstorm" :
            return "Гроза"
        case "thunderstorm-with-rain" :
            return "Дождь с грозой"
        case "thunderstorm-with-hail" :
            return "Гроза с градом"
        default:
            return "Загрузка.."
        }
    }
    
    init(weatherData: weatherData) {
        temperature = weatherData.fact.temp
        conditionCode = weatherData.fact.icon
        url = weatherData.info.url
        condition = weatherData.fact.condition
        windSpeed = weatherData.fact.windSpeed
    }
}
