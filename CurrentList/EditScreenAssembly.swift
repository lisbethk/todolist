
import Foundation
import UIKit

final class NoteScreenAssembly {
    
    private let noteService: FileNoteService
    
    init(noteService: FileNoteService) {
        self.noteService = noteService
    }
    
    func assemble(input: NoteScreenInput, output: EditScreenPresenterOutput) -> UIViewController {
        let presenter = NoteScreenPresenter(
            input: input,
            noteService: noteService,
            output: output
        )
        
        let viewController = NoteScreenViewController(presenter: presenter)
        
        presenter.view = viewController
        
        return UINavigationController(rootViewController: viewController)
    }
}
