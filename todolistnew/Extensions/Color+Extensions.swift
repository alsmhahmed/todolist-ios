import SwiftUI

extension Color {
    static let pastelBackground = LinearGradient(
        gradient: Gradient(colors: [Color(hex: "E0F7FA"), Color(hex: "FCE4EC")]),
        startPoint: .topLeading,
        endPoint: .bottomTrailing
    )
    
    static let cardBackground = Color.white
    static let primaryText = Color.black.opacity(0.8)
    static let secondaryText = Color.gray
    static let accentRed = Color(hex: "FF5252")
    
    // Helper to init from hex
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (1, 1, 1, 0)
        }

        self.init(
            .sRGB,
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue: Double(b) / 255,
            opacity: Double(a) / 255
        )
    }
    
    static func randomCategoryColor() -> Color {
        let colors: [Color] = [
            Color(hex: "FFAB91"), // Light Red
            Color(hex: "FFCC80"), // Orange
            Color(hex: "FFF59D"), // Yellow
            Color(hex: "A5D6A7"), // Green
            Color(hex: "80DEEA"), // Cyan
            Color(hex: "9FA8DA"), // Indigo
            Color(hex: "CE93D8")  // Purple
        ]
        return colors.randomElement() ?? .blue
    }
}
