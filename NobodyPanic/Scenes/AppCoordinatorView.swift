import SwiftUI

struct AppCoordinatorView: View {
    @StateObject private var coordinator = AppCoordinator()

    var body: some View {
        TabView {
            Group {
                // Dashboard Tab
                NavigationStack(path: $coordinator.path) {
                    DashboardView() { route in
                        coordinator.path.append(route)
                    }
                    .navigationDestination(for: AppRoute.self) { route in
                        switch route {
                        case .licensePlates(let hasCalledEmergencyServices):
                            LicensePlatesView(
                                hasCalledEmergencyServices: hasCalledEmergencyServices
                            ) { route in
                                coordinator.path.append(route)
                            }
                        case .emergencyServices(let hasCapturedLicensePlates):
                            EmptyView() // Replace with the appropriate view
                        }
                    }
                }
                .tabItem {
                    Label("Dashboard", systemImage: "house")
                }

                // Map/Location Tab
                NavigationStack {
                    EmptyView()
                }
                .tabItem {
                    Label("Map", systemImage: "map")
                }

                // Previous Accidents Tab
                NavigationStack {
                    EmptyView()
                }
                .tabItem {
                    Label("History", systemImage: "clock")
                }
            }
            .toolbarBackground(Colors.Background.lightSand, for: .tabBar)
            .toolbarBackground(.visible, for: .tabBar)
            .environmentObject(coordinator)
        }
    }
}
