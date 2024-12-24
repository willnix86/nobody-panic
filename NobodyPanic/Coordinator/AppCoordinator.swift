import SwiftUI

protocol AppCoordinating {
    func navigate(to route: AppRoute)
    func pop()
    func resetToRoot()
}

final class AppCoordinator: ObservableObject, AppCoordinating {
    @Published var path = NavigationPath()

    func navigate(to route: AppRoute) {
        path.append(route)
    }

    func pop() {
        if !path.isEmpty {
            path.removeLast()
        }
    }

    func resetToRoot() {
        path = NavigationPath()
    }
}
