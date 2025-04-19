//
//  ListLayout.swift
//  Moonshot
//
//  Created by Christopher Smith on 3/8/25.
//

import SwiftUI

struct ListLayout: View {
    let astronauts: [String: Astronaut] //= Bundle.main.decode("astronauts.json")
    let missions: [Mission] //= Bundle.main.decode("missions.json")
    
    let columns = [
        GridItem(.adaptive(minimum: 150))
    ]
    
//    @State private var showingGrid = true
    
    var body: some View {
        NavigationStack {
            List { //Start of List View
                ForEach(missions) { mission in
                    NavigationLink {
                        MissionView(mission: mission, astronauts: astronauts)
                    } label: {
                        HStack {
                            Image(mission.image)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 100, height: 100)
                                .padding()
                            
                            
                            VStack {
                                Text(mission.displayName)
                                    .font(.largeTitle)
                                    .foregroundStyle(.white)
                                Text(mission.formattedLaunchDate)
                                    .font(.headline)
                                    .foregroundStyle(.white.opacity(0.7))
                            }
                            .padding(.vertical)
                            .frame(maxWidth: .infinity)
                        }
                    }
                }
                .listRowBackground(Color.darkBackground)
            }
            .navigationTitle("Moonshot")
            .background(.darkBackground)
            .preferredColorScheme(.dark)
//            .toolbar {
//                Button("Toggle View") {
//                    showingGrid = true
//                }
//            }
            .listStyle(.plain) //End of list view
        }
    }
}
#Preview {
    let astronauts: [String: Astronaut] = Bundle.main.decode("astronauts.json")
    let missions: [Mission] = Bundle.main.decode("missions.json")
    
    return ListLayout(astronauts: astronauts, missions: missions)
        .preferredColorScheme(.dark)
}
