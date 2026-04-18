//
//  SearchView.swift
//  MovieMania
//
//  Created by hamza Ahmed on 2025-01-07.
//

import SwiftUI

struct SearchView: View {
   // @State var searchText: String = ""
    @State private var yearOfRelease: String = ""
    @State private var region: String = ""
    @State private var searchText: String = ""
    var body: some View {
        VStack {
            //search bar
           // SearchBar(text: $searchText, placeholder: "Search...")
            MovieSearchForm(yearOfRelease: $yearOfRelease, region: $region, searchText: $searchText)
            Spacer()
        }
    }
}


#Preview {
    SearchView()
}


struct MovieSearchForm: View {
    @Binding var yearOfRelease: String
    @Binding var region: String
    @Binding var searchText: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text("Search Movies")
                .font(.headline)
                .fontWeight(.bold)
                .foregroundColor(.black)
            
            // Search Text Field
            VStack(alignment: .leading, spacing: 5) {
                Text("Search Text")
                    .font(.caption)
                    .foregroundColor(.gray)
                TextField("Enter movie name or keyword", text: $searchText)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
            }

            
            // Year of Release Field
            VStack(alignment: .leading, spacing: 5) {
                Text("Year of Release")
                    .font(.caption)
                    .foregroundColor(.gray)
                TextField("Enter year (e.g., 2024)", text: $yearOfRelease)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
            }
            
            // Region Field
            VStack(alignment: .leading, spacing: 5) {
                Text("Region")
                    .font(.caption)
                    .foregroundColor(.gray)
                TextField("Enter region (e.g., US, UK)", text: $region)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
            }
            
            
            // Search Button
            Button(action: {
                // Handle the search action
                print("Searching for \(searchText) in \(region) released in \(yearOfRelease)")
            }) {
                Text("Search")
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.blue)
                    .cornerRadius(10)
            }
        }
        .padding()
        .background(Color.gray.opacity(0.2)) // Light gray background
        .cornerRadius(15)
        .shadow(color: .black.opacity(0.1), radius: 5, x: 0, y: 2)
        .padding()
    }
}
