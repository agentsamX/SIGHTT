//
//  PositionalVibrationModeView.swift
//  SIGHTT
//
//  Created by Sam Canonaco on 2024-03-24.
//

import SwiftUI
import GameController
import Sliders

struct IDFloat: Identifiable {
    var id = UUID()
    var value: Float
}

struct PositionalVibrationModeView: View {
    var controller : GCDualSenseGamepad
    @State var r2PositionalAmplitudes: [IDFloat] = [
        IDFloat(value: 0), IDFloat(value: 0), IDFloat(value: 0), IDFloat(value: 0), IDFloat(value: 0),
        IDFloat(value: 0), IDFloat(value: 0), IDFloat(value: 0), IDFloat(value: 0), IDFloat(value: 0)
    ]
    @State var r2VibrationFrequency: Float = 0
    @State var r2VibrationFrequencyChanged : Bool = false
    
    @State var l2PositionalAmplitudes: [IDFloat] = [
        IDFloat(value: 0), IDFloat(value: 0), IDFloat(value: 0), IDFloat(value: 0), IDFloat(value: 0),
        IDFloat(value: 0), IDFloat(value: 0), IDFloat(value: 0), IDFloat(value: 0), IDFloat(value: 0)
    ]
    @State var l2VibrationFrequency: Float = 0
    @State var l2VibrationFrequencyChanged : Bool = false

    
    var body: some View {
        Text("R2 Vibration Amplitudes")
        HStack{
            ForEach($r2PositionalAmplitudes){amplitude in
                ValueSlider(value: amplitude.value, in: 0...1)
                    .valueSliderStyle(VerticalValueSliderStyle())}
        }
        .padding([.bottom, .trailing])
        .frame(height: 120)
        Slider(value: $r2VibrationFrequency, in:0...1,onEditingChanged: { editing in
            r2VibrationFrequencyChanged=true
        })
        .padding(.trailing)
        Text("R2 Vibration Frequency: \(r2VibrationFrequency)")
            .foregroundColor(r2VibrationFrequencyChanged ? .red : .blue)
        Divider()
            .padding(.vertical)
        Text("L2 Vibration Amplitudes")
        HStack{
            ForEach($l2PositionalAmplitudes){amplitude in
                ValueSlider(value: amplitude.value, in: 0...1)
                    .valueSliderStyle(VerticalValueSliderStyle())}
        }
        .padding([.bottom, .trailing])
        .frame(height: 120)
        Slider(value: $l2VibrationFrequency, in:0...1,onEditingChanged: { editing in
            l2VibrationFrequencyChanged=true
        })
        .padding(.trailing)
        Text("L2 Vibration Frequency: \(l2VibrationFrequency)")
            .foregroundColor(l2VibrationFrequencyChanged ? .red : .blue)
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
        
        controller.rightTrigger.setModeVibration(amplitudes: GCDualSenseAdaptiveTrigger.PositionalAmplitudes(values: (r2PositionalAmplitudes[0].value,r2PositionalAmplitudes[1].value,r2PositionalAmplitudes[2].value,r2PositionalAmplitudes[3].value,r2PositionalAmplitudes[4].value,r2PositionalAmplitudes[5].value,r2PositionalAmplitudes[6].value,r2PositionalAmplitudes[7].value,r2PositionalAmplitudes[8].value,r2PositionalAmplitudes[9].value)), frequency: r2VibrationFrequency)
        controller.leftTrigger.setModeVibration(amplitudes: GCDualSenseAdaptiveTrigger.PositionalAmplitudes(values: (l2PositionalAmplitudes[0].value,l2PositionalAmplitudes[1].value,l2PositionalAmplitudes[2].value,l2PositionalAmplitudes[3].value,l2PositionalAmplitudes[4].value,l2PositionalAmplitudes[5].value,l2PositionalAmplitudes[6].value,l2PositionalAmplitudes[7].value,l2PositionalAmplitudes[8].value,l2PositionalAmplitudes[9].value)), frequency: l2VibrationFrequency)
    }
    
    func addToPlaylist(){
        PlaylistManager.shared.addItem(item: PlaylistItem(hapticModeL: .vibrationPositional, hapticModeR: .vibrationPositional,hapticValuesL: [l2PositionalAmplitudes[0].value,l2PositionalAmplitudes[1].value,l2PositionalAmplitudes[2].value,l2PositionalAmplitudes[3].value,l2PositionalAmplitudes[4].value,l2PositionalAmplitudes[5].value,l2PositionalAmplitudes[6].value,l2PositionalAmplitudes[7].value,l2PositionalAmplitudes[8].value,l2PositionalAmplitudes[9].value,l2VibrationFrequency],hapticValuesR: [r2PositionalAmplitudes[0].value,r2PositionalAmplitudes[1].value,r2PositionalAmplitudes[2].value,r2PositionalAmplitudes[3].value,r2PositionalAmplitudes[4].value,r2PositionalAmplitudes[5].value,r2PositionalAmplitudes[6].value,r2PositionalAmplitudes[7].value,r2PositionalAmplitudes[8].value,r2PositionalAmplitudes[9].value,r2VibrationFrequency]))
    }
    
}

#Preview {
    Text("test")
}
