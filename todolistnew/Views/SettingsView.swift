import SwiftUI

struct SettingsView: View {
    @AppStorage("language") private var language = "en"
    @EnvironmentObject var viewModel: TodoListViewModel
    @State private var showingClearConfirmation = false
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text(SharedStrings.settingsLanguageTitle)) {
                    Picker(SharedStrings.settingsLanguageTitle, selection: $language) {
                        Text(SharedStrings.settingsLanguageEnglish).tag("en")
                        Text(SharedStrings.settingsLanguageArabic).tag("ar")
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
                
                Section {
                    Button(action: {
                        showingClearConfirmation = true
                    }) {
                        Text(SharedStrings.settingsClearAllTasks)
                            .foregroundColor(.red)
                    }
                }
            }
            .navigationTitle(Text(SharedStrings.settingsTitle))
            .alert(isPresented: $showingClearConfirmation) {
                Alert(
                    title: Text(SharedStrings.settingsClearAllTasksConfirmationTitle),
                    message: Text(SharedStrings.settingsClearAllTasksConfirmationMessage),
                    primaryButton: .destructive(Text(SharedStrings.settingsClearAllTasksConfirm)) {
                        viewModel.clearAllTodos()
                    },
                    secondaryButton: .cancel(Text(SharedStrings.settingsClearAllTasksCancel))
                )
            }
        }
    }
}
