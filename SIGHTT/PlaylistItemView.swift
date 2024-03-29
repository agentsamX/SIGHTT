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
            VStack(alignment: .leading){
                Text("TypeL: "+item.hapticModeL.rawValue)
                    .multilineTextAlignment(.leading)
                Text("TypeR: "+item.hapticModeR.rawValue)
                    .multilineTextAlignment(.leading)
            }
            .padding(.trailing)
            .frame(width: 300)
            Text("Timer: ")
                .padding(.leading)
            TextField("Timer:",value: $timerLength,format: .number)
                .padding(.trailing)
                .onSubmit {
                    playlist.list[playlist.list.lastIndex(where: {$0.id == item.id})!]=PlaylistItem.init(item: item, newTimer: timerLength)
            }
            Button("Remove"){
                playlist.list.removeAll(where: {$0.id == item.id})
            }
            .padding(.trailing)
        }
        .background(item.id==playlist.currentItemID() ? Color.blue :Color.clear)

    }
}

#Preview {
    Text("test")
}
