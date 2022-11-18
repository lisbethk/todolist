import Foundation
import UIKit

final class UserAssembly {
    
    func assemble(output: UserPresenterOutput) -> UIViewController {
        
        let presenter = UserPresenter(output: output)
        let vc = UserViewController(presenter: presenter)
        let navigationVC = UINavigationController(rootViewController: vc)
        navigationVC.navigationBar.prefersLargeTitles = true
        return navigationVC
    }
}
