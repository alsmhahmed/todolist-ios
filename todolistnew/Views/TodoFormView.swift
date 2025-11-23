import SwiftUI

struct TodoFormView: View {
    @Environment(\.dismiss) var dismiss
    @ObservedObject var viewModel: TodoListViewModel
    
    @State private var title: String = ""
    @State private var notes: String = ""
    @State private var dueDate: Date = Date()
    @State private var hasDueDate: Bool = false
    
    var itemToEdit: TodoItem?
    
    init(viewModel: TodoListViewModel, itemToEdit: TodoItem? = nil) {
        self.viewModel = viewModel
        self.itemToEdit = itemToEdit
        
        if let item = itemToEdit {
            _title = State(initialValue: item.title)
            _notes = State(initialValue: item.notes)
            if let date = item.dueDate {
                _dueDate = State(initialValue: date)
                _hasDueDate = State(initialValue: true)
            }
        }
    }
    
    var body: some View {
        ZStack {
            Color.pastelBackground
                .ignoresSafeArea()
            
            VStack(spacing: 20) {
                // Header
                HStack {
                    Button(SharedStrings.cancelButton) {
                        dismiss()
                    }
                    .foregroundColor(.secondaryText)
                    
                    Spacer()
                    
                    Text(itemToEdit == nil ? SharedStrings.newTaskTitle : SharedStrings.editTaskTitle)
                        .font(.headline)
                        .foregroundColor(.primaryText)
                    
                    Spacer()
                    
                    Button(SharedStrings.saveButton) {
                        saveTask()
                        dismiss()
                    }
                    .fontWeight(.bold)
                    .foregroundColor(title.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ? .gray : .accentRed)
                    .disabled(title.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)
                }
                .padding()
                
                // Card Content
                VStack(spacing: 20) {
                    // Title Input
                    VStack(alignment: .leading, spacing: 8) {
                        Text(SharedStrings.whatNeedsToBeDone)
                            .font(.caption)
                            .foregroundColor(.secondaryText)
                        
                        TextField(SharedStrings.taskTitlePlaceholder, text: $title)
                            .font(.title3)
                            .padding()
                            .background(Color(UIColor.systemGray6))
                            .cornerRadius(12)
                    }
                    
                    // Notes Input
                    VStack(alignment: .leading, spacing: 8) {
                        Text(SharedStrings.notesLabel)
                            .font(.caption)
                            .foregroundColor(.secondaryText)
                        
                        ZStack(alignment: .topLeading) {
                            if notes.isEmpty {
                                Text(SharedStrings.notesPlaceholder)
                                    .foregroundColor(.gray)
                                    .padding(.top, 12)
                                    .padding(.leading, 12)
                            }
                            TextEditor(text: $notes)
                                .frame(height: 100)
                                .padding(4)
                                .background(Color(UIColor.systemGray6))
                                .cornerRadius(12)
                        }
                    }
                    
                    // Due Date
                    VStack(alignment: .leading, spacing: 8) {
                        Toggle(SharedStrings.setDueDateToggle, isOn: $hasDueDate)
                            .tint(.accentRed)
                        
                        if hasDueDate {
                            DatePicker("", selection: $dueDate, displayedComponents: [.date, .hourAndMinute])
                                .datePickerStyle(CompactDatePickerStyle())
                                .labelsHidden()
                        }
                    }
                    .padding()
                    .background(Color(UIColor.systemGray6))
                    .cornerRadius(12)
                    
                    if itemToEdit != nil {
                        Button(action: {
                            if let item = itemToEdit {
                                viewModel.deleteTodo(item)
                                dismiss()
                            }
                        }) {
                            HStack {
                                Image(systemName: "trash")
                                Text(SharedStrings.deleteTaskButton)
                            }
                            .foregroundColor(.red)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color(UIColor.systemGray6))
                            .cornerRadius(12)
                        }
                    }
                    
                    Spacer()
                }
                .padding()
                .background(Color.cardBackground)
                .cornerRadius(30)
                .shadow(color: Color.black.opacity(0.05), radius: 10, x: 0, y: 5)
                .padding(.horizontal)
                .padding(.bottom)
            }
        }
    }
    
    private func saveTask() {
        let finalDueDate = hasDueDate ? dueDate : nil
        
        if let item = itemToEdit {
            var updatedItem = item
            updatedItem.title = title
            updatedItem.notes = notes
            updatedItem.dueDate = finalDueDate
            viewModel.updateTodo(updatedItem)
        } else {
            viewModel.addTodo(title: title, notes: notes, dueDate: finalDueDate)
        }
    }
}
