//
//  VibrationModeView.swift
//  SIGHTT
//
//  Created by Sam Canonaco on 2024-03-24.
//

import SwiftUI
import GameController

struct VibrationModeView: View {
    var controller : GCDualSenseGamepad
    @State var r2StartVibration : Float = 0
    @State var r2VibrationAmplitude : Float = 0
    @State var r2VibrationFrequency : Float = 0
    @State var l2StartVibration : Float = 0
    @State var l2VibrationAmplitude : Float = 0
    @State var l2VibrationFrequency : Float = 0
    
    @State var r2StartVibrationChanged : Bool = false
    @State var r2VibrationAmplitudeChanged : Bool = false
    @State var r2VibrationFrequencyChanged : Bool = false
    @State var l2StartVibrationChanged : Bool = false
    @State var l2VibrationAmplitudeChanged : Bool = false
    @State var l2VibrationFrequencyChanged : Bool = false
    
    var body: some View {
        Slider(value: $r2StartVibration, in:0...1,onEditingChanged: { editing in
            r2StartVibrationChanged=true
        })
        Text("R2 Vibration Start Point: \(r2StartVibration)")
            .foregroundColor(r2StartVibrationChanged ? .red : .blue)
        Slider(value: $r2VibrationAmplitude, in:0...1,onEditingChanged: { editing in
            r2VibrationAmplitudeChanged=true
        })
        Text("R2 Vibration Amplitude: \(r2VibrationAmplitude)")
            .foregroundColor(r2StartVibrationChanged ? .red : .blue)
        Slider(value: $r2VibrationFrequency, in:0...1,onEditingChanged: { editing in
            r2VibrationFrequencyChanged=true
        })
        Text("R2 Vibration Frequency: \(r2VibrationFrequency)")
            .foregroundColor(r2VibrationFrequencyChanged ? .red : .blue)
        Divider()
            .padding(.vertical)
        Slider(value: $l2StartVibration, in:0...1,onEditingChanged: { editing in
            l2StartVibrationChanged=true
        })
        Text("L2 Vibration Start Point: \(l2StartVibration)")
            .foregroundColor(l2StartVibrationChanged ? .red : .blue)
        Slider(value: $l2VibrationAmplitude, in:0...1,onEditingChanged: { editing in
            l2VibrationAmplitudeChanged=true
        })
        Text("L2 Vibration Amplitude: \(l2VibrationAmplitude)")
        Slider(value: $l2VibrationFrequency, in:0...1,onEditingChanged: { editing in
            l2VibrationFrequencyChanged=true
        })
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
        l2VibrationFrequencyChanged=false
        l2StartVibrationChanged=false
        l2VibrationAmplitudeChanged=false
        r2VibrationFrequencyChanged=false
        r2StartVibrationChanged=false
        r2VibrationAmplitudeChanged=false
        
        controller.leftTrigger.setModeVibrationWithStartPosition(l2StartVibration, amplitude: l2VibrationAmplitude, frequency: l2VibrationFrequency)
        controller.rightTrigger.setModeVibrationWithStartPosition(r2StartVibration, amplitude: r2VibrationAmplitude, frequency: r2VibrationFrequency)
    }
    func addToPlaylist(){
        PlaylistManager.shared.addItem(item: PlaylistItem(hapticModeL: .vibration, hapticModeR: .vibration,hapticValuesL: [l2StartVibration,l2VibrationAmplitude,l2VibrationFrequency],hapticValuesR: [r2StartVibration,r2VibrationAmplitude,r2VibrationFrequency]))
    }
}

#Preview {
    Text("test")
}
