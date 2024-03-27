//
//  PlaylistManager.swift
//  SIGHTT
//
//  Created by Sam Canonaco on 2024-03-24.
//

import Foundation
import SwiftUI

class PlaylistManager{
    static let shared = PlaylistManager()
    let fileManager = FileManager.default
    var playlist: Playlist = Playlist()

    private init() { }
    
    func addItem(item: PlaylistItem){
        playlist.list.append(item)
    }
    func loadJSON(file: URL){
        do{
            let json = try String(contentsOf: file).data(using: .utf8)!
            let decoder = JSONDecoder()
            let newList = try decoder.decode([PlaylistItem].self, from: json)
            playlist.list=newList
        } catch {
            let alert = NSAlert()
            alert.messageText = "Warning"
            alert.icon = NSImage(named: NSImage.cautionName)
            alert.informativeText = "JSON file is invalid"
            alert.addButton(withTitle: "OK")
            alert.alertStyle = .warning
            if (alert.runModal() == NSApplication.ModalResponse.alertFirstButtonReturn){}
            return
        }
    }
    func saveJSON(location: URL){
        let json = try? JSONEncoder().encode(playlist.list)
        
        do {
            try json!.write(to: location)
        } catch {
            print("Failed to write JSON data: \(error.localizedDescription)")
        }
    }
    func printCount(){
        print("There are \(playlist.list.count) items in the playlist")
    }
}
