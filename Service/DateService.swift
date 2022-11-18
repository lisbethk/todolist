import UIKit
import Foundation

final class DateService {
     func getTodayDate() -> String  {
        let formatted = Date().formatted(date: .abbreviated, time: .omitted)
        let stringDate = "\(formatted)"
        return stringDate
    }
}
