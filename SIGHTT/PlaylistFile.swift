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

class Playlist: Codable, ObservableObject{
    enum CodingKeys: CodingKey {
        case id,list
    }
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(UUID.self, forKey: .id)
        list = try container.decode([PlaylistItem].self,forKey: .list)
    }
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(list, forKey: .list)
    }
    init(){}
    var id = UUID()
    @Published var list : [PlaylistItem] = [PlaylistItem]()
    
}

struct PlaylistItem: Codable, Identifiable{
    var id = UUID()
    var hapticModeL : HapticType
    var hapticModeR : HapticType
    var hapticValuesL : [Float] = [Float](repeating: 0, count: 11)
    var hapticValuesR : [Float] = [Float](repeating: 0, count: 11)
    var itemMode : ItemMode = .onTimer
    var timer: Float = 1.0
}

