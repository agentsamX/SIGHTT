//
//  SIGHTTApp.swift
//  SIGHTT
//
//  Created by Sam Canonaco on 2024-03-22.
//

import SwiftUI
import SwiftData
import UniformTypeIdentifiers

@main
struct SIGHTTApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .defaultSize(width: 1200, height: 800)
        .commands{
            CommandMenu("Playlist")
            {
                Button("Add Current Settings") {}
                    .keyboardShortcut("a",modifiers: [.command,.shift])
                Button("Print Playlist Count") {
                    PlaylistManager.shared.printCount()
                }
                Button("Load Playlist File"){
                    let panel = NSOpenPanel()
                    panel.allowsMultipleSelection=false
                    panel.canChooseDirectories=false
                    panel.allowedContentTypes=[UTType.json]
                    if panel.runModal() == .OK {
                        var filename = panel.url?.lastPathComponent ?? "<none>"
                    }
                }
            }
        }
        Window("Playlist Manager", id:"playlist-manager")
        {
            PlaylistManagerView()
        }
    }
}
