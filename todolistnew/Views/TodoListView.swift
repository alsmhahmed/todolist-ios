import SwiftUI

struct TodoListView: View {
    @EnvironmentObject var viewModel: TodoListViewModel
    @State private var showingAddSheet = false
    @State private var selectedTodo: TodoItem?
    
    var body: some View {
        NavigationView {
            ZStack {
                // Background
                Color.pastelBackground
                    .ignoresSafeArea()
                
                VStack(spacing: 0) {
                    // Custom App Bar
                    HStack {
                        Button(action: {}) {
                            Image(systemName: "line.3.horizontal")
                                .font(.title2)
                                .foregroundColor(.primaryText)
                        }
                        
                        Spacer()
                        
                        Text(SharedStrings.inboxTitle)
                            .font(.headline)
                            .foregroundColor(.primaryText)
                        
                        Spacer()
                        
                        Button(action: {}) {
                            Image(systemName: "ellipsis")
                                .font(.title2)
                                .foregroundColor(.primaryText)
                        }
                    }
                    .padding()
                    
                    // Main Card
                    VStack(alignment: .leading, spacing: 0) {
                        // Card Header
                        HStack {
                            Text(SharedStrings.todayHeader)
                                .font(.caption)
                                .fontWeight(.bold)
                                .foregroundColor(.secondaryText)
                                .padding(.top, 20)
                                .padding(.leading, 20)
                            
                            Spacer()
                            
                            Text("\(viewModel.todos.count)")
                                .font(.caption)
                                .foregroundColor(.secondaryText)
                                .padding(.top, 20)
                                .padding(.trailing, 20)
                        }
                        
                        if viewModel.todos.isEmpty {
                            TodoEmptyStateView()
                        } else {
                            ScrollView {
                                LazyVStack(spacing: 0) {
                                    ForEach(viewModel.todos) { item in
                                        TodoRowView(item: item) {
                                            withAnimation {
                                                viewModel.toggleTodoCompletion(item)
                                            }
                                        }
                                        .padding(.horizontal, 16)
                                        .onTapGesture {
                                            selectedTodo = item
                                        }
                                        
                                        Divider()
                                            .padding(.leading, 56) // Indent divider to align with text
                                    }
                                }
                                .padding(.top, 10)
                            }
                        }
                    }
                    .background(Color.cardBackground)
                    .cornerRadius(30)
                    .shadow(color: Color.black.opacity(0.05), radius: 10, x: 0, y: 5)
                    .padding(.horizontal, 16)
                    .padding(.bottom, 16) // Leave space for FAB area if needed, but FAB is overlay
                }
                
                // Floating Action Button
                VStack {
                    Spacer()
                    HStack {
                        Spacer()
                        Button(action: { showingAddSheet = true }) {
                            Image(systemName: "plus")
                                .font(.title2.weight(.bold))
                                .foregroundColor(.white)
                                .frame(width: 56, height: 56)
                                .background(Color.accentRed)
                                .clipShape(Circle())
                                .shadow(color: Color.accentRed.opacity(0.4), radius: 8, x: 0, y: 4)
                        }
                        .padding(.trailing, 32)
                        .padding(.bottom, 32)
                    }
                }
            }
            .navigationBarHidden(true)
            .sheet(isPresented: $showingAddSheet) {
                TodoFormView(viewModel: viewModel)
            }
            .sheet(item: $selectedTodo) { item in
                TodoFormView(viewModel: viewModel, itemToEdit: item)
            }
        }
    }
}
