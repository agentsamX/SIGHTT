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
            CommandMenu("Playlist"){
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
                        let filename = panel.url?.lastPathComponent ?? "<none>"
                        PlaylistManager.shared.loadJSON(file: filename)
                    }
                }
                Button("Save Playlist File"){
                    if(PlaylistManager.shared.playlist.list.count>0){
                        let panel = NSSavePanel()
                        panel.allowedContentTypes = [UTType.json]
                        panel.begin { (result: NSApplication.ModalResponse) -> Void in
                            if result == NSApplication.ModalResponse.OK {
                                if let panelURL = panel.url {
                                    PlaylistManager.shared.saveJSON(location: panelURL)
                                }
                            }
                        }
                    }
                    else{
                        let alert = NSAlert()
                        alert.messageText = "Warning"
                        alert.icon = NSImage(named: NSImage.cautionName)
                        alert.informativeText = "There are no items in the current playlist"
                        alert.addButton(withTitle: "OK")
                        alert.alertStyle = .warning
                        if (alert.runModal() == NSApplication.ModalResponse.alertFirstButtonReturn){}
                    }
                }
            }
        }
        Window("Playlist Manager", id:"playlist-manager"){
            PlaylistManagerView()
        }
    }
}
