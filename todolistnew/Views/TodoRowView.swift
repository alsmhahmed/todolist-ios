import SwiftUI

struct TodoRowView: View {
    let item: TodoItem
    let onToggle: () -> Void
    
    // Generate a stable random color based on ID for the checkbox border
    private var categoryColor: Color {
        var hasher = Hasher()
        hasher.combine(item.id)
        let hash = abs(hasher.finalize())
        let colors: [Color] = [
            Color(hex: "FFAB91"), Color(hex: "FFCC80"), Color(hex: "FFF59D"),
            Color(hex: "A5D6A7"), Color(hex: "80DEEA"), Color(hex: "9FA8DA"), Color(hex: "CE93D8")
        ]
        return colors[hash % colors.count]
    }
    
    var body: some View {
        HStack(alignment: .center, spacing: 12) {
            // Custom Checkbox
            Button(action: onToggle) {
                ZStack {
                    if item.isDone {
                        Circle()
                            .fill(categoryColor)
                            .frame(width: 24, height: 24)
                        Image(systemName: "checkmark")
                            .font(.system(size: 12, weight: .bold))
                            .foregroundColor(.white)
                    } else {
                        Circle()
                            .stroke(categoryColor, lineWidth: 2)
                            .frame(width: 24, height: 24)
                    }
                }
            }
            .buttonStyle(PlainButtonStyle())
            
            // Title
            Text(item.title)
                .font(.body)
                .foregroundColor(item.isDone ? .gray : .primaryText)
                .strikethrough(item.isDone)
                .lineLimit(1)
            
            Spacer()
            
            // Time (if available)
            if let dueDate = item.dueDate {
                HStack(spacing: 4) {
                    Text(dueDate, style: .time)
                        .font(.caption)
                        .foregroundColor(.accentRed)
                    Image(systemName: "alarm")
                        .font(.caption2)
                        .foregroundColor(.secondaryText)
                }
            }
        }
        .padding(.vertical, 12)
        .padding(.horizontal, 4)
        .contentShape(Rectangle()) // Make whole row tappable
    }
}
