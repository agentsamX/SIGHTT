//
//  WeaponModeView.swift
//  SIGHTT
//
//  Created by Sam Canonaco on 2024-03-23.
//

import SwiftUI
import GameController

struct WeaponModeView: View {
    var controller : GCDualSenseGamepad
    @State var r2StartResist : Float = 0
    @State var r2EndResist : Float = 1
    @State var r2ResistStrength : Float = 0
    @State var l2StartResist : Float = 0
    @State var l2EndResist : Float = 1
    @State var l2ResistStrength : Float = 0
    
    @State var r2StartResistChanged : Bool = false
    @State var r2EndResistChanged : Bool = false
    @State var r2ResistStrengthChanged : Bool = false
    @State var l2StartResistChanged : Bool = false
    @State var l2EndResistChanged : Bool = false
    @State var l2ResistStrengthChanged : Bool = false
    
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
        Slider(value: $r2ResistStrength, in:0...1,onEditingChanged: { editing in
            r2ResistStrengthChanged=true
        })
        Text("R2 Resistance Strength: \(r2ResistStrength)")
            .foregroundColor(r2ResistStrengthChanged ? .red : .blue)
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
        Slider(value: $l2ResistStrength, in:0...1,onEditingChanged: { editing in
            l2ResistStrengthChanged=true
        })
        Text("L2 Resistance Strength: \(l2ResistStrength)")
            .foregroundColor(l2ResistStrengthChanged ? .red : .blue)
        Divider()
            .padding(.vertical)
        HStack(){
            Button(action: applyDSSettings) {
                Text("Apply Settings")
            }
            Button(action: resetDSSettings) {
                Text("Reset Settings")
            }
        }
        .padding(.bottom)
    }
    
    func applyDSSettings(){
        l2ResistStrengthChanged=false
        l2StartResistChanged=false
        l2EndResistChanged=false
        r2ResistStrengthChanged=false
        r2StartResistChanged=false
        r2EndResistChanged=false
        
        if(l2StartResist<l2EndResist){
            controller.leftTrigger.setModeWeaponWithStartPosition(l2StartResist, endPosition: l2EndResist, resistiveStrength: l2ResistStrength)
        }
        if(r2StartResist<r2EndResist){
            controller.rightTrigger.setModeWeaponWithStartPosition(r2StartResist, endPosition: r2EndResist, resistiveStrength: r2ResistStrength)
        }
    }
    func resetDSSettings(){

    }
}

#Preview {
    Text("test")
    //WeaponModeView()
}
