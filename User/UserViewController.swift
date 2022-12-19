import Foundation
import MapKit
import UIKit
import SnapKit
import CoreLocation

struct Model {
    let image: UIImage
    let temperature: String
    let windSpeed: String
    let condition: String
    let location: String
}

protocol UserViewControllerProtocol {
    func configure(with model: Model)
    func showLoader()
    func hideLoader()
}

final class UserViewController: UIViewController, UserViewControllerProtocol {
    private let presenter: UserPresenter
    private lazy var imageView = UIImageView()
    private lazy var temp = UILabel()
    private lazy var wind = UILabel()
    private lazy var condition = UILabel()
    private lazy var location = UILabel()
    private lazy var stackView = UIStackView()
    private lazy var activityView = UIActivityIndicatorView()
    
    init(presenter: UserPresenter) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with model: Model) {
        temp.text = model.temperature
        imageView.image = model.image
        wind.text = model.windSpeed
        condition.text = model.condition
        location.text = model.location
    }
    
    func showLoader() {
        activityView.startAnimating()
    }
    
    func hideLoader() {
        activityView.stopAnimating()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(activityView)
        activityView.style = .large
        activityView.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
        }
        
        imageView.contentMode = .scaleAspectFit
        
        view.addSubview(stackView)
        stackView.addArrangedSubview(imageView)
        stackView.addArrangedSubview(location)
        stackView.addArrangedSubview(temp)
        stackView.addArrangedSubview(condition)
        stackView.addArrangedSubview(wind)
        
        stackView.axis = .vertical
        stackView.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
            make.height.equalToSuperview().multipliedBy(0.5)
            make.width.equalToSuperview().multipliedBy(0.7)
        }
        
////        view.addSubview(location)
//        location.numberOfLines = 0
//        location.snp.makeConstraints { make in
//            make.top.equalToSuperview().offset(view.frame.height/1.9)
//            make.centerX.equalToSuperview()
//        }
//
////        view.addSubview(condition)
//        condition.numberOfLines = 0
//        condition.snp.makeConstraints { make in
//            make.top.equalToSuperview().offset(view.frame.height/1.5)
//            make.centerX.equalToSuperview()
//        }
//
////        view.addSubview(wind)
//        wind.numberOfLines = 0
//        wind.snp.makeConstraints { make in
//            make.top.equalToSuperview().offset(view.frame.height/1.3)
//            make.centerX.equalToSuperview()
//        }
//
////        view.addSubview(temp)
//        temp.numberOfLines = 0
//        temp.snp.makeConstraints { make in
//            make.top.equalToSuperview().offset(view.frame.height/1.7)
//            make.centerX.equalToSuperview()
//        }
//
////        view.addSubview(imageView)
//        imageView.snp.makeConstraints { make in
//            make.top.equalToSuperview().offset(view.frame.height / 3)
//            make.width.equalToSuperview().multipliedBy(0.3)
//            make.height.equalToSuperview().multipliedBy(0.1)
//            make.centerX.equalToSuperview()
//            make.centerY.equalToSuperview()
//        }
        presenter.viewDidLoad()
        view.backgroundColor = .systemBackground
    }
    
}
