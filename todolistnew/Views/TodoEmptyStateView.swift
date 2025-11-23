import SwiftUI

struct TodoEmptyStateView: View {
    var body: some View {
        VStack(spacing: 16) {
            Image(systemName: "checkmark.square")
                .font(.system(size: 48))
                .foregroundColor(Color.accentRed.opacity(0.5))
            
            Text(SharedStrings.noTasksTitle)
                .font(.headline)
                .foregroundColor(.primaryText)
            
            Text(SharedStrings.noTasksMessage)
                .font(.subheadline)
                .foregroundColor(.secondaryText)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .padding()
    }
}
