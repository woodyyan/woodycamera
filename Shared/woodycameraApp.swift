//
//  woodycameraApp.swift
//  Shared
//
//  Created by 颜松柏 on 2022/7/17.
//

import SwiftUI

@main
struct woodycameraApp: App {
//    let persistenceController = PersistenceController.shared
    @StateObject var dataModel = DataModel()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(dataModel)
//                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
