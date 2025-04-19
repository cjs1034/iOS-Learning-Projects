//
//  AddConnectionViewModel.swift
//  Connections
//
//  Created by Christopher Smith on 2/12/25.
//

import Foundation
import Combine

class AddConnectionViewModel: ObservableObject {
    @Published var name: String = ""
    @Published var details: [String: String] = [:]
    @Published var detailKey: String = ""
    @Published var detailValue: String = ""
    @Published var showingAlert = false;
    @Published var alertMessage = ""

    private let coreDataManager = CoreDataManager.shared
    
    func addDetail() {
        if (!detailKey.isEmpty && !detailValue.isEmpty) {
            details[detailKey] = detailValue
            // Clear the input fields
            detailKey = ""
            detailValue = ""
        } else {
            alertMessage = "Please provide both a key and a value for the detail."
            showingAlert = true
        }
    }
    
    func removeDetail(forKey key: String) {
         details.removeValue(forKey: key)
     }

    func addConnection() {
        if !name.isEmpty {
            let newConnection = coreDataManager.createConnection(name: name, details: details)
            //Schedule birthday notification if exists
            if (details.keys.contains("birthday")) {
                coreDataManager.scheduleBirthdayNotification(for: newConnection)
            }
            if (details.keys.contains("eventDate") && details.keys.contains("eventName")){
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "MM/dd/yyyy"  //CRITICAL: Match your date format!
                if let eventDateString = details["eventDate"], let eventDate = dateFormatter.date(from: eventDateString), let eventName = details["eventName"]{
                    coreDataManager.scheduleEventNotification(for: newConnection, eventName: eventName, eventDate: eventDate)
                }
            }
        } else {
            alertMessage = "Please provide a name for the connection."
            showingAlert = true
        }
    }
}
