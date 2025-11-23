import Foundation

struct LocalizationUtility {
    static func translate(_ key: String, fallback: String) -> String {
        let result = NSLocalizedString(key, comment: "")
        return result == key ? fallback : result
    }
}
