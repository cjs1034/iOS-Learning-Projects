//
//  CoreDataManager.swift
//  Connections
//
//  Created by Christopher Smith on 2/12/25.
//

import CoreData
import UIKit // Import UIKit for UIApplication

class CoreDataManager {
    static let shared = CoreDataManager() // Singleton instance

    // Persistent container (set up by Xcode when you check "Use Core Data")
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "ConnectionModel") // "ConnectionModel" should match your .xcdatamodeld file name
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Handle errors appropriately.  This is a fatal error in a real app.
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // Access the managed object context (where you work with your data)
    var viewContext: NSManagedObjectContext {
        return persistentContainer.viewContext
    }

    private init() {} // Private initializer for singleton

    // MARK: - Core Data Saving support

    func saveContext () {
        if viewContext.hasChanges {
            do {
                try viewContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }

    // MARK: - CRUD Operations (Create, Read, Update, Delete)

    // Create a new connection
    func createConnection(name: String, details: [String: String] = [:]) -> Connection {
        let newConnection = Connection(context: viewContext)
        newConnection.id = UUID()
        newConnection.name = name
        newConnection.lastContacted = Date() // Set the initial contact date
        newConnection.details = details as NSDictionary // Store details
        saveContext()
        return newConnection
    }

    // Fetch all connections
    func fetchConnections() -> [Connection] {
        let request: NSFetchRequest<Connection> = Connection.fetchRequest()
        // Sort by name (ascending)
        request.sortDescriptors = [NSSortDescriptor(key: "name", ascending: true)]

        do {
            return try viewContext.fetch(request)
        } catch {
            print("Error fetching connections: \(error)")
            return [] // Return an empty array on error
        }
    }

    // Update an existing connection
    func updateConnection(connection: Connection, name: String? = nil, details: [String: String]? = nil, lastContacted: Date? = nil) {
        if let name = name {
            connection.name = name
        }
        if let details = details {
            connection.details = details as NSDictionary // Update details
        }
        if let lastContacted = lastContacted {
            connection.lastContacted = lastContacted
        }
        saveContext()
    }
    

    // Delete a connection
    func deleteConnection(connection: Connection) {
        viewContext.delete(connection)
        saveContext()
    }
    
    func scheduleBirthdayNotification(for connection: Connection) {
        // 1.  **Extract Birthday:**  You'll need a reliable way to get the birthday.
        //     This assumes you have a "birthday" key in your `details` dictionary
        //     and that it's stored as a *string* in "MM/dd" format (e.g., "05/15").
        //     *YOU SHOULD ADAPT THIS TO YOUR DATE FORMAT.*

        guard let birthdayString = connection.details?["birthday"] as? String,
              let birthdayDate = date(from: birthdayString) else {
            print("Error: Could not get birthday for \(connection.name ?? "Unknown")")
            return
        }
        
        func date(from birthdayString: String) -> Date? {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "MM/dd"  //CRITICAL: Match your date format!
            guard let dateWithoutYear = dateFormatter.date(from: birthdayString) else {
                return nil
            }
            // Combine with current year for comparison
            let calendar = Calendar.current
            let currentYear = calendar.component(.year, from: Date())
            return calendar.date(bySetting: .year, value: currentYear, of: dateWithoutYear)
        }

        // 2.  **Calculate Notification Time:**
        let calendar = Calendar.current
        var dateComponents = calendar.dateComponents([.month, .day], from: birthdayDate)
        dateComponents.hour = 9 // Example: 9 AM notification
        dateComponents.minute = 0

        // 3. **Create Trigger:**
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true) //Repeat yearly

        // 4. **Create Request:**
        let content = UNMutableNotificationContent()
        content.title = "Birthday Reminder"
        content.body = "It's \(connection.name ?? "Unknown")'s birthday!"
        content.sound = .default

        let request = UNNotificationRequest(identifier: "birthday-\(connection.id?.uuidString ?? "")", content: content, trigger: trigger)
        
        //5. **Schedule Notification:**
        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                print("Error scheduling notification: \(error)")
            } else {
                print("Birthday notification scheduled for \(connection.name ?? "unknown")")
            }
        }
    }
    
    func scheduleEventNotification(for connection: Connection, eventName: String, eventDate: Date) {
        // 1.  **Create Trigger:**  Use a UNCalendarNotificationTrigger for date-based events.
        let calendar = Calendar.current
        let dateComponents = calendar.dateComponents([.year, .month, .day, .hour, .minute], from: eventDate)
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false) // Don't repeat one-time events.

        // 2. **Create Request:**
        let content = UNMutableNotificationContent()
        content.title = "\(eventName) Reminder"
        content.body = "Don't forget about \(eventName) with \(connection.name ?? "Unknown")!"
        content.sound = .default

        let request = UNNotificationRequest(identifier: "event-\(connection.id?.uuidString ?? String(Date().timeIntervalSince1970))", content: content, trigger: trigger) // Unique ID

        // 3. **Schedule Notification:**
        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                print("Error scheduling notification: \(error)")
            } else {
                print("Event notification scheduled for \(eventName).")
            }
        }
    }
    
    func scheduleNotificationIfContactedLongAgo() {
        let connections = fetchConnections()
        let calendar = Calendar.current
        let now = Date()

        for connection in connections {
            guard let lastContacted = connection.lastContacted else {
                // If never contacted, you might want to skip or handle differently
                continue
            }

            // Example: Check if it's been more than 3 months
            if let dateToCheck = calendar.date(byAdding: .month, value: -3, to: now),
               lastContacted < dateToCheck {

                // Schedule a notification
                let content = UNMutableNotificationContent()
                content.title = "Reconnect Reminder"
                content.body = "It's been a while since you connected with \(connection.name ?? "Unknown")."
                content.sound = .default

                // Trigger immediately for demonstration; in a real app, you might schedule
                // this for a specific time of day.
                let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
                let request = UNNotificationRequest(identifier: "reconnect-\(connection.id?.uuidString ?? String(Date().timeIntervalSince1970))", content: content, trigger: trigger)

                UNUserNotificationCenter.current().add(request) { error in
                    if let error = error {
                        print("Error scheduling reconnect notification: \(error)")
                    } else {
                        print("Reconnect scheduled")
                    }
                }
            }
        }
    }
}
