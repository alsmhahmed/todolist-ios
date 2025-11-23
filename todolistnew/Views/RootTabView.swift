import SwiftUI

struct RootTabView: View {
    @AppStorage("language") private var language = "en"
    @StateObject private var todoViewModel = TodoListViewModel()
    
    var body: some View {
        TabView {
            TodoListView()
                .tabItem {
                    Image(systemName: "house.fill")
                    Text(SharedStrings.tabHome)
                }
                .environmentObject(todoViewModel)
            
            SettingsView()
                .tabItem {
                    Image(systemName: "gearshape.fill")
                    Text(SharedStrings.tabSettings)
                }
                .environmentObject(todoViewModel)
        }
        .environment(\.locale, Locale(identifier: language))
        .environment(\.layoutDirection, language == "ar" ? .rightToLeft : .leftToRight)
        .id(language) // Force redraw when language changes
    }
}
