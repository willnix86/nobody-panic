import SwiftUI

enum Colors {
    // Background Colors
    enum Background {
        /// Soft Beige (#F5F5DC) - Used for app-wide backgrounds to create a calming, neutral tone.
        static let softBeige = Color(hex: "#F5F5DC")
    }

    // Text Colors
    enum Text {
        /// Deep Slate (#2F4F4F) - Used for main titles and headings for strong readability.
        static let deepSlate = Color(hex: "#2F4F4F")

        /// Steel Blue (#4682B4) - Used for subtitles, labels, or secondary text elements.
        static let steelBlue = Color(hex: "#4682B4")

        /// Charcoal Gray (#333333) - Used for body text to ensure high legibility.
        static let charcoalGray = Color(hex: "#333333")
    }

    // Button Colors
    enum Buttons {
        /// Serene Teal (#008080) - Used for primary buttons and interactive elements.
        static let sereneTeal = Color(hex: "#008080")

        /// Sky Blue (#87CEEB) - Used for secondary buttons or less prominent actions (e.g., "Cancel").
        static let skyBlue = Color(hex: "#87CEEB")
    }

    // Alert and State Colors
    enum Alerts {
        /// Fern Green (#4CAF50) - Used to indicate success or positive actions (e.g., "Form submitted successfully").
        static let fernGreen = Color(hex: "#4CAF50")

        /// Warm Red (#D32F2F) - Used for errors, warnings, or invalid inputs (e.g., "Please fill all required fields").
        static let warmRed = Color(hex: "#D32F2F")

        /// Bright Yellow (#FFD700) - Used for important notices or high-contrast elements needing immediate attention (e.g., "Critical message").
        static let brightYellow = Color(hex: "#FFD700")
    }
}

extension Color {
    /// Initializes a Color from a HEX string.
    /// - Parameter hex: The HEX string (e.g., "#FFFFFF" or "FFFFFF").
    init(hex: String) {
        let hexSanitized = hex.trimmingCharacters(in: .whitespacesAndNewlines).replacingOccurrences(of: "#", with: "")
        let scanner = Scanner(string: hexSanitized)

        var rgb: UInt64 = 0
        scanner.scanHexInt64(&rgb)

        let red = Double((rgb & 0xFF0000) >> 16) / 255.0
        let green = Double((rgb & 0x00FF00) >> 8) / 255.0
        let blue = Double(rgb & 0x0000FF) / 255.0

        self.init(.sRGB, red: red, green: green, blue: blue, opacity: 1.0)
    }
}
