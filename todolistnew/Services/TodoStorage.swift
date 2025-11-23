import Foundation

class TodoStorage {
    private let fileName = "todos.json"
    
    private var fileURL: URL {
        let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        return documentsDirectory.appendingPathComponent(fileName)
    }
    
    func load() -> [TodoItem] {
        do {
            let data = try Data(contentsOf: fileURL)
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601
            let items = try decoder.decode([TodoItem].self, from: data)
            return items
        } catch {
            print("Error loading todos: \(error)")
            return []
        }
    }
    
    func save(_ items: [TodoItem]) {
        do {
            let encoder = JSONEncoder()
            encoder.dateEncodingStrategy = .iso8601
            encoder.outputFormatting = .prettyPrinted
            let data = try encoder.encode(items)
            try data.write(to: fileURL)
        } catch {
            print("Error saving todos: \(error)")
        }
    }
}
