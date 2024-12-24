import SwiftUI

struct LicensePlateRow: View {
    let index: Int
    @Binding var licensePlatePhoto: UIImage?
    @Binding var licensePlateText: String
    let onCapturePhoto: () -> Void
    let onDeletePhoto: () -> Void
    let onRemove: () -> Void

    var body: some View {
        VStack(spacing: 20) {
            Divider()
                .background(Colors.Text.charcoalGray)
            Text("License Plate \(index + 1)")
                .foregroundColor(Colors.Text.deepSlate)
                .font(Font.App.headline)
                .bold()

            if let licensePlatePhoto {
                ZStack(alignment: .topTrailing) {
                    Image(uiImage: licensePlatePhoto)
                        .resizable()
                        .scaledToFit()
                        .frame(height: 125)

                    Button(
                        action: onDeletePhoto,
                        label: {
                            Image(systemName: "trash")
                                .resizable()
                                .frame(width: 24, height: 24)
                                .foregroundColor(Colors.Alerts.warmRed)
                                .padding(8)
                                .background(.white.opacity(0.8))
                                .clipShape(Circle())
                        }
                    )
                    .offset(x: 20, y: -10)
                }

            } else {
                Button(action: onCapturePhoto) {
                    Text("Take Photo")
                        .font(Font.App.buttonTitle)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
            }

            VStack(alignment: .leading) {
                Text("Type license plate:")
                    .foregroundColor(Colors.Text.charcoalGray)
                    .font(Font.App.subheadline)
                HStack {
                    TextField("", text: $licensePlateText)
                        .textFieldStyle(.plain)
                        .padding(10)
                        .font(Font.App.body)
                        .frame(maxWidth: .infinity)
                        .background(.white)
                        .foregroundColor(.black)
                        .cornerRadius(10)
                        .accentColor(.black)
                        .textFieldStyle(.roundedBorder)

                    Button(action: onRemove) {
                        Image(systemName: "minus.circle")
                            .foregroundColor(.red)
                    }
                }
            }
            Divider()
                .background(Colors.Text.charcoalGray)
        }
    }
}

#Preview {
    LicensePlateRow(
        index: 0,
        licensePlatePhoto: .constant(
            UIImage(systemName: "trash")
        ),
        licensePlateText: .constant("664 BAG"),
        onCapturePhoto: { },
        onDeletePhoto: { },
        onRemove: { }
    )
}
