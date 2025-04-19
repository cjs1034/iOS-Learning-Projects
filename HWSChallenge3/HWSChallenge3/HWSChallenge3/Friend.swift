//
//  Friend.swift
//  HWSChallenge3
//
//  Created by Christopher Smith on 4/2/25.
//

import Foundation
import SwiftData

@Model
class Friend: Codable, Identifiable, Hashable {
    enum CodingKeys: String, CodingKey {
        case id
        case name
    }
    
    var id: String
    var name: String
    
    required init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(String.self, forKey: .id)
        self.name = try container.decode(String.self, forKey: .name)
    }
    
    func encode(to encoder: any Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(self.id, forKey: .id)
        try container.encode(self.name, forKey: .name)
    }
}
