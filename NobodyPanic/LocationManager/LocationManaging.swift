import CoreLocation

struct UserLocation {
    var coordinates: CLLocationCoordinate2D
    var address: String?
    var countryCode: String?
}

protocol LocationManaging {
    func getUserLocation() async -> UserLocation?
}

@MainActor
class LocationManager: LocationManaging {
    func getUserLocation() async -> UserLocation? {
        let service = LocationManagerInternal()
        return await service.getUserLocation()
    }
}

private class LocationManagerInternal: NSObject, CLLocationManagerDelegate {
    private let manager = CLLocationManager()
    private var continuation: CheckedContinuation<UserLocation?, Never>?

    override init() {
        super.init()
        manager.delegate = self
    }

    func getUserLocation() async -> UserLocation? {
        guard CLLocationManager.locationServicesEnabled() else {
            return nil
        }

        return await withCheckedContinuation { continuation in
            self.continuation = continuation
            manager.requestWhenInUseAuthorization()
            manager.requestLocation()
        }
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.first else {
            continuation?.resume(returning: nil)
            continuation = nil
            return
        }

        let geocoder = CLGeocoder()
        geocoder.reverseGeocodeLocation(location) { placemarks, error in
            if let error = error {
                print("Reverse geocoding failed: \(error)")
                self.continuation?.resume(returning: nil)
            } else if let placemark = placemarks?.first {
                let address = [
                    placemark.name,
                    placemark.locality,
                    placemark.administrativeArea,
                    placemark.country
                ]
                    .compactMap { $0 }
                    .joined(separator: ", ")

                let userLocation = UserLocation(
                    coordinates: location.coordinate,
                    address: address,
                    countryCode: placemark.isoCountryCode
                )
                self.continuation?.resume(returning: userLocation)
            } else {
                self.continuation?.resume(returning: nil)
            }
            self.continuation = nil
        }
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Location failed: \(error)")
        continuation?.resume(returning: nil)
        continuation = nil
    }
}
