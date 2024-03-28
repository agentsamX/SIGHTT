//
//  GCDetailView.swift
//  SIGHTT
//
//  Created by Sam Canonaco on 2024-03-22.
//

import SwiftUI
import GameController

enum HapticType: String, CaseIterable, Identifiable,Codable {
    case none, feedback, weapon, vibration, slope, feedbackPositional, vibrationPositional
    var id: Self { self }
}

struct GCDetailView: View {
    let controller : GCController
    
    @State private var feedbackMode: HapticType = .feedback

    
    var body: some View {
        HStack(alignment: .top)
        {
            VStack(alignment: .leading){
                Text("Name: " + (controller.vendorName ?? "Unknown Controller"))
                Text("Input Profile: " + controller.physicalInputProfile.className)
            }
            .padding(.all)
            VStack{
                if(controller.physicalInputProfile is GCDualSenseGamepad){ // make sure this works
                    let _ = PlaylistManager.shared.playlist.activeController=(controller.physicalInputProfile as! GCDualSenseGamepad) //make sure to handle disconnects
                    Picker("Feedback Mode", selection: $feedbackMode){
                        Text("Simple Feedback").tag(HapticType.feedback)
                        Text("Weapon Feedback").tag(HapticType.weapon)
                        Text("Vibration").tag(HapticType.vibration)
                        Text("Slope Feedback").tag(HapticType.slope)
                        Text("Positional Vibration").tag(HapticType.vibrationPositional)
                        Text("Feedback Positional").tag(HapticType.feedbackPositional)
                    }
                    .padding([.top, .leading, .trailing])
                    ScrollView{
                        switch feedbackMode {
                        case .none:
                            Text("No Feedback Mode Selected")
                        case .feedback:
                            StartStrengthView(controller: controller.physicalInputProfile as! GCDualSenseGamepad)
                        case .weapon:
                            WeaponModeView(controller: controller.physicalInputProfile as! GCDualSenseGamepad)
                        case .vibration:
                            VibrationModeView(controller: controller.physicalInputProfile as! GCDualSenseGamepad)
                        case .slope:
                            SlopeModeView(controller: controller.physicalInputProfile as! GCDualSenseGamepad)
                        case .feedbackPositional:
                            PositionalFeedbackModeView(controller: controller.physicalInputProfile as! GCDualSenseGamepad)
                        case .vibrationPositional:
                            PositionalVibrationModeView(controller: controller.physicalInputProfile as! GCDualSenseGamepad)
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    Text("Hello, World!")
}
