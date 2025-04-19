//
//  Connection+CoreDataProperties.swift
//  Connections
//
//  Created by Christopher Smith on 2/12/25.
//
//

import Foundation
import CoreData


extension Connection {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Connection> {
        return NSFetchRequest<Connection>(entityName: "Connection")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var name: String?
    @NSManaged public var lastContacted: Date?
    @NSManaged public var details: NSDictionary?

}

extension Connection : Identifiable {

}
