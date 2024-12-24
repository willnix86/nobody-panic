import SwiftUI

@main
struct NobodyPanicApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            AppCoordinatorView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
