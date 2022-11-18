
import Foundation
import UIKit


final class UserViewController: UIViewController {
    private let presenter: UserPresenter
    
    init(presenter: UserPresenter) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidLoad()
        view.backgroundColor = .systemBackground
    }
}
