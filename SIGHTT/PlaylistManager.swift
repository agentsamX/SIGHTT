//
//  PlaylistManager.swift
//  SIGHTT
//
//  Created by Sam Canonaco on 2024-03-24.
//

import Foundation

class PlaylistManager{
    static let shared = PlaylistManager()
    let fileManager = FileManager.default
    var playlist: Playlist = Playlist()

    private init() { }
    
    func addItem(item: PlaylistItem){
        playlist.list.append(item)
    }
    func loadJSON(file: String){
        
    }
    func saveJSON(location: URL){
        
    }
    func printCount(){
        print("There are \(playlist.list.count) items in the playlist")
    }
}
