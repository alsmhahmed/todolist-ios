import SwiftUI

struct SearchView: View {
    var body: some View {
        ZStack {
            Color.pastelBackground
                .ignoresSafeArea()
            
            Text(SharedStrings.tabSearch)
                .font(.largeTitle)
                .foregroundColor(.primaryText)
        }
    }
}
