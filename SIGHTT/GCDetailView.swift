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
    var body: some View {
        HStack
        {
            VStack(alignment: .leading){
                Text("Name: " + (controller.vendorName ?? "Unknown Controller"))
                Text("Input Profile: " + controller.physicalInputProfile.className)
            }
            
            VStack(content: {
                
            })
        }
    }
}

#Preview {
    Text("Hello, World!")
}
