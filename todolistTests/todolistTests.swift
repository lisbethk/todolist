import XCTest
@testable import todolist

final class todolistTests: XCTestCase {
    
    var presenter: UserPresenter!
    var weatherServiceMock: WeatherServiceMock!
    var locationManagerMock: LocationManagerMock!
    var view: UserViewControllerMock!
    
    override func setUpWithError() throws {
        weatherServiceMock = .init()
        view = .init()
        locationManagerMock = .init()
        presenter = UserPresenter(
            weatherService: weatherServiceMock,
            locationManager: locationManagerMock,
            dispatchQueue: DispatchQueueMock()
        )
        presenter.view = view
    }

    override func tearDownWithError() throws {
        presenter = nil
        weatherServiceMock = nil
        view = nil
        locationManagerMock = nil
    }

    func testExample() throws {
        
        // when
        presenter.viewDidLoad()
        
        // then
        XCTAssertTrue(weatherServiceMock.fetchWeatherWasCalled)
        XCTAssertTrue(locationManagerMock.gotUserLocation)
        XCTAssertTrue(view.loaderHidden)
        XCTAssertTrue(view.loaderShowed)
        XCTAssertTrue(view.modelWasConfigured)
    }
}
