import SwiftUI
import CoreData

struct DashboardView: View {
    @StateObject private var viewModel = DashboardViewModel()

    var body: some View {
        NavigationView {
            ZStack {
                Colors.Background.softBeige
                    .ignoresSafeArea(.all)
                VStack {
                    Text("Nobody Panic!")
                        .font(Font.App.largeTitle)
                        .foregroundColor(Colors.Text.charcoalGray)
                        .fontWeight(.bold)
                        .padding(.bottom, 30)

                    VStack(spacing: 40) {
                        LargeButton(
                            title: "Call Emergency Services",
                            backgroundColor: Colors.Alerts.warmRed,
                            isDisabled: viewModel.outputs.isEmergencyServicesCalled
                        ) {
                            viewModel.inputs.tappedCallEmergenyServices()
                        }

                        LargeButton(
                            title: "Get Licence Plate/s",
                            backgroundColor: Colors.Buttons.sereneTeal
                        ) {
                            viewModel.inputs.tappedGetLicencePlates()
                        }
                    }
                    .padding(.bottom, 50)

                    NavigationLink(
                        destination: { EmptyView() },
                        label: {
                            Text("Previous accidents")
                                .font(Font.App.body)
                                .foregroundColor(Colors.Text.charcoalGray)
                        }
                    )
                }
            }
        }
        .alert(
            "Use your device's phone app to call emergency services.",
            isPresented: $viewModel.shouldCallEmergencyServices
        ) {
            Button("OK", role: .cancel) {
                viewModel.inputs.callEmergencyServices()
            }
        } message: {
            Text("")
        }
        .alert(
            "Action Completed",
            isPresented: $viewModel.isGettingLicencePlates
        ) {
            Button("OK", role: .cancel) {
                viewModel.isGettingLicencePlates = false
            }
        } message: {
            Text("Getting licence plates.")
        }
    }
}

#Preview {
    DashboardView()
}
