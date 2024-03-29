//
//  PlaylistFile.swift
//  SIGHTT
//
//  Created by Sam Canonaco on 2024-03-24.
//

import Foundation
import GameController

enum ItemMode: String, CaseIterable, Identifiable,Codable {
    case onTimer, onControllerInput
    var id: Self { self }
}

class Playlist: ObservableObject{
    /*enum CodingKeys: CodingKey {
        case id,list
    }
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(UUID.self, forKey: .id)
        list = try container.decode([PlaylistItem].self,forKey: .list)
    }
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(list, forKey: .list)
    }
    init(){}*/
    func playList(){
        if(activeController==nil){return}
        if(isPlaying){
            playIndex += 1
            if(playIndex>=list.count){
                if(isLooping){
                    playIndex=0
                }
                else{
                    isPlaying=false
                    return
                }
            }
            list[playIndex].play(controller: activeController!)
            switch list[playIndex].itemMode{
            case .onTimer:
                timer = Timer.scheduledTimer(withTimeInterval: TimeInterval(list[playIndex].timer), repeats: false) { timer in
                    self.playList()
                }
            case .onControllerInput:
                print("feature not yet implemented 🤪")
            }
            
        } else {
            playIndex = -1
            isPlaying = true
            playList()
        }
    }
    func stopList(){
        timer?.invalidate()
        isPlaying=false
    }
    func currentItemID()->UUID?{
        if(isPlaying){
            return list[playIndex].id
        }
        return nil
    }
    var id = UUID()
    @Published var isPlaying = false
    @Published var isLooping = false
    var timer: Timer? = nil
    @Published var playIndex = 0
    @Published var list : [PlaylistItem] = [PlaylistItem]()
    var activeController : GCDualSenseGamepad? = nil
    
}

struct PlaylistItem: Codable, Identifiable{
    func play(controller: GCDualSenseGamepad){
        switch hapticModeL {
        case .none:
            print("No haptics assigned")
        case .feedback:
            controller.leftTrigger.setModeFeedbackWithStartPosition(hapticValuesL[0], resistiveStrength: hapticValuesL[1])
        case .weapon:
            if(hapticValuesL[0]<hapticValuesL[1]){
                controller.leftTrigger.setModeWeaponWithStartPosition(hapticValuesL[0], endPosition: hapticValuesL[1], resistiveStrength: hapticValuesL[2])
            }
        case .vibration:
            controller.leftTrigger.setModeVibrationWithStartPosition(hapticValuesL[0], amplitude: hapticValuesL[1], frequency: hapticValuesL[2])
        case .slope:
            if(hapticValuesL[0]<hapticValuesL[1]){
                controller.leftTrigger.setModeSlopeFeedback(startPosition: hapticValuesL[0], endPosition: hapticValuesL[1], startStrength: hapticValuesL[2], endStrength: hapticValuesL[3])
            }
        case .feedbackPositional:
            controller.leftTrigger.setModeFeedback(resistiveStrengths: GCDualSenseAdaptiveTrigger.PositionalResistiveStrengths(values: (hapticValuesL[0],hapticValuesL[1],hapticValuesL[2],hapticValuesL[3],hapticValuesL[4],hapticValuesL[5],hapticValuesL[6],hapticValuesL[7],hapticValuesL[8],hapticValuesL[9])))
        case .vibrationPositional:
            controller.leftTrigger.setModeVibration(amplitudes: GCDualSenseAdaptiveTrigger.PositionalAmplitudes(values: (hapticValuesL[0],hapticValuesL[1],hapticValuesL[2],hapticValuesL[3],hapticValuesL[4],hapticValuesL[5],hapticValuesL[6],hapticValuesL[7],hapticValuesL[8],hapticValuesL[9])), frequency: hapticValuesL[10])
        }
        
        switch hapticModeR {
        case .none:
            print("No haptics assigned")
        case .feedback:
            controller.rightTrigger.setModeFeedbackWithStartPosition(hapticValuesR[0], resistiveStrength: hapticValuesR[1])
        case .weapon:
            if(hapticValuesR[0]<hapticValuesR[1]){
                controller.rightTrigger.setModeWeaponWithStartPosition(hapticValuesR[0], endPosition: hapticValuesR[1], resistiveStrength: hapticValuesR[2])
            }
        case .vibration:
            controller.rightTrigger.setModeVibrationWithStartPosition(hapticValuesR[0], amplitude: hapticValuesR[1], frequency: hapticValuesR[2])
        case .slope:
            if(hapticValuesR[0]<hapticValuesR[1]){
                controller.rightTrigger.setModeSlopeFeedback(startPosition: hapticValuesR[0], endPosition: hapticValuesR[1], startStrength: hapticValuesR[2], endStrength: hapticValuesR[3])
            }
        case .feedbackPositional:
            controller.rightTrigger.setModeFeedback(resistiveStrengths: GCDualSenseAdaptiveTrigger.PositionalResistiveStrengths(values: (hapticValuesR[0],hapticValuesR[1],hapticValuesR[2],hapticValuesR[3],hapticValuesR[4],hapticValuesR[5],hapticValuesR[6],hapticValuesR[7],hapticValuesR[8],hapticValuesR[9])))
        case .vibrationPositional:
            controller.rightTrigger.setModeVibration(amplitudes: GCDualSenseAdaptiveTrigger.PositionalAmplitudes(values: (hapticValuesR[0],hapticValuesR[1],hapticValuesR[2],hapticValuesR[3],hapticValuesR[4],hapticValuesR[5],hapticValuesR[6],hapticValuesR[7],hapticValuesR[8],hapticValuesR[9])), frequency: hapticValuesR[10])
        }
    }
    init(item: PlaylistItem, newTimer: Float){
        id=item.id
        hapticModeL=item.hapticModeL
        hapticModeR=item.hapticModeR
        hapticValuesL=item.hapticValuesL
        hapticValuesR=item.hapticValuesR
        itemMode=item.itemMode
        timer=newTimer
    }
    init(hapticModeL : HapticType, hapticModeR: HapticType, hapticValuesL: [Float], hapticValuesR:[Float]){
        id=UUID()
        self.hapticModeL=hapticModeL
        self.hapticModeR=hapticModeR
        self.hapticValuesL=hapticValuesL
        self.hapticValuesR=hapticValuesR
        itemMode = .onTimer
        timer=1.0
    }
    var id = UUID()
    var hapticModeL : HapticType
    var hapticModeR : HapticType
    var hapticValuesL : [Float] = [Float](repeating: 0, count: 11)
    var hapticValuesR : [Float] = [Float](repeating: 0, count: 11)
    var itemMode : ItemMode = .onTimer
    var timer: Float = 1.0
}

