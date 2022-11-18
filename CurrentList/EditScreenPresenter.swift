
import UIKit
import Foundation

protocol NoteScreenPresenterProtocol {
    func viewDidLoad()
    func didTapSave(text: String)
}

protocol EditScreenPresenterOutput: AnyObject {
    func didRequestCloseEditScreen()
}

enum NoteScreenInput {
    case new
    case edit(Note)
}

final class NoteScreenPresenter {
    
    private let input: NoteScreenInput
    private let noteService: NoteServiceProtocol
    private weak var output: EditScreenPresenterOutput?
    
    weak var view: NoteScreenViewControllerProtocol?
    
    init(input: NoteScreenInput, noteService: NoteServiceProtocol, output: EditScreenPresenterOutput) {
        self.input = input
        self.noteService = noteService
        self.output = output
    }
}

extension NoteScreenPresenter: NoteScreenPresenterProtocol {
    
    func didTapSave(text: String) {
        switch input {
        case let .edit(note) where text.isEmpty:
            try! noteService.remove(id: note.id)
        case .new:
            if text.isEmpty
            {
                output?.didRequestCloseEditScreen()
            } else {
                try! noteService.add(text: text)}
        case let .edit(note):
            try! noteService.update(id: note.id, with: text)
        }
        output?.didRequestCloseEditScreen()
    }
    
    func viewDidLoad() {
        guard case let .edit(note) = input else { return }
        view?.configure(with: note.text)
    }
}
