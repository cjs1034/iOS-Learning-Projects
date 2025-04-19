//
//  WelcomePage.swift
//  OnboardingFlow
//
//  Created by Christopher Smith on 1/7/25.
//

import SwiftUI

struct WelcomePage: View {
    var body: some View {
        VStack {
            ZStack {
                RoundedRectangle(cornerRadius: 30)
                    .frame(width: 150, height: 150)
                    .foregroundStyle(.tint)
                
                Image(systemName: "figure.strengthtraining.traditional")
                    .font(.system(size: 75))
                    .foregroundStyle(.white)
            }
            
            Text("Welcome to My App")
                .font(.title)
                .fontWeight(.semibold)
                .fontWidth(.expanded)
                .fontDesign(.monospaced)
                .padding(.top)
            
            Text("The CSOTC Tracking Tool for all your training needs")
                .font(.title2)
                .multilineTextAlignment(.center)
        }
        .padding()
    }
}

#Preview {
    WelcomePage()
}
