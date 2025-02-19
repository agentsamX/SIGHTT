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
            CommandGroup(before: CommandGroupPlacement.newItem){
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
                }.keyboardShortcut("s")
                Button("Load Playlist File"){
                    let panel = NSOpenPanel()
                    panel.allowsMultipleSelection=false
                    panel.canChooseDirectories=false
                    panel.allowedContentTypes=[UTType.json]
                    panel.begin { (result: NSApplication.ModalResponse)-> Void in
                        if result == NSApplication.ModalResponse.OK {
                            if let panelURL = panel.url {
                                PlaylistManager.shared.loadJSON(file: panelURL)
                            }
                        }
                    }
                }.keyboardShortcut("l")
            }
            CommandMenu("Playlist"){
                Button("Play Playlist") {
                    if(!PlaylistManager.shared.playlist.isPlaying){
                        PlaylistManager.shared.playlist.playList()
                    }
                }.keyboardShortcut("p",modifiers: [.command,.shift])
                Button("Stop Playlist") {
                    PlaylistManager.shared.playlist.stopList()
                    PlaylistManager.shared.printCount()
                }.keyboardShortcut("o",modifiers: [.command,.shift])
                LoopToggle().keyboardShortcut("l",modifiers: [.command,.shift])
                Button("Skip Current Item") {
                    PlaylistManager.shared.playlist.skipItem()
                }.keyboardShortcut("s",modifiers: [.command,.shift])
            }
        }
        Window("Playlist Manager", id:"playlist-manager"){
            PlaylistManagerView()
        }.keyboardShortcut("p")
    }
}
