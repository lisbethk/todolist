
import Foundation
import UIKit

protocol MainScreenPresenterOutput: AnyObject {
    func didSelect(note: Note)
    func didTapNewNote()
}

final class MainScreenPresenter {
    
    weak var view: MainScreenViewProtocol?
    private weak var output: MainScreenPresenterOutput?
    private let noteService: NoteServiceProtocol
    private var notes = [Note]()
    
    init(noteService: NoteServiceProtocol, output: MainScreenPresenterOutput) {
        self.noteService = noteService
        self.output = output
    }
    
    private func reloadScreen() {
        notes = try! noteService.readAllNotes()
      
        view?.show(items: notes.map {
            MainScreenItem(id: $0.id, text: $0.text)
        })
    }
}

extension MainScreenPresenter: MainScreenViewOutput {
    func didTapDelete(at index: Int) {
        try? noteService.remove(id: notes[index].id)
    }
    
    
    func viewDidLoad() {
        reloadScreen()
    }
    
    func didTapItem(at index: Int) {
        output?.didSelect(note: notes[index])
    }
    
    func didTapNewItem() {
        output?.didTapNewNote()
    }
}

extension MainScreenPresenter: FileNoteServiceDelegate {
    func didAdded(note: Note) {
        notes.append(note)
        reloadScreen()
    }
    
    func didUpdated(note: Note) {
        guard let index = notes.firstIndex(where: { $0.id == note.id }) else { return }
        notes[index] = note
        reloadScreen()
    }
    
    func didRemoved(id: UUID) {
        notes = notes.filter { $0.id == id }
        reloadScreen()
    }
}
