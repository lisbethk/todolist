import Foundation
import UIKit

final class UserAssembly {
    
    private var networkService: NetworkService
    
    init(networkService: NetworkService) {
        self.networkService = networkService
    }
    
    func assemble(output: UserPresenterOutput) -> UIViewController {
        
        let presenter = UserPresenter(output: output, networkService: networkService)
        let vc = UserViewController(presenter: presenter)
        let navigationVC = UINavigationController(rootViewController: vc)
        navigationVC.navigationBar.prefersLargeTitles = true
        return navigationVC
    }
}
