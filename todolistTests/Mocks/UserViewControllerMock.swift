import Foundation
@testable import todolist

class UserViewControllerMock: UserViewControllerProtocol {
    var modelWasConfigured = false
    var loaderShowed = false
    var loaderHidden = false
    
    func configure(with model: todolist.Model) {
        modelWasConfigured = true
    }
    
    func showLoader() {
        loaderShowed = true
    }
    
    func hideLoader() {
        loaderHidden = true
    }
    
    
}
