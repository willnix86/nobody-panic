enum AppRoute: Hashable {
    case emergencyServices(hasCapturedLicencePlates: Bool)
    case licensePlates(hasCalledEmergencyServices: Bool)
}
