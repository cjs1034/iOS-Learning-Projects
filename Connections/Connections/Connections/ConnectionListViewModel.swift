//
//  ConnectionListViewModel.swift
//  Connections
//
//  Created by Christopher Smith on 2/12/25.
//

import Foundation
import Combine
import CoreData

class ConnectionListViewModel: ObservableObject {
    @Published var connections: [Connection] = []
    private let coreDataManager = CoreDataManager.shared

    init() {
        fetchConnections()
    }

    func fetchConnections() {
        connections = coreDataManager.fetchConnections()
    }

    func deleteConnection(at offsets: IndexSet) {
        for index in offsets {
            let connection = connections[index]
            coreDataManager.deleteConnection(connection)
            UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: ["birthday-\(connection.id!.uuidString)"]) //Remove all scheduled notifications for connection
        }
        fetchConnections() // Refresh the list
    }
}
