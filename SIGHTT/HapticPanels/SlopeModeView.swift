//
//  SlopeModeView.swift
//  SIGHTT
//
//  Created by Sam Canonaco on 2024-03-23.
//

import SwiftUI
import GameController

struct SlopeModeView: View {
    var controller : GCDualSenseGamepad
    @State var r2StartResist : Float = 0
    @State var r2EndResist : Float = 1
    @State var r2StartResistStrength : Float = 0
    @State var r2EndResistStrength : Float = 0

    @State var l2StartResist : Float = 0
    @State var l2EndResist : Float = 1
    @State var l2StartResistStrength : Float = 0
    @State var l2EndResistStrength : Float = 0
    
    @State var r2StartResistChanged : Bool = false
    @State var r2EndResistChanged : Bool = false
    @State var r2StartResistStrengthChanged : Bool = false
    @State var r2EndResistStrengthChanged : Bool = false

    @State var l2StartResistChanged : Bool = false
    @State var l2EndResistChanged : Bool = false
    @State var l2StartResistStrengthChanged : Bool = false
    @State var l2EndResistStrengthChanged : Bool = false
    
    var body: some View {
        Slider(value: $r2StartResist, in:0...1,onEditingChanged: { editing in
            r2StartResistChanged=true
        })
        Text("R2 Resistance Start Point: \(r2StartResist)")
            .foregroundColor(r2StartResistChanged ? .red : .blue)
        Slider(value: $r2EndResist, in:0...1,onEditingChanged: { editing in
            r2EndResistChanged=true
        })
        Text("R2 Resistance End Point: \(r2EndResist)")
            .foregroundColor(r2StartResistChanged ? .red : .blue)
        Slider(value: $r2StartResistStrength, in:0...1,onEditingChanged: { editing in
            r2StartResistStrengthChanged=true
        })
        Text("R2 Start Resistance Strength: \(r2StartResistStrength)")
            .foregroundColor(r2StartResistStrengthChanged ? .red : .blue)
        Slider(value: $r2EndResistStrength, in:0...1,onEditingChanged: { editing in
            r2EndResistStrengthChanged=true
        })
        Text("R2 End Resistance Strength: \(r2EndResistStrength)")
            .foregroundColor(r2StartResistStrengthChanged ? .red : .blue)
        Divider()
            .padding(.vertical)
        Slider(value: $l2StartResist, in:0...1,onEditingChanged: { editing in
            l2StartResistChanged=true
        })
        Text("L2 Resistance Start Point: \(l2StartResist)")
            .foregroundColor(l2StartResistChanged ? .red : .blue)
        Slider(value: $l2EndResist, in:0...1,onEditingChanged: { editing in
            l2EndResistChanged=true
        })
        Text("L2 Resistance End Point: \(l2EndResist)")
        Slider(value: $l2StartResistStrength, in:0...1,onEditingChanged: { editing in
            l2StartResistStrengthChanged=true
        })
        Text("L2 Resistance Strength: \(l2StartResistStrength)")
            .foregroundColor(l2StartResistStrengthChanged ? .red : .blue)
        Slider(value: $l2EndResistStrength, in:0...1,onEditingChanged: { editing in
            l2EndResistStrengthChanged=true
        })
        Text("L2 Resistance Strength: \(l2EndResistStrength)")
            .foregroundColor(l2EndResistStrengthChanged ? .red : .blue)
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
        l2StartResistStrengthChanged=false
        l2EndResistStrengthChanged=false
        l2StartResistChanged=false
        l2EndResistChanged=false
        r2StartResistStrengthChanged=false
        r2EndResistStrengthChanged=false
        r2StartResistChanged=false
        r2EndResistChanged=false
        
        if(l2StartResist<l2EndResist){
            controller.leftTrigger.setModeSlopeFeedback(startPosition: l2StartResist, endPosition: l2EndResist, startStrength: l2StartResistStrength, endStrength: l2EndResistStrength)
        }
        if(r2StartResist<r2EndResist){
            controller.rightTrigger.setModeSlopeFeedback(startPosition: r2StartResist, endPosition: r2EndResist, startStrength: r2StartResistStrength, endStrength: r2EndResistStrength)
        }
    }
    func addToPlaylist()
    {
        PlaylistManager.shared.addItem(item: PlaylistItem(hapticModeL: .weapon, hapticModeR: .weapon, hapticValuesL:[l2StartResist,l2EndResist,l2StartResistStrength,l2EndResistStrength], hapticValuesR:[r2StartResist,r2EndResist,r2StartResistStrength,r2EndResistStrength]))
    }
}

#Preview {
    Text("text")
}
