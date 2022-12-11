import Foundation
import UIKit

protocol UserPresenterOutput: AnyObject {

}

final class UserPresenter {
    private weak var output: UserPresenterOutput?
    private var networkService: NetworkService?

    init(output: UserPresenterOutput, networkService: NetworkService) {
        self.output = output
        self.networkService = networkService
    }
    
    func viewDidLoad() {
        
        networkService?.fetchWeather { weather in
            
            
        }
       
    }
}
