//
//  PlaylistFile.swift
//  SIGHTT
//
//  Created by Sam Canonaco on 2024-03-24.
//

import Foundation

enum ItemMode: String, CaseIterable, Identifiable,Codable {
    case onTimer, onProgramInput, onControllerInput
    var id: Self { self }
}

class Playlist: Codable{
    var id = UUID()
    var list : [PlaylistItem] = [PlaylistItem]()
    
}

struct PlaylistItem: Codable{
    var id = UUID()
    var hapticModeL : HapticType
    var hapticModeR : HapticType
    var itemMode : ItemMode = .onTimer
    var timer: Float = 1.0
}

