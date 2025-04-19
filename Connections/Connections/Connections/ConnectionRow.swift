//
//  ConnectionRow.swift
//  Connections
//
//  Created by Christopher Smith on 2/12/25.
//

import SwiftUI

struct ConnectionRow: View {
    let connection: Connection

    var body: some View {
        VStack(alignment: .leading) {
            Text(connection.name ?? "Unknown")
                .font(.headline)
            Text("Last Contacted: \(connection.formattedLastContacted)")
                .font(.subheadline)
                .foregroundColor(.gray)
        }
    }
}
