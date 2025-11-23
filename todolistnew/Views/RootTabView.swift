import SwiftUI

struct RootTabView: View {
    @AppStorage("language") private var language = "en"
    @StateObject private var todoViewModel = TodoListViewModel()
    @State private var selectedTab = 1 // Default to Inbox (index 1)
    @State private var showingAddSheet = false
    
    init() {
        // Custom Tab Bar Appearance
        let appearance = UITabBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .white
        appearance.shadowColor = UIColor.black.withAlphaComponent(0.1) // Subtle top shadow
        
        UITabBar.appearance().standardAppearance = appearance
        UITabBar.appearance().scrollEdgeAppearance = appearance
    }
    
    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            TabView(selection: $selectedTab) {
                // Tab 0: Today
                TodayView()
                    .tabItem {
                        Image(systemName: "calendar")
                        Text(SharedStrings.tabToday)
                    }
                    .tag(0)
                
                // Tab 1: Inbox (Home)
                TodoListView()
                    .environmentObject(todoViewModel)
                    .tabItem {
                        Image(systemName: "tray")
                        Text(SharedStrings.tabInbox)
                    }
                    .tag(1)
                
                // Tab 2: Search
                SearchView()
                    .tabItem {
                        Image(systemName: "magnifyingglass")
                        Text(SharedStrings.tabSearch)
                    }
                    .tag(2)
                
                // Tab 3: Settings
                SettingsView()
                    .environmentObject(todoViewModel)
                    .tabItem {
                        Image(systemName: "gearshape")
                        Text(SharedStrings.tabSettings)
                    }
                    .tag(3)
            }
            .accentColor(Color.accentRed) // Soft reddish accent for selected tab
            
            // Floating Action Button
            Button(action: {
                showingAddSheet = true
            }) {
                Image(systemName: "plus")
                    .font(.title2.weight(.bold))
                    .foregroundColor(.white)
                    .frame(width: 56, height: 56)
                    .background(Color.accentRed) // Terracotta/Red background
                    .clipShape(Circle())
                    .shadow(color: Color.black.opacity(0.2), radius: 4, x: 0, y: 2)
            }
            .padding(.trailing, 20)
            .padding(.bottom, 80) // Adjust based on Tab Bar height
        }
        .environment(\.locale, Locale(identifier: language))
        .environment(\.layoutDirection, language == "ar" ? .rightToLeft : .leftToRight)
        .id(language) // Force redraw when language changes
        .sheet(isPresented: $showingAddSheet) {
            TodoFormView(viewModel: todoViewModel)
                .environment(\.locale, Locale(identifier: language))
                .environment(\.layoutDirection, language == "ar" ? .rightToLeft : .leftToRight)
        }
    }
}
