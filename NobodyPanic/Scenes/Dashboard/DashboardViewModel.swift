import SwiftUI

typealias DashboardVM = DashboardViewModelType
& DashboardViewModelInputs

protocol DashboardViewModelType {
    var inputs: DashboardViewModelInputs { get }
}

protocol DashboardViewModelInputs {
    func tappedCallEmergenyServices()
    func confirmCallEmergencyServices()
    func resetEmergencyServices()

    func confirmCaptureLicensePlates()
}

class DashboardViewModel: ObservableObject, DashboardVM {
    var inputs: any DashboardViewModelInputs { self }

    @Published var shouldCallEmergencyServices: Bool = false
    @Published var hasCalledEmergencyServices: Bool = false
    @Published var hasCapturedLicensePlates: Bool = false

    func tappedCallEmergenyServices() {
        shouldCallEmergencyServices = true
    }

    func confirmCallEmergencyServices() {
        hasCalledEmergencyServices = true
    }

    func resetEmergencyServices() {
        shouldCallEmergencyServices = false
    }

    func confirmCaptureLicensePlates() {
        hasCapturedLicensePlates = true
    }
}
