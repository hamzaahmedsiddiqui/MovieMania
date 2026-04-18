//
//  SearchViewModel.swift
//  MovieMania
//
//  Created by hamza Ahmed on 2025-01-12.
//

import Foundation

struct SearchViewState{
    var movies:[Movie]
    var searchText:String
    var isLoading:Bool
}


class SearchViewModel: ObservableObject {
    @Published var movies:[Movie] = []
    
    init() {
    }
}
