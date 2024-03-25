//
//  PlaylistItem.swift
//  SIGHTT
//
//  Created by Sam Canonaco on 2024-03-24.
//

import Foundation
struct PlaylistItem: Codable{
    var mode : HapticType
    var onTimer: Bool = false
    var onInput: Bool = false
}
