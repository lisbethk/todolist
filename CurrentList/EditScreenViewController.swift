
import Foundation
import UIKit

protocol NoteScreenViewControllerProtocol: AnyObject {
    func configure(with text: String)
}

final class NoteScreenViewController: UIViewController {
    
    private lazy var textView: UITextView = {
        let textView = UITextView()
        textView.font = .preferredFont(forTextStyle: .title2, compatibleWith: traitCollection)
        textView.contentInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        return textView
    }()
    
    private let presenter: NoteScreenPresenterProtocol
    
    init(presenter: NoteScreenPresenterProtocol) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
        presenter.viewDidLoad()
    }
    
    private func setUpUI() {
        view.addSubview(textView)
        view.backgroundColor = .systemBackground
        
        textView.snp.makeConstraints {
            $0.top.left.right.equalToSuperview()
            $0.bottom.equalTo(view.keyboardLayoutGuide.snp.top)
        }
        
        navigationItem.rightBarButtonItem = .init(
            title: "Готово",
            image: nil,
            primaryAction: .init { [weak self] _ in self?.presenter.didTapSave(text: self?.textView.text ?? "")},
            menu: nil
        )
    }
}

extension NoteScreenViewController: NoteScreenViewControllerProtocol {
    func configure(with text: String) {
        textView.text = text
    }
}
