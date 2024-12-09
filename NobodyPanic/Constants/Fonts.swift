import SwiftUI

enum Fonts {
    enum SFPro {
        /// Large title font for main headings.
        static let largeTitle = Font.system(size: 34, weight: .bold, design: .default)
        /// Body font for general text.
        static let body = Font.system(size: 17, weight: .regular, design: .default)
    }

    enum Roboto {
        /// Subheadline font for subtitles or labels.
        static let subheadline = Font.custom("Roboto-Medium", size: 15)
    }

    enum Nunito {
        /// Button title font for primary actions.
        static let buttonTitle = Font.custom("Nunito-SemiBold", size: 16)
        /// Caption font for feedback messages or smaller text.
        static let caption = Font.custom("Nunito-Regular", size: 12)
    }
}

extension Font {
    /// Predefined font styles for the app.
    struct App {
        /// Large title for main headings.
        static let largeTitle = Font.dynamicCustomFont(name: "SFPro-Bold", size: 34, textStyle: .largeTitle)

        /// Body text for general use.
        static let body = Font.dynamicCustomFont(name: "SFPro-Regular", size: 17, textStyle: .body)

        /// Subheadline for subtitles or labels.
        static let subheadline = Font.dynamicCustomFont(name: "Roboto-Medium", size: 15, textStyle: .subheadline)

        /// Button title for interactive elements.
        static let buttonTitle = Font.dynamicCustomFont(name: "Nunito-SemiBold", size: 16, textStyle: .headline)

        /// Caption for small feedback messages or notes.
        static let caption1 = Font.dynamicCustomFont(name: "Nunito-Regular", size: 12, textStyle: .caption1)
    }
}

extension Font {
    /// Creates a dynamic custom font with support for scaling.
    /// - Parameters:
    ///   - name: The name of the font.
    ///   - size: The base font size.
    ///   - textStyle: The corresponding text style for scaling.
    /// - Returns: A SwiftUI `Font` instance that supports dynamic type.
    static func dynamicCustomFont(name: String, size: CGFloat, textStyle: UIFont.TextStyle) -> Font {
        let font = UIFont(name: name, size: size) ?? UIFont.systemFont(ofSize: size)
        let metrics = UIFontMetrics(forTextStyle: textStyle)
        let scaledFont = metrics.scaledFont(for: font)
        return Font(scaledFont)
    }
}
