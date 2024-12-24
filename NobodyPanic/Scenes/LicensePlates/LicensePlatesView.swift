
import SwiftUI

struct LicensePlatesView: View {
    @StateObject private var viewModel = LicensePlatesViewModel()

    var hasCalledEmergencyServices: Bool
    var didRouteTo: (AppRoute) -> Void

    @State private var showAlert = false

    var body: some View {
        NavigationView {
            ZStack {
                Colors.Background.softBeige
                    .ignoresSafeArea(.all)
                VStack {
                    VStack(alignment: .center) {
                        Text("Capture License Plates")
                            .foregroundColor(Colors.Text.deepSlate)
                            .font(Font.App.largeTitle)
                            .multilineTextAlignment(.center)
                            .padding()
                        Text("Take photos of and/or write down the license plate for ALL vehicles involved in the accident.")
                            .foregroundColor(Colors.Text.charcoalGray)
                            .font(Font.App.body)
                            .multilineTextAlignment(.center)
                            .padding(.horizontal, 10)
                    }
                    .padding(.bottom, 20)

                    ScrollView {
                        ForEach(0..<viewModel.licensePlateCount, id: \.self) { index in
                            LicensePlateRow(
                                index: index,
                                licensePlatePhoto: $viewModel.licensePlatePhotos[index],
                                licensePlateText: $viewModel.licensePlates[index],
                                onCapturePhoto: {
                                    viewModel.inputs.captureWithCamera(for: index)
                                },
                                onDeletePhoto: {
                                    viewModel.inputs.removePhoto(at: index)
                                },
                                onRemove: {
                                    viewModel.inputs.removeLicensePlate(at: index)
                                }
                            )
                        }
                        .padding(.bottom, 30)
                        Button("Add Another License Plate") {
                            viewModel.inputs.addLicensePlate()
                        }
                    }
                    .padding()

                    Spacer()

                    Button(action: {
                        guard viewModel.hasCapturedLicensePlates else {
                            showAlert = true
                            return
                        }

                        routeToNextPage()
                    }) {
                        Text("Done")
                            .padding()
                    }
                }
                .padding()
            }
            .alert(isPresented: $showAlert) {
                Alert(
                    title: Text("Incomplete Information"),
                    message: Text("It's important to capture the license plate/s of any other vehicles involved in the accident."),
                    primaryButton: .default(Text("Continue"), action: {
                        routeToNextPage()
                    }),
                    secondaryButton: .destructive(Text("Go Back"))
                )
            }
            .sheet(isPresented: $viewModel.isPresentingCamera) {
                ImageCaptureView(
                    capturedImage: $viewModel.licensePlatePhotos[viewModel.currentLicensePlateIndex]
                )
            }
        }
    }

    private func routeToNextPage() {
        if !hasCalledEmergencyServices {
            didRouteTo(
                .emergencyServices(
                    hasCapturedLicencePlates: viewModel.hasCapturedLicensePlates
                )
            )
        } else {
            // ROUTE TO NEXT PAGE
        }
    }
}

#Preview {
    LicensePlatesView(
        hasCalledEmergencyServices: false
    ) { _ in }
}
