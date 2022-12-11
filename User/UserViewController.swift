import Foundation
import UIKit

final class UserViewController: UIViewController {
    private let presenter: UserPresenter
    private lazy var imageView = UIImageView()
    private lazy var temp = UILabel()
    private lazy var city = UILabel()
    
//    private let image: UIImage

    init(presenter: UserPresenter) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(city)
//        city.text = "Самара"
//        city.snp.makeConstraints { make in
//            make.top.equalToSuperview().offset(view.frame.height / 1.79)
//            make.centerX.equalToSuperview()
//        }
        view.addSubview(temp)
        temp.text = "Локация: \nТемпература: \nВлажность: \nСкорость ветра:"
        temp.numberOfLines = 0
        temp.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(view.frame.height/1.7)
            make.centerX.equalToSuperview()
        }
        
        view.addSubview(imageView)
        imageView.backgroundColor = .red
        imageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(view.frame.height / 3)
            make.width.equalToSuperview().multipliedBy(0.5)
            make.height.equalToSuperview().multipliedBy(0.2)
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
        }
        presenter.viewDidLoad()
        view.backgroundColor = .systemBackground
    }
    
}
