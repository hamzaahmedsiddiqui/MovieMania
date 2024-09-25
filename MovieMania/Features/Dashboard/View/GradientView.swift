//
//  GradientView.swift
//  MovieMania
//
//  Created by hamza Ahmed on 2024-09-25.
//

import SwiftUI

struct GradientView: View {
    let firstColor: Color
    let secondColor:Color
    let thirdColor:Color
    var body: some View {
        LinearGradient(
            gradient: Gradient(colors: [firstColor, secondColor, thirdColor]),
            startPoint: .topLeading,
            endPoint: .bottomTrailing
        )
        .edgesIgnoringSafeArea(.all)
    }
}

//#Preview {
//    GradientView()
//}
