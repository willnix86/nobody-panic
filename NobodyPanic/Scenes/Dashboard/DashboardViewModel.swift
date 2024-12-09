import SwiftUI

typealias DaboardVM = DashboardViewModelType
& DashboardViewModelInputs
& DashboardViewModelOutputs

protocol DashboardViewModelType {
    var inputs: DashboardViewModelInputs { get }
    var outputs: DashboardViewModelOutputs { get }
}

protocol DashboardViewModelInputs {
    func tappedCallEmergenyServices()
    func callEmergencyServices()
    func resetEmergencyServices()
    func tappedGetLicencePlates()
}

protocol DashboardViewModelOutputs {
    var shouldCallEmergencyServices: Bool { get }
    var isEmergencyServicesCalled: Bool { get }
    var isGettingLicencePlates: Bool { get }

}

class DashboardViewModel: ObservableObject, DaboardVM {
    var inputs: any DashboardViewModelInputs { self }
    var outputs: any DashboardViewModelOutputs { self }

    @Published var shouldCallEmergencyServices: Bool = false
    @Published var isEmergencyServicesCalled: Bool = false
    @Published var isGettingLicencePlates: Bool = false

    func tappedCallEmergenyServices() {
        shouldCallEmergencyServices = true
    }

    func callEmergencyServices() {
        // TODO:
        isEmergencyServicesCalled = true
    }

    func resetEmergencyServices() {
        shouldCallEmergencyServices = false
    }

    func tappedGetLicencePlates() {
        isGettingLicencePlates = true
    }
}
