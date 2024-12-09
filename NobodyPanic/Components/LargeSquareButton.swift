import SwiftUI

struct LargeButton: View {
    let title: String
    let backgroundColor: Color
    var isDisabled: Bool = false
    let action: () -> Void

    var body: some View {
        ZStack(alignment: .topTrailing) {
            Button(action: {
                if !isDisabled { action() }
            }) {
                Text(title)
                    .font(Font.App.buttonTitle)
                    .fontWeight(isDisabled ? .medium : .bold)
                    .foregroundColor(isDisabled ? .gray : .white)
                    .frame(maxWidth: 325)
                    .frame(height: 150)
                    .background(isDisabled ? backgroundColor.opacity(0.5) : backgroundColor)
                    .cornerRadius(12)
                    .shadow(color: isDisabled ? .clear : .black.opacity(0.2), radius: 4, x: 0, y: 2)
            }
            .disabled(isDisabled)

            if isDisabled {
                Image(systemName: "checkmark.circle.fill")
                    .resizable()
                    .scaledToFit()
                    .foregroundColor(.white)
                    .frame(width: 30, height: 30)
                    .padding([.top, .trailing], 10)
            }
        }
        .padding(.horizontal, 20)
    }
}
