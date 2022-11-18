import Foundation
import CoreData
struct Note: Codable {
    let id: UUID
    let text: String
    let lastUpdated: Date
}

protocol NoteServiceProtocol {
    func add(text: String) throws
    
    func update(id: UUID, with text: String) throws
    
    func remove(id: UUID) throws
    
    func readAllNotes() throws -> [Note]
}

protocol FileNoteServiceDelegate: AnyObject {
    func didAdded(note: Note)
    func didUpdated(note: Note)
    func didRemoved(id: UUID)
}

final class FileNoteService: NoteServiceProtocol {
    weak var delegate: FileNoteServiceDelegate?
    private var text: [NSManagedObject] = []
    
    func add(text: String) throws {
        let note = Note(id: UUID(), text: text, lastUpdated: Date())
        let data = try JSONEncoder().encode(note)
        try data.write(to: .documentsURL.appendingPathComponent(note.id.uuidString))
        delegate?.didAdded(note: note)
    }
    
    func update(id: UUID, with text: String) throws {
        let note = Note(id: id, text: text, lastUpdated: Date())
        let data = try JSONEncoder().encode(note)
        try data.write(to: .documentsURL.appendingPathComponent(note.id.uuidString))
        delegate?.didUpdated(note: note)
    }
    
    func remove(id: UUID) throws {
        try FileManager.default.removeItem(at: .documentsURL.appendingPathComponent(id.uuidString))
        delegate?.didRemoved(id: id)
    }
    
    func readAllNotes() throws -> [Note]  {
        let directoryContents = try FileManager.default.contentsOfDirectory(
            at: URL.documentsURL,
            includingPropertiesForKeys: nil
        )
        return try directoryContents.compactMap { url -> Note? in
            let data = try Data(contentsOf: url)
            return try JSONDecoder().decode(Note.self, from: data)
        }
    }
}

extension URL {
    static var documentsURL: URL {
        return try! FileManager
            .default
            .url(
                for: .documentDirectory,
                in: .userDomainMask,
                appropriateFor: nil,
                create: true
            )
    }
}
