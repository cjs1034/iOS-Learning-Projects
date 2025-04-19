//
//  ContentView.swift
//  ChatPrototype
//
//  Created by Christopher Smith on 1/2/25.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        HStack(spacing: 25) {
            Text("Hello, Baby Archie.")
                .padding()
                .background(Color.yellow, in: RoundedRectangle(cornerRadius: 8))
                .shadow(radius: 10)
            Text("It's your Dad!")
                .padding()
                .background(Color.teal, in: RoundedRectangle(cornerRadius: 8))
                .shadow(color: Color.teal, radius: 10, x: 5, y: 5)
            VStack {
                Text("Dad's name is Chris")
                    .padding()
                    .background(Color.blue, in: RoundedRectangle(cornerRadius: 10))
                    .shadow(color: Color.blue, radius: 5)
                Text("I love you")
                    .padding()
                    .background(Color.red, in: RoundedRectangle(cornerRadius: 10))
                    .shadow(color: Color.red, radius: 5)
            }
            
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
