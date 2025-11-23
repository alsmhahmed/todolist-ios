import SwiftUI

struct TodayView: View {
    var body: some View {
        ZStack {
            Color.pastelBackground
                .ignoresSafeArea()
            
            Text(SharedStrings.tabToday)
                .font(.largeTitle)
                .foregroundColor(.primaryText)
        }
    }
}
