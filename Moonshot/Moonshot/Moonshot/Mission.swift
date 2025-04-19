//
//  Mission.swift
//  Moonshot
//
//  Created by Christopher Smith on 3/3/25.
//

import Foundation

struct Mission: Codable, Identifiable {
    struct CrewRole: Codable, Hashable {
        let name: String
        let role: String
    }
    
    let id: Int
    let launchDate: Date?
    let crew: [CrewRole]
    let description: String
    
    var displayName: String {
        "Apollo \(id)"
    }

    var image: String {
        "apollo\(id)"
    }
    
    var formattedLaunchDate: String {
        launchDate?.formatted(date: .abbreviated, time: .omitted) ?? "Did Not Launch"
    }
    
    var longFormattedLaunchDate: String {
        launchDate?.formatted(date: .long, time: .omitted) ?? "Did Not Launch"
    }
    
}

