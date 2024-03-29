//
//  LoopToggle.swift
//  SIGHTT
//
//  Created by Sam Canonaco on 2024-03-28.
//

import SwiftUI

struct LoopToggle: View {
    @ObservedObject var temp = PlaylistManager.shared.playlist
    var body: some View {
        Toggle("Loop Playlist", isOn: $temp.isLooping)
    }
}

#Preview {
    LoopToggle()
}
