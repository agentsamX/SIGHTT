//
//  PlaylistManagerView.swift
//  SIGHTT
//
//  Created by Sam Canonaco on 2024-03-24.
//

import SwiftUI

struct PlaylistManagerView: View {
    @ObservedObject var playlist = PlaylistManager.shared.playlist
    var body: some View {
        ScrollView{
            ForEach(PlaylistManager.shared.playlist.list){item in
                HStack{
                    Text("This is an item")
                    Button("Remove"){
                        PlaylistManager.shared.playlist.list.removeAll(where: {$0.id == item.id})
                    }
                }
            }
        }
    }
}

#Preview {
    PlaylistManagerView()
}
