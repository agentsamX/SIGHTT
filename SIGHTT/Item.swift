//
//  Item.swift
//  SIGHTT
//
//  Created by Sam Canonaco on 2024-03-22.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
