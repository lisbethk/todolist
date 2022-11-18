
import Foundation
import UIKit

final class MainFlowCoordinator: UINavigationController, EditScreenPresenterOutput, UserPresenterOutput {
    private let noteService = FileNoteService()
    
    private lazy var mainScreenAssembly = MainScreenAssembly(noteService: noteService)
    private lazy var noteScreenAssembly = NoteScreenAssembly(noteService: noteService)
    private lazy var userAssembly = UserAssembly()
    
    private var rootViewController = UITabBarController()
    
    func start(from window: UIWindow) {

        let userViewController = userAssembly.assemble(output: self)
        userViewController.tabBarItem = .init(title: "USER",
                                              image: nil,
                                              selectedImage: nil)
        let mainViewController = mainScreenAssembly.assemble(output: self)
        mainViewController.tabBarItem = .init(title: "MAIN",
                                                   image: nil,
                                                   selectedImage: nil)

        window.rootViewController = rootViewController
        window.makeKeyAndVisible()
        rootViewController.setViewControllers([mainViewController,
                                               userViewController],
                                              animated: true)
    }
}
    

extension MainFlowCoordinator {
    
    private func showEdit(input: NoteScreenInput) {
        let viewController = noteScreenAssembly.assemble(input: input, output: self)
        rootViewController.present(viewController, animated: true)
    }
}

extension MainFlowCoordinator: MainScreenPresenterOutput {

    
    func didSelect(note: Note) {
        showEdit(input: .edit(note))
    }
    
    func didTapNewNote() {
        showEdit(input: .new)
    }
    
    func didRequestCloseEditScreen() {
        rootViewController.dismiss(animated: true)
    }
}
