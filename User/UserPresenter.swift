
import Foundation
import UIKit

protocol UserPresenterOutput: AnyObject {

}

final class UserPresenter {
    private weak var output: UserPresenterOutput?

    init(output: UserPresenterOutput) {
        self.output = output
    }
    
    func viewDidLoad() {
       
    }
}
