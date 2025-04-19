//
//  GridLayout.swift
//  Moonshot
//
//  Created by Christopher Smith on 3/8/25.
//

import SwiftUI

struct GridLayout: View {
    let astronauts: [String: Astronaut] //= Bundle.main.decode("astronauts.json")
    let missions: [Mission] //= Bundle.main.decode("missions.json")
    
    let columns = [
        GridItem(.adaptive(minimum: 150))
    ]
    
//    @State private var showingGrid = true
    
    var body: some View {
        NavigationStack {
            ScrollView { //Start of scroll view
                LazyVGrid(columns: columns) {
                    ForEach(missions) { mission in
                        NavigationLink {
                            MissionView(mission: mission, astronauts: astronauts)
                        } label: {
                            VStack {
                                Image(mission.image)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 100, height: 100)
                                    .padding()

                                VStack {
                                    Text(mission.displayName)
                                        .font(.headline)
                                        .foregroundStyle(.white)
                                    Text(mission.formattedLaunchDate)
                                        .font(.caption)
                                        .foregroundStyle(.white.opacity(0.5))
                                }
                                .padding(.vertical)
                                .frame(maxWidth: .infinity)
                                .background(.lightBackground)
                            }
                            .clipShape(.rect(cornerRadius: 10))
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(.lightBackground)
                            )
                        }
                    }
                }
                .padding([.horizontal, .bottom])
            }
            .navigationTitle("Moonshot")
            .background(.darkBackground)
            .preferredColorScheme(.dark)
//            .toolbar {
//                Button("Toggle View") {
//                    showingGrid = false
//                }
//            } //End of scroll view
        }
    }
}

#Preview {
    let astronauts: [String: Astronaut] = Bundle.main.decode("astronauts.json")
    let missions: [Mission] = Bundle.main.decode("missions.json")
    
    return GridLayout(astronauts: astronauts, missions: missions)
        .preferredColorScheme(.dark)
}
