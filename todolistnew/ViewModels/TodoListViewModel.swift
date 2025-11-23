import Foundation
import Combine

class TodoListViewModel: ObservableObject {
    @Published var todos: [TodoItem] = []
    private let storage = TodoStorage()
    
    init() {
        loadTodos()
    }
    
    func loadTodos() {
        todos = storage.load()
    }
    
    func saveTodos() {
        storage.save(todos)
    }
    
    func addTodo(title: String, notes: String, dueDate: Date?) {
        let newTodo = TodoItem(title: title, notes: notes, dueDate: dueDate)
        todos.append(newTodo)
        saveTodos()
    }
    
    func updateTodo(_ item: TodoItem) {
        if let index = todos.firstIndex(where: { $0.id == item.id }) {
            todos[index] = item
            saveTodos()
        }
    }
    
    func toggleTodoCompletion(_ item: TodoItem) {
        if let index = todos.firstIndex(where: { $0.id == item.id }) {
            todos[index].isDone.toggle()
            saveTodos()
        }
    }
    
    func deleteTodo(at offsets: IndexSet) {
        todos.remove(atOffsets: offsets)
        saveTodos()
    }
    
    func deleteTodo(_ item: TodoItem) {
        if let index = todos.firstIndex(where: { $0.id == item.id }) {
            todos.remove(at: index)
            saveTodos()
        }
    }
    
    func clearAllTodos() {
        todos.removeAll()
        saveTodos()
    }
}
