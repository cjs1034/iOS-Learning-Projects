//
//  FeaturesPage.swift
//  OnboardingFlow
//
//  Created by Christopher Smith on 1/8/25.
//

import SwiftUI

struct FeaturesPage: View {
    var body: some View {
        VStack (spacing: 30) {
            Text("Features")
                .font(.title)
                .fontWeight(.semibold)
                .padding(.bottom)
                .padding(.top, 100)
            
            FeatureCard(iconName: "figure", description: "Track your all your training through our multisport app")
            
            FeatureCard(iconName: "figure.cross.training", description: "Explosiveness")
        
            Spacer()
        }
        .padding()
        
    }
}

#Preview {
    FeaturesPage()
        .frame(maxHeight: .infinity)
        .background(Gradient(colors: gradientColors))
        .foregroundStyle(.white)
}
