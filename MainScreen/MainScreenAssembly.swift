import Foundation
import UIKit

final class MainScreenAssembly {
    
    private let noteService: FileNoteService
    
    init(noteService: FileNoteService) {
        self.noteService = noteService
    }
    
    func assemble(output: MainScreenPresenterOutput) -> UIViewController {
        let presenter = MainScreenPresenter(noteService: noteService, output: output)
        let vc = MainScreenViewController(output: presenter)
        let navigationVC = UINavigationController(rootViewController: vc)
        navigationVC.navigationBar.prefersLargeTitles = true
        presenter.view = vc
        noteService.delegate = presenter
        return navigationVC
    }
}
