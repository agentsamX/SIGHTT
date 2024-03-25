//
//  PlaylistManager.swift
//  SIGHTT
//
//  Created by Sam Canonaco on 2024-03-24.
//

import Foundation

class PlaylistManager {
    static let shared = PlaylistManager()
    var playlist: Playlist = Playlist()

    private init() { }
    
    func addItem(item: PlaylistItem)
    {
        playlist.list.append(item)
    }
    func loadJSON()
    {
        
    }
    func printCount()
    {
        print("There are \(playlist.list.count) items in the playlist")
    }
}
