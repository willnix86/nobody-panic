import SwiftUI
import CoreData

struct DashboardView: View {
    @StateObject private var viewModel = DashboardViewModel()

    var didRouteTo: (AppRoute) -> Void

    var body: some View {
        NavigationView {
            ZStack {
                Colors.Background.softBeige
                    .ignoresSafeArea(.all)
                VStack {
                    Text("Nobody Panic!")
                        .font(Font.App.largeTitle)
                        .foregroundColor(Colors.Text.deepSlate)
                        .fontWeight(.bold)
                        .padding(.bottom, 30)

                    VStack(spacing: 40) {
                        LargeButton(
                            title: "Call Emergency Services",
                            backgroundColor: Colors.Alerts.warmRed,
                            isDisabled: viewModel.hasCalledEmergencyServices
                        ) {
                            viewModel.inputs.tappedCallEmergenyServices()
                        }

                        LargeButton(
                            title: "Get Licence Plate/s",
                            backgroundColor: Colors.Buttons.sereneTeal,
                            isDisabled: viewModel.hasCapturedLicensePlates
                        ) {
                            didRouteTo(
                                .licensePlates(
                                    hasCalledEmergencyServices: viewModel.hasCalledEmergencyServices
                                )
                            )
                        }
                    }
                    .padding(.bottom, 50)
                }
            }
        }
        .alert(
            "Use your device's phone app to call emergency services.",
            isPresented: $viewModel.shouldCallEmergencyServices
        ) {
            Button("OK", role: .cancel) {
                viewModel.inputs.confirmCallEmergencyServices()
            }
        } message: {
            Text("")
        }
    }
}

#Preview {
    DashboardView() { _ in }
}
