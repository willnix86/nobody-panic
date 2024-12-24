
import SwiftUI

typealias LicensePlatesVM = LicensePlatesViewModelType
& LicensePlatesViewModelInputs

protocol LicensePlatesViewModelType {
    var inputs: LicensePlatesViewModelInputs { get }
}

protocol LicensePlatesViewModelInputs {
    func addLicensePlate()
    func removeLicensePlate(at index: Int)
    func captureWithCamera(for index: Int)
    func removePhoto(at index: Int)
}

final class LicensePlatesViewModel: ObservableObject, LicensePlatesVM {
    var inputs: any LicensePlatesViewModelInputs { self }

    @Published var licensePlates: [String] = [""] // Include an initial blank license plate
    @Published var licensePlatePhotos: [UIImage?] = [nil] // Include an initial nil photo value
    @Published var currentLicensePlateIndex: Int = 0
    @Published var isPresentingCamera: Bool = false

    var licensePlateCount: Int {
        licensePlates.count
    }

    var hasCapturedLicensePlates: Bool {
        let hasLicensePlateText = licensePlates.contains {
            !$0.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
        }
        let hasLicensePlatePhoto = licensePlatePhotos.contains {
            $0 != nil
        }

        return hasLicensePlateText || hasLicensePlatePhoto
    }

    func addLicensePlate() {
        licensePlates.append("")
        licensePlatePhotos.append(nil)
    }

    func removeLicensePlate(at index: Int) {
        guard licensePlates.indices.contains(index) else { return }
        licensePlates.remove(at: index)
        licensePlatePhotos.remove(at: index)
    }

    func captureWithCamera(for index: Int) {
        currentLicensePlateIndex = index
        isPresentingCamera = true
    }

    func removePhoto(at index: Int) {
        guard licensePlatePhotos.indices.contains(index) else { return }
        licensePlatePhotos[index] = nil
    }
}
