//
//  PositionalFeedbackModeView.swift
//  SIGHTT
//
//  Created by Sam Canonaco on 2024-03-24.
//

import SwiftUI
import GameController
import Sliders

struct PositionalFeedbackModeView: View {
    var controller : GCDualSenseGamepad
    @State var r2PositionalStrengths: [IDFloat] = [
        IDFloat(value: 0), IDFloat(value: 0), IDFloat(value: 0), IDFloat(value: 0), IDFloat(value: 0),
        IDFloat(value: 0), IDFloat(value: 0), IDFloat(value: 0), IDFloat(value: 0), IDFloat(value: 0)
    ]
    
    @State var l2PositionalStrengths: [IDFloat] = [
        IDFloat(value: 0), IDFloat(value: 0), IDFloat(value: 0), IDFloat(value: 0), IDFloat(value: 0),
        IDFloat(value: 0), IDFloat(value: 0), IDFloat(value: 0), IDFloat(value: 0), IDFloat(value: 0)
    ]

    
    var body: some View {
        Text("R2 Resistive Strengths")
        HStack{
            ForEach($r2PositionalStrengths){amplitude in
                ValueSlider(value: amplitude.value, in: 0...1)
                    .valueSliderStyle(VerticalValueSliderStyle())}
        }
        .padding([.bottom, .trailing])
        .frame(height: 120)
        Divider()
            .padding(.vertical)
        Text("L2 Resistive Strengths")
        HStack{
            ForEach($l2PositionalStrengths){amplitude in
                ValueSlider(value: amplitude.value, in: 0...1)
                    .valueSliderStyle(VerticalValueSliderStyle())}
        }
        .padding([.bottom, .trailing])
        .frame(height: 120)
        Divider()
            .padding(.vertical)
        HStack(){
            Button(action: applyDSSettings) {
                Text("Apply Settings")
            }
            Button(action: addToPlaylist) {
                Text("Add To Playlist")
            }
        }
        .padding(.bottom)
    }
    
    func applyDSSettings(){
        
        controller.rightTrigger.setModeFeedback(resistiveStrengths: GCDualSenseAdaptiveTrigger.PositionalResistiveStrengths(values: (r2PositionalStrengths[0].value,r2PositionalStrengths[1].value,r2PositionalStrengths[2].value,r2PositionalStrengths[3].value,r2PositionalStrengths[4].value,r2PositionalStrengths[5].value,r2PositionalStrengths[6].value,r2PositionalStrengths[7].value,r2PositionalStrengths[8].value,r2PositionalStrengths[9].value)))
        controller.leftTrigger.setModeFeedback(resistiveStrengths: GCDualSenseAdaptiveTrigger.PositionalResistiveStrengths(values: (l2PositionalStrengths[0].value,l2PositionalStrengths[1].value,l2PositionalStrengths[2].value,l2PositionalStrengths[3].value,l2PositionalStrengths[4].value,l2PositionalStrengths[5].value,l2PositionalStrengths[6].value,l2PositionalStrengths[7].value,l2PositionalStrengths[8].value,l2PositionalStrengths[9].value)))
    }
    
    func addToPlaylist(){
        PlaylistManager.shared.addItem(item: PlaylistItem(hapticModeL: .feedbackPositional, hapticModeR: .feedbackPositional,hapticValuesL: [l2PositionalStrengths[0].value,l2PositionalStrengths[1].value,l2PositionalStrengths[2].value,l2PositionalStrengths[3].value,l2PositionalStrengths[4].value,l2PositionalStrengths[5].value,l2PositionalStrengths[6].value,l2PositionalStrengths[7].value,l2PositionalStrengths[8].value,l2PositionalStrengths[9].value],hapticValuesR: [r2PositionalStrengths[0].value,r2PositionalStrengths[1].value,r2PositionalStrengths[2].value,r2PositionalStrengths[3].value,r2PositionalStrengths[4].value,r2PositionalStrengths[5].value,r2PositionalStrengths[6].value,r2PositionalStrengths[7].value,r2PositionalStrengths[8].value,r2PositionalStrengths[9].value]))
    }
}

#Preview {
    Text("test")
}
