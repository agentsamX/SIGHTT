//
//  ContentView.swift
//  SIGHTT
//
//  Created by Sam Canonaco on 2024-03-22.
//

import SwiftUI
import SwiftData
import GameController
import NotificationCenter



struct ContentView: View {
    @State private var controllers:[GCController] = GCController.controllers()
    

    var body: some View {
        NavigationSplitView {
            List {
                let _ =  NotificationCenter.default.addObserver(forName: NSNotification.Name.GCControllerDidConnect, object: nil,queue:nil){(note) in
                    print("controller connected")
                    controllers = GCController.controllers()
                }
                let _ =  NotificationCenter.default.addObserver(forName: NSNotification.Name.GCControllerDidDisconnect, object: nil,queue:nil){(note) in
                    print("controller disconnected")
                    controllers = GCController.controllers()
                }
                ForEach(controllers, id: \.self) { controller in
                    NavigationLink {
                        GCDetailView(controller: controller)
                    } label: {
                        Text(controller.vendorName ?? "Unknown Controller")
                    }
                }
            }
            .navigationSplitViewColumnWidth(min: 180, ideal: 200)
            .toolbar {
                ToolbarItem {
                    Button(action: refreshControllers) {
                        Label("Refresh Controllers", systemImage: "arrow.clockwise")
                    }
                }
            }
        } detail: {
            Text("Select a Controller")
        }
    }

    private func refreshControllers(){
        withAnimation {
            let _ = print(controllers.count)
            controllers = GCController.controllers()
        }
       
    }
}

#Preview {
    ContentView()
}
