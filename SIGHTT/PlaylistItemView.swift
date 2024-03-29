//
//  PlaylistItemView.swift
//  SIGHTT
//
//  Created by Sam Canonaco on 2024-03-28.
//

import SwiftUI
import Combine

struct PlaylistItemView: View {
    var item: PlaylistItem
    @ObservedObject var playlist : Playlist
    @State private var timerLength : Float
    init(item: PlaylistItem) {
        self.item = item
        self.playlist =  PlaylistManager.shared.playlist
        self.timerLength = item.timer
    }
    var body: some View {
        HStack{
            VStack{
                Text("TypeL: "+item.hapticModeL.rawValue)
                Text("TypeR: "+item.hapticModeR.rawValue)
            }
            TextField("Timer:",value: $timerLength,format: .number)
                .onSubmit {
                    playlist.list[playlist.list.lastIndex(where: {$0.id == item.id})!]=PlaylistItem.init(item: item, newTimer: timerLength)
                }
            Button("Remove"){
                playlist.list.removeAll(where: {$0.id == item.id})
            }
        }
        .background(item.id==playlist.currentItemID() ? Color.blue :Color.clear)

    }
}

#Preview {
    Text("test")
}
