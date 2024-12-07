//
//  Nobody_PanicApp.swift
//  Nobody Panic
//
//  Created by Will Nixon on 12/7/24.
//

import SwiftUI

@main
struct Nobody_PanicApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            DashboardView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
