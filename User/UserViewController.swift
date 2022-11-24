
import Foundation
import UIKit


final class UserViewController: UIViewController {
    private let presenter: UserPresenter
    private lazy var imageView = UIImageView()
    private lazy var temp = UILabel()
    private lazy var city = UILabel()
    
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
        city.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom).offset(7)
            make.centerX.equalToSuperview()
        }
        view.addSubview(temp)
        temp.text = "Температура: \nВлажность:"
        temp.numberOfLines = 0
        temp.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(view.frame.height/1.4)
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
//        fetchWeather()
    }
    
    func fetchWeather() {
        let urlString = "https://api.weather.yandex.ru/v2/forecast?lat=53.234523&lon=50.201535"
        
        guard let url = URL(string: urlString) else { return }
        
        var request = URLRequest(url: url)
        request.addValue("667cd4c5-2d66-445b-ac92-f956f9c7d6f7", forHTTPHeaderField: "X-Yandex-API-Key")
        request.httpMethod = "GET"
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
//            если получилось получить data
            guard let data = data else {
                print("error")
                return
            }
            print(String(data: data, encoding: .utf8)!)
        }
        task.resume()
    }
}
