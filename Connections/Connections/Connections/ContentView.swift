//
//  ContentView.swift
//  Connections
//
//  Created by Christopher Smith on 2/12/25.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = ConnectionListViewModel()
    @State private var showingAddConnectionView = false
    
    init() {
         // Schedule the periodic check when the app starts
         CoreDataManager.shared.scheduleNotificationIfContactedLongAgo()
     }

    var body: some View {
        NavigationView {
            List {
                ForEach(viewModel.connections, id: \.id) { connection in
                    NavigationLink(destination: ConnectionDetailView(viewModel: ConnectionDetailViewModel(connection: connection))) {
                        ConnectionRow(connection: connection)
                    }
                }
                .onDelete(perform: viewModel.deleteConnection)
            }
            .navigationTitle("Connections")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        showingAddConnectionView = true
                    }) {
                        Image(systemName: "plus")
                    }
                }
            }
            .sheet(isPresented: $showingAddConnectionView) {
                AddConnectionView().environmentObject(viewModel)
            }
        }
    }
}
