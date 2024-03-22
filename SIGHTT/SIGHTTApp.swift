//
//  SIGHTTApp.swift
//  SIGHTT
//
//  Created by Sam Canonaco on 2024-03-22.
//

import SwiftUI
import SwiftData

@main
struct SIGHTTApp: App {
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            Item.self,
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(sharedModelContainer)
        .commands{
            CommandMenu("Playlist")
            {
                Button("Add Current Settings") {}
                    .keyboardShortcut("a",modifiers: [.command,.shift])
            }
        }
    }
}
