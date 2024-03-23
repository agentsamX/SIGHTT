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
    @Environment(\.modelContext) private var modelContext
    @Query private var items: [Item]
    @State private var controllers:[GCController] = GCController.controllers()
    

    var body: some View {
        NavigationSplitView {
            List {
                let observerCon =  NotificationCenter.default.addObserver(forName: NSNotification.Name.GCControllerDidConnect, object: nil,queue:nil){(note) in
                    print("controller connected")
                    controllers = GCController.controllers()
                }
                let observerDis =  NotificationCenter.default.addObserver(forName: NSNotification.Name.GCControllerDidDisconnect, object: nil,queue:nil){(note) in
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
                .onDelete(perform: deleteItems)
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

    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            for index in offsets {
                modelContext.delete(items[index])
            }
        }
    }
}

#Preview {
    ContentView()
        .modelContainer(for: Item.self, inMemory: true)
}
