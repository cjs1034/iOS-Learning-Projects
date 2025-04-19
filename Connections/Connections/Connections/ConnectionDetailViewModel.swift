//
//  ConnectionDetailViewModel.swift
//  Connections
//
//  Created by Christopher Smith on 2/12/25.
//

import Foundation
import Combine
import CoreData

class ConnectionDetailViewModel: ObservableObject {
    @Published var connection: Connection
    @Published var isEditing = false
    @Published var editedName: String
    @Published var editedDetails: [String: String]
    private let coreDataManager = CoreDataManager.shared

    init(connection: Connection) {
        self.connection = connection
        self.editedName = connection.name ?? ""
        self.editedDetails = connection.details as? [String: String] ?? [:] // Correctly cast to [String: String]
    }

    func saveChanges() {
        coreDataManager.updateConnection(connection: connection, name: editedName, details: editedDetails)
        isEditing = false
        //Update the connection after saving changes
        self.connection = coreDataManager.fetchConnections().first(where: {$0.id == connection.id})! //Find the updated connection. Force unwrap only after CoreData operation.
        
    }
    
    func addDetail(key: String, value: String) {
        editedDetails[key] = value
        coreDataManager.updateConnection(connection: connection, details: editedDetails)
        //Update the connection after adding details
        self.connection = coreDataManager.fetchConnections().first(where: {$0.id == connection.id})! //Find the updated connection. Force unwrap only after CoreData operation.
        self.editedDetails = self.connection.details as? [String: String] ?? [:]
    }
    
    func deleteDetail(key: String) {
         editedDetails.removeValue(forKey: key)
        coreDataManager.updateConnection(connection: connection, details: editedDetails)
        //Update the connection after deleting details
        self.connection = coreDataManager.fetchConnections().first(where: {$0.id == connection.id})! //Find the updated connection. Force unwrap only after CoreData operation.
        self.editedDetails = self.connection.details as? [String: String] ?? [:]
     }

    func markAsContacted() {
        coreDataManager.updateConnection(connection: connection, lastContacted: Date())
        //Update the connection after marking as contacted
        self.connection = coreDataManager.fetchConnections().first(where: {$0.id == connection.id})! //Find the updated connection. Force unwrap only after CoreData operation.
    }
}
