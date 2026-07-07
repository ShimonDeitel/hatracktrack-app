import SwiftUI

enum Theme {
    static let accent = Color(red: 0.8314, green: 0.6392, blue: 0.4510)
    static let background = Color(red: 0.0941, green: 0.0784, blue: 0.0627)
    static let card = Color(red: 0.1490, green: 0.1255, blue: 0.1020)
    static let textPrimary = Color(red: 0.9725, green: 0.9373, blue: 0.8941)
    static let textMuted = Color(red: 0.8471, green: 0.7569, blue: 0.6392)

    static let titleFont = Font.system(.title2, design: .serif).weight(.bold)
    static let bodyFont = Font.system(.body, design: .rounded)
    static let labelFont = Font.system(.caption, design: .rounded).weight(.semibold)
}
