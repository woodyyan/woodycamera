//
//  woodycameraApp.swift
//  Shared
//
//  Created by 颜松柏 on 2022/7/17.
//

import SwiftUI

@main
struct woodycameraApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
