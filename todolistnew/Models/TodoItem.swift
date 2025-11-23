import Foundation

struct TodoItem: Identifiable, Codable, Equatable {
    let id: UUID
    var title: String
    var notes: String
    var isDone: Bool
    let createdAt: Date
    var dueDate: Date?
    
    init(id: UUID = UUID(), title: String, notes: String = "", isDone: Bool = false, createdAt: Date = Date(), dueDate: Date? = nil) {
        self.id = id
        self.title = title
        self.notes = notes
        self.isDone = isDone
        self.createdAt = createdAt
        self.dueDate = dueDate
    }
}
