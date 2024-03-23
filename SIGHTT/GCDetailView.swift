//
//  GCDetailView.swift
//  SIGHTT
//
//  Created by Sam Canonaco on 2024-03-22.
//

import SwiftUI
import GameController

struct GCDetailView: View {
    let controller : GCController
    
    enum HapticType: String, CaseIterable, Identifiable {
        case none, feedback, weapon, vibration, slope
        var id: Self { self }
    }
    
    @State private var feedbackMode: HapticType = .feedback

    
    var body: some View {
        HStack(alignment: .top)
        {
            VStack(alignment: .leading){
                Text("Name: " + (controller.vendorName ?? "Unknown Controller"))
                Text("Input Profile: " + controller.physicalInputProfile.className)
            }
            
            VStack{
                if(controller.physicalInputProfile.className==GCDualSenseGamepad.className()){
                    Picker("Feedback Mode", selection: $feedbackMode){
                        Text("Simple Feedback").tag(HapticType.feedback)
                        Text("Weapon Feedback").tag(HapticType.weapon)
                        Text("Vibration").tag(HapticType.vibration)
                        Text("Slope Feedback").tag(HapticType.slope)
                    }
                    switch feedbackMode {
                    case .none:
                        Text("No Feedback Mode Selected")
                    case .feedback:
                        StartStrengthView(controller: controller.physicalInputProfile as! GCDualSenseGamepad)
                    case .weapon:
                        WeaponModeView(controller: controller.physicalInputProfile as!
                            GCDualSenseGamepad)
                    case .vibration:
                        Text("Vibration Feedback Mode Selected")
                    case .slope:
                        SlopeModeView(controller: controller.physicalInputProfile as!
                            GCDualSenseGamepad)
                    }
               }
            }
        }
    }
}

#Preview {
    Text("Hello, World!")
}
