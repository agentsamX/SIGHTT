//
//  GCDetailView.swift
//  SIGHTT
//
//  Created by Sam Canonaco on 2024-03-22.
//

import SwiftUI
import GameController

enum HapticType: String, CaseIterable, Identifiable,Codable {
    case none="none",
         feedback="Simple Resistive",
         weapon="Weapon Feedback",
         vibration="Vibration",
         slope="Slope Resistive",
         feedbackPositional="Positional Resistive",
         vibrationPositional="Positional Vibration"
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
                        Text(HapticType.feedback.rawValue).tag(HapticType.feedback)
                        Text(HapticType.weapon.rawValue).tag(HapticType.weapon)
                        Text(HapticType.vibration.rawValue).tag(HapticType.vibration)
                        Text(HapticType.slope.rawValue).tag(HapticType.slope)
                        Text(HapticType.vibrationPositional.rawValue).tag(HapticType.vibrationPositional)
                        Text(HapticType.feedbackPositional.rawValue).tag(HapticType.feedbackPositional)
                    }
                    .padding([.top, .leading, .trailing])
                    ScrollView{
                        switch feedbackMode {
                        case .none:
                            Text("No Feedback Mode Selected")
                        case .feedback:
                            FeedbackModeView(controller: controller.physicalInputProfile as! GCDualSenseGamepad)
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
