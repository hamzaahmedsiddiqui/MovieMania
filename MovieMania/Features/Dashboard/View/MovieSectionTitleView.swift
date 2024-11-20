//
//  MovieSectionTitleView.swift
//  MovieMania
//
//  Created by hamza Ahmed on 2024-09-25.
//

import SwiftUI

struct MovieSectionTitleView: View {
    let title:String
    let fontSize:CGFloat
    var body: some View {
        Text(title)
            .foregroundColor(.white)
            .font(.system(size: fontSize, weight: .bold, design: .rounded)) // Custom font size, weight, and design
            .shadow(color: .black.opacity(0.5), radius: 2, x: 2, y: 2) // Adds a subtle shadow for depth
            .padding([.leading, .top])
    }
}


#Preview {
    MovieSectionTitleView(title: "avengers", fontSize: 15)
}
